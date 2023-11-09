import 'Category.dart';

class AnimalModel {
  AnimalModel({
      this.id, 
      this.version, 
      this.serial, 
      this.createdByUsername, 
      this.createdAt, 
      this.currentOwnerUserName, 
      this.animalName, 
      this.visible, 
      this.deleted, 
      this.category, 
      this.type, 
      this.dob, 
      this.color, 
      this.description, 
      this.location, 
      this.passport, 
      this.vaccinated, 
      this.numberOfVaccines, 
      this.animalOrigin, 
      this.friendly, 
      this.sinceWhen, 
      this.age, 
      this.agePrefix, 
      this.weight, 
      this.gender, 
      this.images, 
      this.accessories,
      this.vaccines, 
      this.diseases, 
      this.usersSerials, 
      this.locationTag,});

  AnimalModel.fromJson(dynamic json) {
    id = json['id'];
    version = json['version'];
    serial = json['serial'];
    createdByUsername = json['createdByUsername'];
    createdAt = json['createdAt'];
    currentOwnerUserName = json['currentOwnerUserName'];
    animalName = json['animalName'];
    visible = json['visible'];
    deleted = json['deleted'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    type = json['type'];
    dob = json['dob'];
    color = json['color'];
    description = json['description'];
    location = json['location'];
    passport = json['passport'];
    vaccinated = json['vaccinated'];
    numberOfVaccines = json['numberOfVaccines'];
    animalOrigin = json['animalOrigin'];
    friendly = json['friendly'];
    sinceWhen = json['sinceWhen'];
    age = json['age'];
    agePrefix = json['agePrefix'];
    weight = json['weight'];
    gender = json['gender'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    accessories = json['accessories'];
    vaccines = json['vaccines'];
    diseases = json['diseases'];
    usersSerials = json['usersSerials'];
    locationTag = json['locationTag'];
  }
  String? id;
  int? version;
  String? serial;
  dynamic createdByUsername;
  dynamic createdAt;
  dynamic currentOwnerUserName;
  String? animalName;
  bool? visible;
  bool? deleted;
  Category? category;
  String? type;
  String? dob;
  String? color;
  String? description;
  String? location;
  bool? passport;
  bool? vaccinated;
  dynamic numberOfVaccines;
  dynamic animalOrigin;
  bool? friendly;
  dynamic sinceWhen;
  String? age;
  String? agePrefix;
  double? weight;
  String? gender;
  List<String>? images;
  dynamic accessories;
  dynamic vaccines;
  dynamic diseases;
  dynamic usersSerials;
  dynamic locationTag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id??"";
    map['version'] = version??"";
    map['serial'] = serial??"";
    map['createdByUsername'] = createdByUsername??"";
    map['createdAt'] = createdAt??"";
    map['currentOwnerUserName'] = currentOwnerUserName??"";
    map['animalName'] = animalName??"";
    map['visible'] = visible??"";
    map['deleted'] = deleted??"";
    if (category != null) {
      map['category'] = category!.toJson();
    }
    map['type'] = type??"";
    map['dob'] = dob??"";
    map['color'] = color??"";
    map['description'] = description??"";
    map['location'] = location??"";
    map['passport'] = passport??"";
    map['vaccinated'] = vaccinated??"";
    map['numberOfVaccines'] = numberOfVaccines??"";
    map['animalOrigin'] = animalOrigin??"";
    map['friendly'] = friendly??"";
    map['sinceWhen'] = sinceWhen??"";
    map['age'] = age??"";
    map['agePrefix'] = agePrefix??"";
    map['weight'] = weight??"";
    map['gender'] = gender??"";
    map['images'] = images;
    map['accessories'] = accessories??"";
    map['vaccines'] = vaccines??"";
    map['diseases'] = diseases??"";
    map['usersSerials'] = usersSerials??"";
    map['locationTag'] = locationTag??"";
    return map;
  }

}