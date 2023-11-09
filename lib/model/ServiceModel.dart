
import 'ItemCategory.dart';

class ServiceModel {
  ServiceModel({
      this.serviceSerial, 
      this.providerSerial, 
      this.arName, 
      this.enName, 
      this.price, 
      this.availableQuantity, 
      this.requestedQuantity, 
      this.createdAt, 
      this.createdByUserSerial, 
      this.serviceType, 
      this.images, 
      this.itemCategory, 
      this.disabled, 
      this.deleted,});

  ServiceModel.fromJson(dynamic json) {
    serviceSerial = json['serviceSerial'];
    providerSerial = json['providerSerial'];
    arName = json['arName'];
    enName = json['enName'];
    price = json['price'];
    availableQuantity = json['availableQuantity'];
    requestedQuantity = json['requestedQuantity'];
    createdAt = json['createdAt'];
    createdByUserSerial = json['createdByUserSerial'];
    serviceType = json['serviceType'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    itemCategory = json['itemCategory'] != null ? ItemCategory.fromJson(json['itemCategory']) : null;
    disabled = json['disabled'];
    deleted = json['deleted'];
  }
  String? serviceSerial;
  String? providerSerial;
  String? arName;
  String? enName;
  double? price;
  int? availableQuantity;
  int? requestedQuantity;
  String? createdAt;
  dynamic createdByUserSerial;
  String? serviceType;
  List<String>? images;
  ItemCategory? itemCategory;
  bool? disabled;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceSerial'] = serviceSerial;
    map['providerSerial'] = providerSerial;
    map['arName'] = arName;
    map['enName'] = enName;
    map['price'] = price;
    map['availableQuantity'] = availableQuantity;
    map['requestedQuantity'] = requestedQuantity;
    map['createdAt'] = createdAt;
    map['createdByUserSerial'] = createdByUserSerial;
    map['serviceType'] = serviceType;
    map['images'] = images;
    if (itemCategory != null) {
      map['itemCategory'] = itemCategory!.toJson();
    }
    map['disabled'] = disabled;
    map['deleted'] = deleted;
    return map;
  }

}