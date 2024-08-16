import 'package:pets_app/model/Post_model.dart';

class UserPost {
  UserPost({
    this.posts,
    this.postsCount,
    this.followersCount,
    this.followingCount,
    this.profileName,
    this.profileImage,
  });

  UserPost.fromJson(dynamic json) {
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts!.add(PostModel.fromJson(v));
      });
    } else if (json['posts'] == null) {
      posts = [];
    }
    postsCount = json['postsCount'] ?? 0;
    followersCount = json['followersCount'] ?? 0;
    followingCount = json['followingCount'] ?? 0;
    profileName = json['profileName'] ?? "";
    profileImage = json['profileImage'] ?? "";
  }

  List<PostModel>? posts;
  int? postsCount;
  int? followersCount;
  int? followingCount;
  String? profileName;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    map['postsCount'] = postsCount;
    map['followersCount'] = followersCount;
    map['followingCount'] = followingCount;
    map['profileName'] = profileName;
    map['profileImage'] = profileImage;
    return map;
  }
}
