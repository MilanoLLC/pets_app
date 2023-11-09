import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/model/ServiceModel.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';

abstract class IShopRepository {
  Future<List<ServiceModel>> getAllServicesByTyp(type);
  // Future<List<AnimalModel>> getAllAnimals(pageNumber, pageSize);
  // Future subscribe(req);
  // Future filterAnimals(age, color, friendly, gender, location, vaccinated);
}

class ShopRepository extends IShopRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  // /api/providers/getAllServicesByType?serviceType=GOODS
  @override
  Future<List<ServiceModel>> getAllServicesByTyp(type) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get('api/providers/getAllServicesByType?serviceType=$type');

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    var services =
        (response.body as List).map((e) => ServiceModel.fromJson(e)).toList();

    return services;
  }

  // @override
  // Future<List<AnimalModel>> getAllAnimals(pageNumber, pageSize) async {
  //   var result = await InternetConnectionChecker().hasConnection;
  //   if (!result) {
  //     throw const SocketException("No Internet Connection");
  //   }
  //   final response = await httpService
  //       .get('api/animals/all?pageNumber=$pageNumber&pageSize=$pageSize');
  //
  //   if (response.hasError || response.unauthorized) {
  //     throw SocketException(response.body['message']);
  //   }
  //   var animals =
  //       (response.body as List).map((e) => AnimalModel.fromJson(e)).toList();
  //
  //   return animals;
  // }
  //
  // @override
  // Future subscribe(req) async {
  //   var result = await InternetConnectionChecker().hasConnection;
  //   if (!result) {
  //     throw const SocketException("No Internet Connection");
  //   }
  //   final response = await httpService.post('Accounts/Subscribe', req);
  //
  //   if (response.hasError || response.unauthorized) {
  //     throw SocketException(response.body['message']);
  //   }
  //   return response;
  // }
  //
  // @override
  // Future filterAnimals(
  //     age, color, friendly, gender, location, vaccinated) async {
  //   var result = await InternetConnectionChecker().hasConnection;
  //
  //   if (!result) {
  //     throw const SocketException("No Internet Connection");
  //   }
  //
  //   final response = await httpService.post(
  //       'api/animals/filter?age=$age&color=$color&friendly=$friendly&gender=$gender&location=$location&vaccinated=$vaccinated',
  //       {});
  //
  //   if (response.hasError || response.unauthorized) {
  //     throw SocketException(response.body['message']);
  //   }
  //
  //   return response;
  // }
}
