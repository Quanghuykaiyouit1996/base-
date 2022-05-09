import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/utils/service/my.connect.dart';
import '../../utils/helpes/constant.dart';

class FileProvider extends MyConnect {
  final authController = Get.find<AuthController>(tag: 'authController');

  Future<Response> getAppointmentHome(
          {int? skip,
          int? take,
          String? branchId,
          String? query,
          String? sort}) =>
      request(
          '${Constant.baseUrl}/admin/orders?skip=${skip ?? 0}&take=${take ?? 20}&sort=${sort ?? "create-desc"}',
          'GET',
          headers: authController.getHeader);

  Future<Response> uploadImage(String? data, double? width, double? height) =>
      request('${Constant.baseUrl}/images', 'POST',
          body: {'attachment': data, 'width': width, 'height': height},
          headers: authController.getHeader);
}
