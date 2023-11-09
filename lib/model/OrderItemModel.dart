import 'package:pets_app/model/ServiceModel.dart';

class OrderItemModel {
  OrderItemModel({
    this.item,
    this.quantity,
  });

  OrderItemModel.fromJson(dynamic json) {
    item = json['item'] != null ? ServiceModel.fromJson(json['item']) : null;
    quantity = json['quantity'];
  }

  ServiceModel? item;
  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (item != null) {
      map['item'] = item!.toJson();
    }
    map['quantity'] = quantity;
    return map;
  }
}
