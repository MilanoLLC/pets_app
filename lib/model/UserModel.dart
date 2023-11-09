class UserModel {
  UserModel({
      this.firstName, 
      this.lastName, 
      this.email, 
      this.countryPhoneCode, 
      this.phoneNumber,});

  UserModel.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryPhoneCode = json['countryPhoneCode'];
    phoneNumber = json['phoneNumber'];
  }
  String? firstName;
  String? lastName;
  String? email;
  String? countryPhoneCode;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['countryPhoneCode'] = countryPhoneCode;
    map['phoneNumber'] = phoneNumber;
    return map;
  }

}