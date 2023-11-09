import 'Likes.dart';
import 'Comments.dart';

class PostModel {
  PostModel({
    this.id,
    this.serial,
    this.createdByUsername,
    this.createdAt,
    this.postContent,
    this.images,
    this.likes,
    this.comments,
    this.commentsSequence,
    this.userImage,
    this.liked,
    this.deleted,
  });

  PostModel.fromJson(dynamic json) {
    id = json['id'] ?? "";
    serial = json['serial'] ?? "";
    createdByUsername = json['createdByUsername'] ?? "";
    createdAt = json['createdAt'] ?? "";
    postContent = json['postContent'] ?? "";
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes!.add(Likes.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    commentsSequence = json['commentsSequence'];

    userImage = json['userImage'];

    liked = json['liked'];
    deleted = json['deleted'];
  }
  String? id;
  String? serial;
  dynamic createdByUsername;
  String? createdAt;
  String? postContent;
  List<String>? images;
  List<Likes>? likes;
  List<Comments>? comments;
  String? userImage;
  int? commentsSequence;
  bool? liked;
  bool? deleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['serial'] = serial;
    map['createdByUsername'] = createdByUsername;
    map['createdAt'] = createdAt;
    map['postContent'] = postContent;
    map['images'] = images;
    if (likes != null) {
      map['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      map['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    map['commentsSequence'] = commentsSequence;
    map['userImage'] = userImage;
    map['liked'] = liked;
    map['deleted'] = deleted;
    return map;
  }
}
