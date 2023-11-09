class AddressModel {
  AddressModel({
      this.additionalInstructions, 
      this.apartmentNumber, 
      this.building, 
      this.city, 
      this.street,});

  AddressModel.fromJson(dynamic json) {
    additionalInstructions = json['additionalInstructions'];
    apartmentNumber = json['apartmentNumber'];
    building = json['building'];
    city = json['city'];
    street = json['street'];
  }
  String? additionalInstructions;
  String? apartmentNumber;
  String? building;
  String? city;
  String? street;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalInstructions'] = additionalInstructions;
    map['apartmentNumber'] = apartmentNumber;
    map['building'] = building;
    map['city'] = city;
    map['street'] = street;
    return map;
  }

}