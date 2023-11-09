import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/helpers/global_data.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

abstract class IAnimalRepository {
  Future saveAnimal(
      gender,
      color,
      friendly,
      agePrefix,
      origin,
      catSerial,
      weight,
      description,
      type,
      vaccinated,
      passport,
      noOfVaccines,
      location,
      animalName,
      age,
      images);
  Future<List<AnimalModel>> getMyAnimals();
  Future delete(animalSerial);
  Future editAnimal(
      serial,
      gender,
      color,
      friendly,
      agePrefix,
      origin,
      catSerial,
      weight,
      description,
      type,
      vaccinated,
      passport,
      noOfVaccines,
      location,
      animalName,
      age,
      images);
  Future<AnimalModel> getAnimalBySerial(serial);
}

class AnimalRepository extends IAnimalRepository {
  var httpService = getIt<HttpService>();
  var storage = getIt<ILocalStorageService>();

  @override
  Future saveAnimal(
      gender,
      color,
      friendly,
      agePrefix,
      origin,
      catSerial,
      weight,
      description,
      type,
      vaccinated,
      passport,
      noOfVaccines,
      location,
      animalName,
      age,
      images) async {
    Uri uri = Uri.parse("${Api_Url}api/animals");
    final request = http.MultipartRequest('POST', uri);
    final token = storage.get(STORAGE_KEYS.token);
    request.headers['Authorization'] = "Bearer $token";
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        String fileName = images![i].path.split('/').last;
        final file = await http.MultipartFile.fromPath(
          'images',
          images[i]!.path,
          filename: fileName,
        );
        request.files.add(file);
      }
    }
    request.fields["gender"] = gender;
    request.fields["color"] = color;
    request.fields["friendly"] = friendly;
    request.fields["agePrefix"] = agePrefix;
    request.fields["origin"] = origin;
    request.fields["catSerial"] = catSerial;
    request.fields["weight"] = weight;
    request.fields["description"] = description;
    request.fields["type"] = type;
    request.fields["vaccinated"] = vaccinated;
    request.fields["passport"] = passport;
    request.fields["noOfVaccines"] = noOfVaccines;
    request.fields["location"] = location;
    request.fields["animalName"] = animalName;
    request.fields["age"] = age;
    var response = await request.send();
    return response;
  }

  @override
  Future editAnimal(
      serial,
      gender,
      color,
      friendly,
      agePrefix,
      origin,
      catSerial,
      weight,
      description,
      type,
      vaccinated,
      passport,
      noOfVaccines,
      location,
      animalName,
      age,
      images) async {
    Uri uri = Uri.parse("${Api_Url}api/animals/update");
    final request = http.MultipartRequest('POST', uri);
    final token = storage.get(STORAGE_KEYS.token);
    request.headers['Authorization'] = "Bearer $token";
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        String fileName = images![i].path.split('/').last;
        final file = await http.MultipartFile.fromPath(
          'images',
          images[i]!.path,
          filename: fileName,
        );
        request.files.add(file);
      }
    }
    request.fields["age"] = age;
    request.fields["agePrefix"] = agePrefix;
    request.fields["animalName"] = animalName;
    request.fields["animalSerial"] = serial;
    request.fields["catSerial"] = catSerial;
    request.fields["color"] = color;
    request.fields["description"] = description;

    //dop
    request.fields["friendly"] = friendly;
    request.fields["gender"] = gender;

    //images
    request.fields["location"] = location;
    request.fields["noOfVaccines"] = noOfVaccines;
    request.fields["origin"] = origin;
    request.fields["passport"] = passport;
    request.fields["type"] = type;
    request.fields["vaccinated"] = vaccinated;
    request.fields["weight"] = weight;


    print("fields = ${request.fields}");

    var response = await request.send();
    return response;
  }

  @override
  Future<List<AnimalModel>> getMyAnimals() async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }
    final response = await httpService.get('api/animals/myAnimals' ,headers: httpService.headers);

    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }
    var animals =
        (response.body as List).map((e) => AnimalModel.fromJson(e)).toList();

    return animals;
  }

  @override
  Future delete(animalSerial) async {
    final response =
        await httpService.delete('api/animals?animalSerial=$animalSerial' ,headers: httpService.headers);
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
  Future<AnimalModel> getAnimalBySerial(serial) async {
    var result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      throw const SocketException("No Internet Connection");
    }

    final response = await httpService.get('api/animals?serial=$serial',headers: httpService.headers);
    if (response.hasError || response.unauthorized) {
      throw SocketException(response.body['message']);
    }

    var animal = AnimalModel.fromJson(response.body);

    return animal;
  }
}
