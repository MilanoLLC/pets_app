import 'package:pets_app/model/AddressModel.dart';
import 'package:pets_app/model/AnimalModel.dart';
import 'package:pets_app/model/CardModel.dart';
import 'package:pets_app/model/DataModel.dart';
import 'package:pets_app/model/IntroModel.dart';
import 'package:pets_app/model/ModelNotification.dart';
import 'package:pets_app/model/OrderDescModel.dart';
import 'package:pets_app/model/PaymentCardModel.dart';
import 'package:pets_app/model/ProfileModel.dart';
import 'package:pets_app/model/ReviewModel.dart';
import 'package:pets_app/helpers/constant.dart';

String loremText =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of '
    'Least sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

class DataFile {
  // static List<OrderModel> getOrderList() {
  //   List<OrderModel> subCatList = [];
  //
  //   OrderModel mainModel = new OrderModel();
  //   mainModel.id = 1;
  //   mainModel.orderId = "#0012345";
  //   mainModel.items = "12 Items";
  //   mainModel.type = "On Delivery";
  //   subCatList.add(mainModel);
  //
  //   mainModel = new OrderModel();
  //   mainModel.id = 2;
  //   mainModel.orderId = "#0012346";
  //   mainModel.items = "5 Items";
  //   mainModel.type = "Completed";
  //   subCatList.add(mainModel);
  //
  //   mainModel = new OrderModel();
  //   mainModel.id = 3;
  //   mainModel.orderId = "#0012347";
  //   mainModel.items = "10 Items";
  //   mainModel.type = "Canceled";
  //   subCatList.add(mainModel);
  //
  //   mainModel = new OrderModel();
  //   mainModel.id = 4;
  //   mainModel.orderId = "#0012348";
  //   mainModel.items = "8 Items";
  //   mainModel.type = "Completed";
  //   subCatList.add(mainModel);
  //
  //   return subCatList;
  // }

