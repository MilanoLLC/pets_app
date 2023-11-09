//
// import 'package:fatorah/repositories/auth_repository.dart';
// import 'package:fatorah/repositories/home_repository.dart';
// import 'package:fatorah/repositories/report_repository.dart';
// import 'package:fatorah/services/http_service.dart';
// import 'package:fatorah/services/local_storage_service.dart';
// import 'package:get_it/get_it.dart';
//
// final getIt = GetIt.instance;
//
// setupServiceLocator() async {
//   var instance = await LocalStorageService.getInstance();
//   getIt.registerSingleton<ILocalStorageService>(instance!);
//
//   // Services
//   getIt.registerSingleton(HttpService());
//   // getIt.registerSingleton<IAuthenticationService>(AuthenticationService());
//
//   // Repositories
//   getIt.registerSingleton<IHomeRepository>(HomeRepository());
//   getIt.registerSingleton<IBuyRepository>(BuyRepository());
//   getIt.registerSingleton<IReportRepository>(ReportRepository());
//   // getIt.registerSingleton<INewsRepository>(NewsRepository());
//   // getIt.registerSingleton<IOfferRepository>(OfferRepository());
//   // getIt.registerSingleton<IReservedCouponCodeRepository>(ReservedCouponCodeRepository());
//   //
//   // // Controllers
//   // getIt.registerSingleton<DashboardController>(DashboardController());
//   // getIt.registerSingleton<MenuController>(MenuController());
//
// }
