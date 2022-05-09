import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect.dart';

class MyConnect extends GetConnect {
  @override
  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    assert(actionInDebug(method, body, headers, url));
    return super.request(
      url,
      method,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  bool actionInDebug(
      String method, body, Map<String, String>? headers, String url) {
    try {
      log('''MYCONNECT:''');
      log('''MYCONNECT1:''');
      log('MYCONNECT: $method : url: ${jsonEncode(url)}');
      log('MYCONNECT: $method : data: ${jsonEncode(body)}');
      log('MYCONNECT: $method : header: ${headers.toString()}');
    } catch (e) {
      print(e);
    }
    return true;
  }
}
