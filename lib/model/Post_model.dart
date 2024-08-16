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
    this.likedByUsers,
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
    // likedByUsers =
    // json['likedByUsers'] != null ? json['likedByUsers'].cast<String>() : [];
    if (json['likedByUsers'] != null) {
      likedByUsers = [];
      json['likedByUsers'].forEach((v) {
        likedByUsers!.add((v));
      });
    }
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    commentsSequence = json['commentsSequence'] ?? 0;

    userImage = json['userImage'] ;

    liked = json['liked'] ?? false;
    deleted = json['deleted'] ?? false;
  }
  String? id;
  String? serial;
  String? createdByUsername;
  String? createdAt;
  String? postContent;
  List<String>? images;
  List<Likes>? likes;
  List<String>? likedByUsers;
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
    if (likedByUsers != null) {
      map['likedByUsers'] = likedByUsers!.map((v) => v).toList();
    }
    // map['likedByUsers'] = likedByUsers;

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
