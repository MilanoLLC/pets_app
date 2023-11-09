/// id : "6458a2df7460c420a7a45f3d"
/// version : 2
/// enName : "tyttt"
/// arName : "qweqweqwe"
/// serial : "ANCT100180"
/// imagePath : "13-1.jfif"
/// visible : true
/// deleted : false

class CategoryModel {
  CategoryModel({
      String? id, 
      num? version, 
      String? enName, 
      String? arName, 
      String? serial, 
      String? imagePath, 
      bool? visible, 
      bool? deleted,}){
    _id = id;
    _version = version;
    _enName = enName;
    _arName = arName;
    _serial = serial;
    _imagePath = imagePath;
    _visible = visible;
    _deleted = deleted;
}

  CategoryModel.fromJson(dynamic json) {
    _id = json['id']??"";
    _version = json['version']??"";
    _enName = json['enName']??"";
    _arName = json['arName']??"";
    _serial = json['serial']??"";
    _imagePath = json['imagePath'];
    _visible = json['visible']??"";
    _deleted = json['deleted']??"";
  }
  String? _id;
  num? _version;
  String? _enName;
  String? _arName;
  String? _serial;
  String? _imagePath;
  bool? _visible;
  bool? _deleted;
CategoryModel copyWith({  String? id,
  num? version,
  String? enName,
  String? arName,
  String? serial,
  String? imagePath,
  bool? visible,
  bool? deleted,
}) => CategoryModel(  id: id ?? _id,
  version: version ?? _version,
  enName: enName ?? _enName,
  arName: arName ?? _arName,
  serial: serial ?? _serial,
  imagePath: imagePath ?? _imagePath,
  visible: visible ?? _visible,
  deleted: deleted ?? _deleted,
);
  String? get id => _id;
  num? get version => _version;
  String? get enName => _enName;
  String? get arName => _arName;
  String? get serial => _serial;
  String? get imagePath => _imagePath;
  bool? get visible => _visible;
  bool? get deleted => _deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['version'] = _version;
    map['enName'] = _enName;
    map['arName'] = _arName;
    map['serial'] = _serial;
    map['imagePath'] = _imagePath;
    map['visible'] = _visible;
    map['deleted'] = _deleted;
    return map;
  }

}