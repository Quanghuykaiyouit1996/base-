// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:global_configuration/global_configuration.dart';
// import 'package:smb_builder_web_client/main.dev.dart';
// import 'package:smb_builder_web_client/pages/buildings/create_or_add/components/image.list.dart';
// import 'package:smb_builder_web_client/pages/login/auth.service.dart';
// import 'package:smb_builder_web_client/pages/shared/fake_data/building.type.fake.dart';
// import 'package:smb_builder_web_client/pages/store/store.service.dart';

// class ServiceProvider {
//   String? baseUrl = GlobalConfiguration().get('base_url');

//   Dio dio = Dio();

//   Future<Response> addService() async {
//     var token = await AuthService().getToken();
//     var shopModel = await StoreService().getLastShopFromStorage();
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-Suplo-Shop-Id': '${shopModel?.id}'
//     };
//     return dio.request('$baseUrl/admin/services',
//         options: Options(headers: headers, method: 'GET'));
//   }

//   Future<Response> addNewService(
//       List<String> images,
//       String type,
//       String name,
//       String price,
//       String unit,
//       String description,
//       RxList<String> listTag) async {
//     var token = await AuthService().getToken();
//     var shopModel = await StoreService().getLastShopFromStorage();
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-Suplo-Shop-Id': '${shopModel?.id}'
//     };
//     try {
//       var response = await dio.request('$baseUrl/admin/services',
//           options: Options(headers: headers, method: 'POST'),
//           data: {
//             'images': images,
//             'tags': listTag.map((element) => element).toList(),
//             'type': type,
//             'unit': unit,
//             'price': int.tryParse(price),
//             'name': name,
//             'description': description,
//           });
//       return response;
//     } on DioError catch (e) {
//       print(e.toString());
//       return Response(
//           requestOptions: RequestOptions(path: ''), statusCode: 400);
//     }
//   }

//   Future<Response> updateService(
//       List<String> images,
//       String type,
//       String name,
//       String price,
//       String unit,
//       String description,
//       RxList<String> listTag,
//       String? serviceID) async {
//     var token = await AuthService().getToken();
//     var shopModel = await StoreService().getLastShopFromStorage();
//     var headers = {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//       'X-Suplo-Shop-Id': '${shopModel?.id}'
//     };
//     print(jsonEncode(headers));
//     print(serviceID);
//     print(jsonEncode({
//       'images': images,
//       'tags': listTag.map((element) => element).toList(),
//       'type': type,
//       'unit': unit,
//       'price': int.tryParse(price),
//       'name': name,
//       'description': description,
//     }));
//     try {
//       var response = await dio.request('$baseUrl/admin/services/$serviceID',
//           options: Options(headers: headers, method: 'PATCH'),
//           data: {
//             'images': images,
//             'tags': listTag.map((element) => element).toList(),
//             'type': type,
//             'unit': unit,
//             'price': int.tryParse(price),
//             'name': name,
//             'description': description,
//           });
//       return response;
//     } on DioError catch (e) {
//       print(e.response.toString());
//       return Response(
//           requestOptions: RequestOptions(path: ''), statusCode: 400);
//     }
//   }
// }
