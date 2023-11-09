

import 'dart:collection';

import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/helpers/global_data.dart';
import 'package:pets_app/service_locator.dart';

import 'local_storage_service.dart';
import 'package:get/get_connect/connect.dart';

class HttpService extends GetConnect {
  var storage = getIt<ILocalStorageService>();
  Map<String, String> headers =  HashMap();


  HttpService() {

    httpClient.baseUrl = Api_Url;
    final token = storage.get(STORAGE_KEYS.token);
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'Bearer $token';


    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "Bearer $token";
      // print("http headers= "+request.headers.toString());

      return request;
    });
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(minutes: 3);
  }

  void assignToken(String token) {
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
  }

  Future<dynamic> getFromWeb(String url) {
    httpClient.baseUrl = null;
    var result = httpClient.get(url);
    httpClient.baseUrl = Api_Url;
    return result;
  }
}
