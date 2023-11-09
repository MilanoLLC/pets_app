class Likes {
  Likes({
      this.displayName, 
      this.likedByUserName, 
      this.likedAt, 
      this.postSerial,});

  Likes.fromJson(dynamic json) {
    displayName = json['displayName'];
    likedByUserName = json['likedByUserName'];
    likedAt = json['likedAt'];
    postSerial = json['postSerial'];
  }
  String? displayName;
  String? likedByUserName;
  String? likedAt;
  String? postSerial;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['displayName'] = displayName;
    map['likedByUserName'] = likedByUserName;
    map['likedAt'] = likedAt;
    map['postSerial'] = postSerial;
    return map;
  }

}