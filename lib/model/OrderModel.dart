

import 'package:pets_app/model/ServiceModel.dart';

import 'OrderDescModel.dart';

class OrderModel{


  int? id;
  String? orderId;
  List<ServiceModel>? items;
  String? type;
  List<OrderDescModel>? orderDescModelList;
}