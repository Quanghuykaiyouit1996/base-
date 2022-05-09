import 'dart:io';

import 'package:get/get.dart';
import 'package:base/config/pages/app.page.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/models/contract.model.dart';
import 'package:base/models/review.model.dart';
import 'package:base/utils/helpes/convert.dart';
import 'package:base/utils/helpes/utilities.dart';
import 'package:base/widgets/dialog.widget.dart';
import 'package:base/widgets/image.list.dart';

import 'contract.detail.provider.dart';

class ContractDetailController extends GetxController {
  final Rx<Contracts> contract = Contracts().obs;

  TypeListBill type = TypeListBill.all;
  final RxBool isHaveReviewRoom = false.obs;
  final RxBool isHaveReviewBuilding = false.obs;
  String? contractId;
  final RxBool canExtend = false.obs;
  late ImageListController imageReceiveRoomController;
  late ImageListController imageCheckoutRoomController;
  late ImageListController imagePaymentRoomController;
  final RxList<String> imagesReceiveRoomLink = <String>[].obs;
  final RxList<String> imagesCheckOutRoomLink = <String>[].obs;
  final RxList<String> imagesPaymentRoomLink = <String>[].obs;
  final ContractDetailProvider provider = ContractDetailProvider();
  final AuthController authController = Get.find(tag: 'authController');

  @override
  void onInit() {
    super.onInit();
    imageReceiveRoomController = ImageListController(
        <String>[].obs, <File>[].obs, imagesReceiveRoomLink, 100);
    imageCheckoutRoomController = ImageListController(
        <String>[].obs, <File>[].obs, imagesCheckOutRoomLink, 100);
    imagePaymentRoomController = ImageListController(
        <String>[].obs, <File>[].obs, imagesPaymentRoomLink, 100);
    contract.listen((p0) {
      getReview();
      updateIsExtensions();
    });
    if (Get.arguments is String) {
      contractId = Get.arguments;
      getContract();
    } else if (Get.arguments is Contracts) {
      contractId = (Get.arguments as Contracts).id;
      getContract();
    }
  }

  void getContract() async {
    Utilities.updateLoading(true);
    var response = await provider.getContract(contractId);
    Utilities.updateLoading(false);

    if (response.isOk && response.body != null) {
      var contractModel = Contracts.fromJson(response.body['contract']);

      contract.value = contractModel;
      imagesCheckOutRoomLink.clear();
      imagesPaymentRoomLink.clear();
      imagesReceiveRoomLink.clear();

      if (contract.value.imageReceiveRoom.isNotEmpty) {
        imagesReceiveRoomLink.addAll(contract.value.imageReceiveRoom);
      }
      if (contract.value.imageCheckout.isNotEmpty) {
        imagesCheckOutRoomLink.addAll(contract.value.imageCheckout);
      }
      if (contract.value.imagePayment.isNotEmpty) {
        imagesPaymentRoomLink.addAll(contract.value.imagePayment);
      }
    }
    update();
  }

  void getReview() async {
    var response = await provider.getReview(contract.value.id);
    if (response.isOk &&
        response.body != null &&
        response.body is Map &&
        response.body.isNotEmpty) {
      if (response.body['roomReview'] != null) {
        var roomModel = Review.fromJson(response.body['roomReview']);
        if (roomModel.id != null) {
          isHaveReviewRoom.value = true;
        }
      }
      if (response.body['buildingReview'] != null) {
        var buildingModel = Review.fromJson(response.body['buildingReview']);
        if (buildingModel.id != null) {
          isHaveReviewBuilding.value = true;
        }
      }
    }
  }

  void updateIsExtensions() {
    var endTime = Convert.stringToDate(contract.value.endAt ?? '',
        pattern: 'yyyy-MM-ddTHH:mm');
    var startTime = Convert.stringToDate(contract.value.startAt ?? '',
        pattern: 'yyyy-MM-ddTHH:mm');
    var haftTime =
        (endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch) ~/
            2;
    var timeCompare = startTime.millisecondsSinceEpoch + haftTime;
    var dateHalfTimeCompare = DateTime.fromMillisecondsSinceEpoch(timeCompare);
    var dateCompare = Convert.stringToDate(contract.value.endAt ?? '',
            pattern: 'yyyy-MM-ddTHH:mm')
        .subtract(const Duration(days: 35));
    if (dateCompare.isAfter(DateTime.now()) &&
        dateHalfTimeCompare.isBefore(DateTime.now()) &&
        (contract.value.extensions != null &&
            !contract.value.extensions!.any((element) =>
                element.status == 'pending' || element.status == 'accepted'))) {
      canExtend.value = true;
    } else {
      canExtend.value = false;
    }
  }

  void review() {
    Get.dialog(CustomChooseDialog(
        hasClose: true,
        hasCloseButton: false,
        acceptFunction: () async {
          await Get.toNamed(Routes.REVIEWEDIT,
              arguments: [contract.value.id, contract.value.buildingId, null]);
          getReview();
          Get.back();
        },
        disAbleCloseButton: isHaveReviewRoom.value,
        contentCloseButton: isHaveReviewRoom.value ? 'Đã đánh giá' : 'Chọn',
        titleCloseButton: 'Phòng',
        titleAcceptButton: 'Quản lý tòa nhà',
        contentAcceptButton: 'Chọn',
        closeFunction: () async {
          if (!isHaveReviewRoom.value) {
            await Get.toNamed(Routes.REVIEWEDIT,
                arguments: [contract.value.id, null, contract.value.roomId]);
            getReview();
            Get.back();
          }
        },
        title: 'Chọn đối tượng đánh giá',
        description: ''));
  }
}

enum TypeListBill { inContract, all }
