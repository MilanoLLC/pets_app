import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';

abstract class IAdoptionRepository {
  Future<int> adopt(serial);
}

class AdoptionRepository extends IAdoptionRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future<List<AnimalModel>> getMyAnimals() async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get('api/animals/myAnimals',
        headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    var animals =
        (response.body as List).map((e) => AnimalModel.fromJson(e)).toList();

    return animals;
  }

  @override
  Future delete(animalSerial) async {
    final response = await httpService.delete(
        'api/animals?animalSerial=$animalSerial',
        headers: httpService.headers);
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    return response;
  }

  @override
  Future<int> adopt(serial) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.post(
        'api/adoption/submit?animalSerial=$serial', "",
        headers: httpService.headers);
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    return response.statusCode!;
  }
}
