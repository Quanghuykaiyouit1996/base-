import 'package:get/get.dart';

import 'cored/auth/auth.controller.dart';
import 'utils/helpes/constant.dart';
import 'utils/service/my.connect.dart';

class AddressProvider extends MyConnect {
  AddressProvider();

  AuthController authController = Get.find(tag: 'authController');

  Future<Response> getCity() => request(
        '${Constant.baseUrl}/cities',
        'GET',
        contentType: 'text/html',
      );

  Future<Response> getDistrict(int? cityId) => request(
        '${Constant.baseUrl}/districts?cityId=$cityId',
        'GET',
        contentType: 'text/html',
      );

  Future<Response> getWard(int? districtId) => request(
        '${Constant.baseUrl}/wards?districtId=$districtId',
        'GET',
        contentType: 'text/html',
      );
}
