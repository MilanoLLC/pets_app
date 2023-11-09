class Category {
  Category({
      this.id,
      this.version, 
      this.enName, 
      this.arName, 
      this.serial, 
      this.imagePath, 
      this.visible, 
      this.deleted,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    version = json['version'];
    enName = json['enName'];
    arName = json['arName'];
    serial = json['serial'];
    imagePath = json['imagePath'];
    visible = json['visible'];
    deleted = json['deleted'];
  }
  String? id;
  int? version;
  String? enName;
  String? arName;
  String? serial;
  String? imagePath;
  bool? visible;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['version'] = version;
    map['enName'] = enName;
    map['arName'] = arName;
    map['serial'] = serial;
    map['imagePath'] = imagePath;
    map['visible'] = visible;
    map['deleted'] = deleted;
    return map;
  }

}