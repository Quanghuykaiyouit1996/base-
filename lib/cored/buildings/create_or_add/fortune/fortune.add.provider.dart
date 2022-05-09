// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:global_configuration/global_configuration.dart';
// import 'package:smb_builder_web_client/main.dev.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/components/image.list.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/fortune/fortune.add.controller.dart';
// import 'package:smb_builder_web_client/pages/login/auth.service.dart';
// import 'package:smb_builder_web_client/pages/shared/fake_data/building.type.fake.dart';
// import 'package:smb_builder_web_client/pages/store/store.service.dart';

// class FortuneProvider {
//   String? baseUrl = GlobalConfiguration().get('base_url');

//   Dio dio = Dio();

//   Future<Response> getProductFortunes(String searchText) async {
//     var token = await AuthService().getToken();
//     var shopModel = await StoreService().getLastShopFromStorage();
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-Suplo-Shop-Id': '${shopModel?.id}'
//     };
//     print({
//       if (searchText.isNotEmpty) 'q': searchText,
//     });
//     try {
//       var response = dio.request('$baseUrl/admin/services',
//           options: Options(headers: headers, method: 'GET'),
//           queryParameters: {
//             'type': 'Tài sản',
//             if (searchText.isNotEmpty) 'q': searchText,
//             'skip': 0,
//             'take': 10,
//           });
//       return response;
//     } on DioError catch (e) {
//       print(e.response?.data.toString());
//       return Response(
//           requestOptions: RequestOptions(path: ''),
//           statusCode: 400,
//           data: {'error': e.response?.data});
//     }
//   }

//   Future<Response> addFortune(
//       List<String?> serviceId, String buildingId, TypeContant value) async {
//     var token = await AuthService().getToken();
//     var shopModel = await StoreService().getLastShopFromStorage();
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-Suplo-Shop-Id': '${shopModel?.id}'
//     };
//     print(jsonEncode({
//       'serviceIds': serviceId,
//     }));
//     print(buildingId);
//     print(
//         '$baseUrl/admin/${value == TypeContant.building ? 'buildings' : 'rooms'}/$buildingId/services');
//     try {
//       var response = await dio.request(
//           '$baseUrl/admin/${value == TypeContant.building ? 'buildings' : 'rooms'}/$buildingId/services',
//           options: Options(headers: headers, method: 'POST'),
//           data: {
//             'serviceIds': serviceId,
//           });
//       return response;
//     } on DioError catch (e) {
//       print(e.response.toString());
//       return Response(
//           requestOptions: RequestOptions(path: ''), statusCode: 400);
//     }
//   }
// }