  static List<OrderDescModel> getOrderDescList() {
    List<OrderDescModel> subCatList = [];

    OrderDescModel mainModel = OrderDescModel();
    mainModel.name = "Order Placed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = OrderDescModel();
    mainModel.name = "Order Confirmed";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = OrderDescModel();
    mainModel.name = "Your Order On Delivery by Courier";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 1;
    subCatList.add(mainModel);

    mainModel = OrderDescModel();
    mainModel.name = "Order Delivered";
    mainModel.desc = "January 19th,12:02 AM";
    mainModel.completed = 0;
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<CardModel> getCardList() {
    List<CardModel> subCatList = [];

    CardModel mainModel = CardModel();
    mainModel.id = 1;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.name = "Claudia T.Reyes";
    mainModel.image = "visa.png";

    subCatList.add(mainModel);

    mainModel = CardModel();
    mainModel.id = 2;
    mainModel.email = "chloe_bird@gmail.com";
    mainModel.cardNo = "2342 22** **** **00";
    mainModel.name = "Claudia T.Reyes";
    mainModel.cVV = "***";
    mainModel.expDate = "06/23";
    mainModel.image = "mastercard.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  static List<ModelNotification> getNotificationList() {
    List<ModelNotification> introList = [];
    introList.add(ModelNotification("Notification1",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification2",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification3",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification4",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));
    introList.add(ModelNotification("Notification5",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."));

    return introList;
  }

  static ProfileModel getProfileModel() {
    ProfileModel mainModel = ProfileModel();
    mainModel.email = "chloe_bird@gamil.com";
    mainModel.name = "Chloe B Bird";
    mainModel.image = "hugh.png";
    return mainModel;
  }

  static List<PaymentCardModel> getPaymentCardList() {
    List<PaymentCardModel> subCatList = [];

    PaymentCardModel mainModel = PaymentCardModel();
    mainModel.id = 1;
    mainModel.name = "Credit Card";
    mainModel.image = "visa.png";
    mainModel.desc = "XXX XXX XXX 1234";
    subCatList.add(mainModel);

    mainModel = PaymentCardModel();
    mainModel.id = 2;
    mainModel.name = "Bank Account";
    mainModel.desc = "Ending in 9457";
    mainModel.image = "bank-building.png";
    subCatList.add(mainModel);

    mainModel = PaymentCardModel();
    mainModel.id = 3;
    mainModel.name = "PayPal";
    mainModel.desc = "paypal@gmail.com";
    mainModel.image = "paypal.png";
    subCatList.add(mainModel);

    return subCatList;
  }

  //
  static List<AddressModel> getAddressList() {
    List<AddressModel> subCatList = [];

    AddressModel mainModel = AddressModel();
    mainModel.apartmentNumber = "1";
    mainModel.additionalInstructions = "Chloe B Bird";
    mainModel.street = "+1(368)68 000 068";
    mainModel.city = "87  Great North Road,ALTON,Great North Road";
    mainModel.building = "Home";
    subCatList.add(mainModel);
    return subCatList;
  }

  static List<ReviewModel> getReviewList() {
    List<ReviewModel> subCatList = [];

    ReviewModel mainModel = ReviewModel();
    mainModel.id = 1;
    mainModel.name = "Spearman";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 4;
    subCatList.add(mainModel);

    mainModel = ReviewModel();
    mainModel.id = 2;
    mainModel.name = "Aisha";
    mainModel.image = "hugh.png";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 3;
    subCatList.add(mainModel);

    mainModel = ReviewModel();
    mainModel.id = 3;
    mainModel.image = "hugh.png";
    mainModel.name = "Jock Borden";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
    mainModel.review = 2;
    subCatList.add(mainModel);
    return subCatList;
  }

  static List<DataModel> getCategoryData() {
    List<DataModel> introList = [];

    introList.add(DataModel("pet_1.png", "Dog"));
    introList.add(DataModel("pet_2.png", "Cat"));
    introList.add(DataModel("pet_3.png", "Parrot"));
    introList.add(DataModel("pet_4.png", "Cat"));
    introList.add(DataModel("pet_1.png", "Parrot"));
    introList.add(DataModel("pet_2.png", "Dog"));
    introList.add(DataModel("pet_3.png", "Dog"));
    introList.add(DataModel("pet_4.png", "Dog"));
    introList.add(DataModel("pet_1.png", "Dog"));
    introList.add(DataModel("pet_2.png", "Dog"));
    introList.add(DataModel("pet_3.png", "Dog"));
    introList.add(DataModel("pet_4.png", "Dog"));

    return introList;
  }

  static List<String> getImageList() {
    List<String> imgList = [];

    imgList.add('img_1.jpg');
    imgList.add('img_2.jpg');
    imgList.add('img_3.jpg');
    imgList.add('img_4.jpg');
    imgList.add('img_5.jpg');
    imgList.add('img_6.jpg');
    imgList.add('img_7.jpg');
    imgList.add('img_8.jpg');

    return imgList;
  }

  // static List<ListModel> getList() {
  //   List<ListModel> introList = [];
  //
  //   ListModel mainModel = new ListModel();
  //   mainModel.name = "All";
  //   mainModel.image = "icon_1.png";
  //   introList.add(mainModel);
  //
  //   mainModel = new ListModel();
  //   mainModel.name = "Skin Care";
  //   mainModel.image = "icon_2.png";
  //   introList.add(mainModel);
  //
  //   mainModel = new ListModel();
  //   mainModel.name = "MakeUp";
  //   mainModel.image = "icon_3.png";
  //   introList.add(mainModel);
  //
  //   mainModel = new ListModel();
  //   mainModel.name = "Hair";
  //   mainModel.image = "icon_4.png";
  //   introList.add(mainModel);
  //
  //   return introList;
  // }

  static List<IntroModel> getIntroModel() {
    List<IntroModel> introList = [];

    IntroModel mainModel = IntroModel();
    mainModel.id = 1;
    mainModel.name = "Find The Nearest\nPets From You";
    mainModel.image = "intro9.jpg";
    mainModel.color = "#ffffff".toColor();
    mainModel.endColor = "#f0f1ec".toColor();
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry";
    introList.add(mainModel);

    mainModel = IntroModel();
    mainModel.id = 2;
    mainModel.name = "All Pets Deserves\nMore Care";
    mainModel.color = "#ffffff".toColor();
    mainModel.endColor = "#ffffff".toColor();
    mainModel.image = "intro6.jpg";
    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry";
    introList.add(mainModel);

    mainModel = IntroModel();
    mainModel.id = 3;
    mainModel.name = "Adopt your own pet\nas a friend";
    mainModel.color = "#ffffff".toColor();
    mainModel.endColor = "#ffffff".toColor();
    mainModel.image = "intro7.png";

    mainModel.desc =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry";
    introList.add(mainModel);

    // mainModel = IntroModel();
    // mainModel.id = 4;
    // mainModel.name = "All Pets Adopt\nNeeds Are here";
    // mainModel.color = "#FED845".toColor();
    // mainModel.endColor = "#FED845".toColor();
    // mainModel.image = "intro_4.png";
    //
    // mainModel.desc =
    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
    // introList.add(mainModel);

    return introList;
  }

  // static List<ProductModel> getProductModel() {
  //   List<ProductModel> subList = [];
  //
  //
  //
  //   ProductModel model = new ProductModel();
  //   model.name = "Bella";
  //   model.subTitle = "Original Chose";
  //   model.image = "cat_1.png";
  //   model.address = "Sean casey";
  //   model.price = "\$25";
  //   model.subText = "Whisks wet cat food";
  //   model.offerPrice = "\$10";
  //   model.desc = "Female, 1.5 Years";
  //   model.icon = "product_4.png";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Mack";
  //   model.subTitle = "Original Chose";
  //   model.address = "North Shore";
  //   model.image = "Rectangle 21w2.png";
  //   model.price = "\$35";
  //   model.icon = "product_2.png";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.offerPrice = "\$10";
  //   model.desc = "Male, 1 Years";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Pomeranian";
  //   model.subTitle = "Original Chose";
  //   model.image = "cat_product_1.png";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.price = "\$125";
  //   model.address = "Sean casey";
  //   model.offerPrice = "\$25";
  //   model.desc = "Female, 2 Years";
  //   model.icon = "product_1.png";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Mack";
  //   model.subTitle = "Original Chose";
  //   model.icon = "product_4.png";
  //   model.desc = "Male, 2 Years";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.address = "North Shore";
  //   model.image = "dog.png";
  //   model.price = "\$65";
  //   model.offerPrice = "\$32";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Krueger";
  //   model.subTitle = "Original Chose";
  //   model.image = "product.png";
  //   model.address = "Sean casey";
  //   model.icon = "product_3.png";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.price = "\$25";
  //   model.desc = "Male, 1 Years";
  //   model.offerPrice = "\$10";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Dodging";
  //   model.icon = "product_2.png";
  //   model.subTitle = "Original Chose";
  //   model.image = "Rectangle212.png";
  //   model.price = "\$35";
  //   model.address = "Sean casey";
  //   model.desc = "Female, 1.5 Years";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.offerPrice = "\$10";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Pomeranian";
  //   model.subText = "Whisks wet cat food";
  //
  //   model.subTitle = "Original Chose";
  //   model.image = "cat_product_1.png";
  //   model.price = "\$125";
  //   model.icon = "product_1.png";
  //   model.offerPrice = "\$25";
  //   model.address = "North Shore";
  //   model.desc = "Female, 2 Years";
  //   subList.add(model);
  //
  //   // model = new ProductModel();
  //   // model.name = "Pomeranian";
  //   // model.subTitle = "Original Chose";
  //   // model.image = "product_4.png";
  //   // model.price = "\$65";
  //   // model.offerPrice = "\$32";
  //   // subList.add(model);
  //
  //   return subList;
  // }
  //
  // static List<ProductModel> getAdoptModel() {
  //   List<ProductModel> subList = [];
  //
  //
  //   ProductModel model = new ProductModel();
  //   model.name = "Bella";
  //   model.subTitle = "Original Chose";
  //   model.image = "adopt_1.png";
  //   model.address = "Sean casey";
  //   model.price = "\$25";
  //   model.offerPrice = "\$10";
  //   model.desc = "Female, 1.5 Years";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Mack";
  //   model.subTitle = "Original Chose";
  //   model.address = "North Shore";
  //   model.image = "adopt_2.png";
  //   model.price = "\$35";
  //   model.offerPrice = "\$10";
  //   model.desc = "Male, 1 Years";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Pomeranian";
  //   model.subTitle = "Original Chose";
  //   model.image = "adopt_3.png";
  //   model.price = "\$125";
  //   model.address = "Sean casey";
  //   model.offerPrice = "\$25";
  //   model.desc = "Female, 2 Years";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Mack";
  //   model.subTitle = "Original Chose";
  //   model.desc = "Male, 2 Years";
  //   model.address = "North Shore";
  //   model.image = "adopt_4.png";
  //   model.price = "\$65";
  //   model.offerPrice = "\$32";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Krueger";
  //   model.subTitle = "Original Chose";
  //   model.image = "adopt_5.png";
  //   model.address = "Sean casey";
  //   model.price = "\$25";
  //   model.desc = "Male, 1 Years";
  //   model.offerPrice = "\$10";
  //   subList.add(model);
  //
  //   model = new ProductModel();
  //   model.name = "Dodging";
  //   model.subTitle = "Original Chose";
  //   model.image = "adopt_6.png";
  //   model.price = "\$35";
  //   model.address = "Sean casey";
  //   model.desc = "Female, 1.5 Years";
  //   model.offerPrice = "\$10";
  //   subList.add(model);
  //
  //
  //   return subList;
  // }
  //
  //
  static List<AnimalModel> getCartModel() {
    List<AnimalModel> subList = [];

    AnimalModel model = AnimalModel();
    model.animalName = "Bella";
    // model.subTitle = "Original Chose";
    model.images![0] = "cat_1.png";
    model.location = "Sean casey(4 km)";
    model.weight = 20;
    // model.offerPrice = "\$10";
    model.description = "Female, 1.5 Years";
    subList.add(model);

    model.animalName = "Bella";
    // model.subTitle = "Original Chose";
    model.images![0] = "cat_1.png";
    model.location = "Sean casey(4 km)";
    model.weight = 20;
    // model.offerPrice = "\$10";
    model.description = "Female, 1.5 Years";
    subList.add(model);

    model.animalName = "Bella";
    // model.subTitle = "Original Chose";
    model.images![0] = "cat_1.png";
    model.location = "Sean casey(4 km)";
    model.weight = 20;
    // model.offerPrice = "\$10";
    model.description = "Female, 1.5 Years";
    subList.add(model);

    return subList;
  }
}
