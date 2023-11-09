import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/model/CategoryModel.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';

abstract class IHomeRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<AnimalModel>> getAllAnimals(pageNumber, pageSize);
  Future subscribe(req);
  Future filterAnimals(age, color, friendly, gender, location, vaccinated);
}

class HomeRepository extends IHomeRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<List<CategoryModel>> getCategories() async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get('api/animalCategory/catsList');

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    var categories =
        (response.body as List).map((e) => CategoryModel.fromJson(e)).toList();

    return categories;
  }

  @override
  Future<List<AnimalModel>> getAllAnimals(pageNumber, pageSize) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService
        .get('api/animals/all?pageNumber=$pageNumber&pageSize=$pageSize');

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    var animals =
        (response.body as List).map((e) => AnimalModel.fromJson(e)).toList();

    return animals;
  }

  @override
  Future subscribe(req) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.post('Accounts/Subscribe', req);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future filterAnimals(
      age, color, friendly, gender, location, vaccinated) async {
    var result = await InternetConnectionChecker().hasConnection;

    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.post(
        'api/animals/filter?age=$age&color=$color&friendly=$friendly&gender=$gender&location=$location&vaccinated=$vaccinated',
        {});

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    return response;
  }
}
