class ItemCategory {
  ItemCategory({
      this.id, 
      this.version, 
      this.categorySerial, 
      this.categoryArName, 
      this.categoryEnName, 
      this.image, 
      this.visible, 
      this.deleted,});

  ItemCategory.fromJson(dynamic json) {
    id = json['id'];
    version = json['version'];
    categorySerial = json['categorySerial'];
    categoryArName = json['categoryArName'];
    categoryEnName = json['categoryEnName'];
    image = json['image'];
    visible = json['visible'];
    deleted = json['deleted'];
  }
  String? id;
  int? version;
  String? categorySerial;
  String? categoryArName;
  String? categoryEnName;
  String? image;
  bool? visible;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['version'] = version;
    map['categorySerial'] = categorySerial;
    map['categoryArName'] = categoryArName;
    map['categoryEnName'] = categoryEnName;
    map['image'] = image;
    map['visible'] = visible;
    map['deleted'] = deleted;
    return map;
  }

}