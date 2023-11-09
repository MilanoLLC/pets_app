import 'package:get_it/get_it.dart';
import 'package:pets_app/repositories/adoption_repository.dart';
import 'package:pets_app/repositories/animal_repository.dart';
import 'package:pets_app/repositories/auth_repository.dart';
import 'package:pets_app/repositories/community_repository.dart';
import 'package:pets_app/repositories/home_repository.dart';
import 'package:pets_app/repositories/shop_repository.dart';
import 'package:pets_app/services/http_service.dart';
import 'package:pets_app/services/local_storage_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() async {
  var instance = await LocalStorageService.getInstance();
  getIt.registerSingleton<ILocalStorageService>(instance!);

  // Services
  getIt.registerSingleton(HttpService());

  // Repositories
  getIt.registerSingleton<IAuthRepository>(AuthRepository());
  getIt.registerSingleton<IHomeRepository>(HomeRepository());
  getIt.registerSingleton<IAnimalRepository>(AnimalRepository());
  getIt.registerSingleton<IAdoptionRepository>(AdoptionRepository());
  getIt.registerSingleton<ICommunityRepository>(CommunityRepository());
  getIt.registerSingleton<IShopRepository>(ShopRepository());


}
