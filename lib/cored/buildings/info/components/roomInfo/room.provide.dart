import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class RoomProvider extends MyConnect {
  final authController = Get.find<AuthController>(tag: 'authController');

  // Future<Response> getRoom([int? buildingId, int take = 20, int skip = 0]) =>
  //     request('${Constant.baseUrl}/admin/rooms', 'GET',
  //         headers: authController.getHeader,
  //         query: {
  //           if (buildingId != null) 'buildingId': buildingId.toString(),
  //           'skip': skip.toString(),
  //           'take': take.toString(),
  //         });

  Future<Response> getAllRoom(String? buildingId) =>
      request('${Constant.baseUrl}/admin/rooms', 'GET',
          headers: authController.getHeader,
          query: {
            if (buildingId != null) 'buildingId': buildingId,
          });
}
