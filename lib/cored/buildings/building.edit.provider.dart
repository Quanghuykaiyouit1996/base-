import 'dart:convert';

import 'package:get/get.dart';
import 'package:base/cored/auth/auth.controller.dart';
import 'package:base/cored/fake_data/building.type.fake.dart';
import 'package:base/utils/helpes/constant.dart';
import 'package:base/utils/service/my.connect.dart';

class BuildingProvider extends MyConnect {
  final authController = Get.find<AuthController>(tag: 'authController');

  Future<Response> getBuildings(
          [int? cityId,
          int? districtId,
          int? wardId,
          String searchText = '',
          int take = 20,
          int skip = 0]) =>
      request('${Constant.baseUrl}/admin/buildings', 'GET',
          headers: authController.getHeader,
          query: {
            if (cityId != null) 'cityId': cityId.toString(),
            if (districtId != null && cityId != null)
              'districtId': districtId.toString(),
            if (wardId != null && districtId != null && cityId != null)
              'wardId': wardId.toString(),
            if (searchText.isNotEmpty) 'q': searchText,
            'skip': skip.toString(),
            'take': take.toString(),
          });

  Future<Response> getAllBuildings(int? cityId, int? districtId, int? wardId) =>
      request('${Constant.baseUrl}/admin/buildings', 'GET',
          headers: authController.getHeader,
          query: {
            if (cityId != null) 'cityId': cityId,
            if (districtId != null && cityId != null) 'districtId': districtId,
            if (wardId != null && districtId != null && cityId != null)
              'wardId': wardId,
          });

  Future<Response> getBuilding(String? buildingId) =>
      request('${Constant.baseUrl}/admin/buildings/$buildingId', 'GET',
          headers: authController.getHeader);

  Future<Response> getBuildingType() async {
    return Future.value(Response(
      statusCode: 200,
      body: {'results': fakeBuildingType},
    ));
  }

  Future<Response> getListService([String? shortString]) =>
      request('${Constant.baseUrl}/admin/services', 'GET',
          headers: authController.getHeader,
          query: {
            if (shortString != null && shortString.isNotEmpty)
              'type': shortString,
          });

  Future<Response> changeDataBuilding(
          RxList<String> imageLink,
          List<String> listTag,
          List<String> listIdServiceChoose,
          String name,
          String ownerName,
          String ownerPhone,
          String ownerMail,
          String address,
          String floor,
          String room,
          String floorArea,
          String area,
          String dateElectric,
          String datePayCost,
          String? type,
          String description,
          String? buildingId) =>
      request('${Constant.baseUrl}/admin/buildings/$buildingId', 'PATCH',
          headers: authController.getHeader,
          body: {
            'images': imageLink.map((element) => element).toList(),
            'tags': listTag.map((element) => element).toList(),
            'serviceIds': listIdServiceChoose,
            'name': name,
            'owner': {
              'name': ownerName,
              'phoneNumber': ownerPhone,
              'email': ownerMail
            },
            'floorCount': int.tryParse(floor),
            'roomCount': int.tryParse(room),
            'totalArea': int.tryParse(area),
            'floorArea': int.tryParse(floorArea),
            'utilitiesBillSettleDate': int.tryParse(dateElectric),
            'rentalBillSettleDate': int.tryParse(datePayCost),
            'type': type,
            'description': description
          });

