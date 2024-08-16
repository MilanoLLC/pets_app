import 'package:get/get.dart';
import 'package:pets_app/binding/community_binding.dart';
import 'package:pets_app/binding/edit_animal_binding.dart';
import 'package:pets_app/binding/edit_post_binding.dart';
import 'package:pets_app/binding/edit_profile_binding.dart';
import 'package:pets_app/binding/home_binding.dart';
import 'package:pets_app/binding/main_binding.dart';
import 'package:pets_app/binding/notification_binding.dart';
import 'package:pets_app/binding/product_binding.dart';
import 'package:pets_app/binding/address_binding.dart';
import 'package:pets_app/binding/shop_binding.dart';
import 'package:pets_app/binding/sign_in_binding.dart';
import 'package:pets_app/binding/sign_up_binding.dart';
import 'package:pets_app/binding/verify_binding.dart';
import 'package:pets_app/main.dart';
import 'package:pets_app/screens/Animal/edit_pet_page.dart';
import 'package:pets_app/screens/Animal/add_new_pet_page.dart';
import 'package:pets_app/screens/Animal/pet_detail_page.dart';
import 'package:pets_app/screens/Animal/pets_by_category_page.dart';
import 'package:pets_app/screens/Auth/edit_profile_page.dart';
import 'package:pets_app/screens/Auth/my_favorite_page.dart';
import 'package:pets_app/screens/Auth/sign_in_page.dart';
import 'package:pets_app/screens/Auth/sign_up_page.dart';
import 'package:pets_app/screens/Shipping/edit_address_page.dart';
import 'package:pets_app/screens/community/profile_page.dart';
import 'package:pets_app/screens/shop/check_address_page.dart';
import 'package:pets_app/screens/shop/confirmation_page.dart';
import 'package:pets_app/screens/Home/main_page.dart';
import 'package:pets_app/screens/Auth/PhoneVerification.dart';
import 'package:pets_app/screens/Home/categories_page.dart';
import 'package:pets_app/screens/Home/notification_page.dart';
import 'package:pets_app/screens/Animal/pets_page.dart';
import 'package:pets_app/screens/Shipping/add_address_page.dart';
import 'package:pets_app/screens/shop/TrackOrderPage.dart';
import 'package:pets_app/screens/community/add_post_page.dart';
import 'package:pets_app/screens/community/comments_page.dart';
import 'package:pets_app/screens/community/community_page.dart';
import 'package:pets_app/screens/community/edit_post_page.dart';
import 'package:pets_app/screens/community/my_posts_page.dart';
import 'package:pets_app/screens/shop/my_cart_page.dart';
import 'package:pets_app/screens/shop/my_order_page.dart';
import 'package:pets_app/screens/shop/product_detail_page.dart';
import '../screens/Animal/my_pet_page.dart';
import '../screens/shop/check_payment_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const SplashScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNIN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () =>  SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.FAV,
      page: () =>  MyFavoritePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.VERIFY,
      page: () => const PhoneVerification(true),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: Routes.CATEGORIES,
      page: () => CategoriesPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PETS,
      page: () => PetsPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PETSBYCATEGORY,
      page: () => PetsByCategoryPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.ADDADDRESS,
      page: () => AddNewAddressPage(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.EDITADDRESS,
      page: () => EditAddressPage(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.PETDETAILS,
      page: () => PetDetailPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.NEWPET,
      page: () => const AddNewPetPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.EDITPET,
      page: () => EditPetPage(),
      binding: EditAnimalBinding(),
    ),
    GetPage(
      name: Routes.MYPETS,
      page: () => const MyPetPage(),
      binding: ProductBinding(),
    ),

    GetPage(
      name: Routes.TRACKORDER,
      page: () => const TrackOrderPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.COMMENTS,
      page: () => const CommentsPage(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.ADDPOST,
      page: () => AddPost(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.EDITPOST,
      page: () => EditPost(),
      binding: EditPostBinding(),
    ),
    GetPage(
      name: Routes.MYPOST,
      page: () => MyPostsPage(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.COMMUNITY,
      page: () => const CommunityPage(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.MYORDERS,
      page: () => MyOrderPage(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: Routes.MYCART,
      page: () => MyCartPage(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTDETAILS,
      page: () => ProductDetailPage(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: Routes.CHECKPAYMENT,
      page: () => const CheckPaymentPage(),
      binding: ShopBinding(),
    ),

    GetPage(
      name: Routes.ADDRESSPAGE,
      page: () => AddNewAddressPage(),
      binding: ShopBinding(),
    ),

    GetPage(
      name: Routes.CHECKADDRESS,
      page: () => CheckAddressPage(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: Routes.CONFIRM,
      page: () => const ConfirmationPage(),
      binding: ShopBinding(),
    ),

    // GetPage(
    //   name: Routes.ORDERDETAILS,
    //   page: () => OrderDetailPage(),
    //   binding: ShopBinding(),
    // ),
  ];
}
