import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/UserModel.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';

abstract class IAuthRepository {
  Future<bool> login(String user, String pass);
  Future<UserModel> getUserInfoByToken();
  Future<int> register(
      countryPhoneCode, email, firstName, lastName, password, phone, userName);
  Future<int> modify(firstName, lastName, phone, countryPhoneCode);
  Future saveAddress(
      additionalInstructions, apartmentNumber, building, city, street);
}

class AuthRepository extends IAuthRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<bool> login(String user, String pass) async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.post('api/auth/signin', {
      'password': pass,
      'username': user,
    });
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    if (response.statusCode == 200) {
      storage.set(STORAGE_KEYS.token, response.body['token']);
      // storage.set(STORAGE_KEYS.employeeCode, employeeCode);
      storage.set(STORAGE_KEYS.userName, response.body['username']);
      storage.set(STORAGE_KEYS.fullName, response.body['fullName']);
      // storage.set(STORAGE_KEYS.enableOfflineCheck,
      //     response.body['enableOfflineCheckIn']);
      // storage.set(STORAGE_KEYS.deleted, response.body['deleted']);
      // storage.set(STORAGE_KEYS.disabled, response.body['disabled']);
      // storage.set(STORAGE_KEYS.passcode.toString(), response.body['passCode']);
      // storage.set(STORAGE_KEYS.companyId.toString(), response.body['companyId']);
      httpService.assignToken(response.body['token']);
      return true;
    }
    return false;
  }

  @override
  Future<int> register(countryPhoneCode, email, firstName, lastName, password,
      phone, userName) async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.post('api/auth/signup', {
      "countryPhoneCode": countryPhoneCode,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "phoneNumber": phone,
      "roles": [],
      "username": userName
    });

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    return response.statusCode!;
  }

  @override
  Future<UserModel> getUserInfoByToken() async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.get('api/auth/userInfo',headers: httpService.headers);
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    var user = UserModel.fromJson(response.body);

    return user;
  }

  @override
  Future<int> modify(firstName, lastName, phone, countryPhoneCode) async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.put('api/auth/modify', {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phone,
      "countryPhoneCode": countryPhoneCode,
    },headers: httpService.headers);
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    return response.statusCode!;
  }

  @override
  Future saveAddress(
      additionalInstructions, apartmentNumber, building, city, street) async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.put('api/auth/adressInfo', {
      "additionalInstructions": additionalInstructions,
      "apartmentNumber": apartmentNumber,
      "building": building,
      "city": city,
      "street": street
    },headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }
}