  // Future<Response> addBuilding(
  //     RxList<String> imageLink,
  //     List<String> listTag,
  //     List<String> listIdServiceChoose,
  //     String name,
  //     String ownerName,
  //     String ownerPhone,
  //     String ownerMail,
  //     Rx<LocationDetail> district,
  //     Rx<LocationDetail> ward,
  //     String address,
  //     String floor,
  //     String room,
  //     String floorArea,
  //     String area,
  //     String dateElectric,
  //     String datePayCost,
  //     String? type,
  //     String description) async {
  //   var token = await AuthService().getToken();
  //   var shopModel = await StoreService().getLastShopFromStorage();
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'X-Suplo-Shop-Id': '${shopModel?.id}'
  //   };
  //   try {
  //     var response = await dio.request('$baseUrl/admin/buildings',
  //         options: Options(headers: headers, method: 'POST'),
  //         data: {
  //           'images': imageLink.map((element) => element).toList(),
  //           'tags': listTag.map((element) => element).toList(),
  //           'serviceIds': listIdServiceChoose,
  //           'name': name,
  //           'owner': {
  //             'name': ownerName,
  //             'phoneNumber': ownerPhone,
  //             'email': ownerMail
  //           },
  //           'address': {
  //             'districtId': district.value.id,
  //             'wardId': ward.value.id,
  //             'address1': address
  //           },
  //           'floorCount': int.tryParse(floor),
  //           'roomCount': int.tryParse(room),
  //           'totalArea': double.tryParse(area),
  //           'floorArea': double.tryParse(floorArea),
  //           'utilitiesBillSettleDate': int.tryParse(dateElectric),
  //           'rentalBillSettleDate': int.tryParse(datePayCost),
  //           'type': type,
  //           'description': description
  //         });
  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response?.data.toString());
  //     return Response(
  //         requestOptions: RequestOptions(path: ''),
  //         statusCode: 400,
  //         data: {'error': e.response});
  //   }
  // }

  // Future<Response> changeDataBuilding(
  //     RxList<String> imageLink,
  //     List<String> listTag,
  //     List<String> listIdServiceChoose,
  //     String name,
  //     String ownerName,
  //     String ownerPhone,
  //     String ownerMail,
  //     String address,
  //     String floor,
  //     String room,
  //     String floorArea,
  //     String area,
  //     String dateElectric,
  //     String datePayCost,
  //     String? type,
  //     String description,
  //     String? buildingId) async {
  //   var token = await AuthService().getToken();
  //   var shopModel = await StoreService().getLastShopFromStorage();
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'X-Suplo-Shop-Id': '${shopModel?.id}'
  //   };
  //   print(buildingId);
  //   try {
  //     var response = await dio.request('$baseUrl/admin/buildings/$buildingId',
  //         options: Options(headers: headers, method: 'PATCH'),
  //         data: {
  //           'images': imageLink.map((element) => element).toList(),
  //           'tags': listTag.map((element) => element).toList(),
  //           'serviceIds': listIdServiceChoose,
  //           'name': name,
  //           'owner': {
  //             'name': ownerName,
  //             'phoneNumber': ownerPhone,
  //             'email': ownerMail
  //           },
  //           'floorCount': int.tryParse(floor),
  //           'roomCount': int.tryParse(room),
  //           'totalArea': int.tryParse(area),
  //           'floorArea': int.tryParse(floorArea),
  //           'utilitiesBillSettleDate': int.tryParse(dateElectric),
  //           'rentalBillSettleDate': int.tryParse(datePayCost),
  //           'type': type,
  //           'description': description
  //         });

  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response?.data.toString());
  //     return Response(
  //         requestOptions: RequestOptions(path: ''),
  //         statusCode: 400,
  //         data: {'error': e.response});
  //   }
  // }

  // Future<Response> hiddenBuilding(String? buildingId, bool hidden) async {
  //   var token = await AuthService().getToken();
  //   var shopModel = await StoreService().getLastShopFromStorage();
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'X-Suplo-Shop-Id': '${shopModel?.id}'
  //   };
  //   try {
  //     var response = await dio.request('$baseUrl/admin/buildings/$buildingId',
  //         options: Options(headers: headers, method: 'PATCH'),
  //         data: {
  //           'hidden': hidden,
  //         });

  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response?.data.toString());
  //     return Response(
  //         requestOptions: RequestOptions(path: ''),
  //         statusCode: 400,
  //         data: {'error': e.response});
  //   }
  // }

  // Future<Response> getRoom(String? roomId) async {
  //   var token = await AuthService().getToken();
  //   var shopModel = await StoreService().getLastShopFromStorage();
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //     'X-Suplo-Shop-Id': '${shopModel?.id}'
  //   };
  //   print(jsonEncode(headers));
  //   try {
  //     var response = dio.request(
  //       '$baseUrl/admin/rooms/$roomId',
  //       options: Options(headers: headers, method: 'GET'),
  //     );
  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response?.data.toString());
  //     return Response(
  //         requestOptions: RequestOptions(path: ''),
  //         statusCode: 400,
  //         data: {'error': e.response?.data});
  //   }
  // }
}
