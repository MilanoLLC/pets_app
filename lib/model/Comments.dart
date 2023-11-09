class Comments {
  Comments({
      this.serial, 
      this.displayName, 
      this.userImage, 
      this.content, 
      this.username, 
      this.commentedAt, 
      this.deleted,});

  Comments.fromJson(dynamic json) {
    serial = json['serial'];
    displayName = json['displayName'];
    userImage = json['userImage'];
    content = json['content'];
    username = json['username'];
    commentedAt = json['commentedAt'];
    deleted = json['deleted'];
  }
  String? serial;
  String? displayName;
  String? userImage;
  String? content;
  String? username;
  String? commentedAt;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serial'] = serial;
    map['displayName'] = displayName;
    map['userImage'] = userImage;
    map['content'] = content;
    map['username'] = username;
    map['commentedAt'] = commentedAt;
    map['deleted'] = deleted;
    return map;
  }

}