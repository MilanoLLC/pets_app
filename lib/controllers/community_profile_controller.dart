import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/model/Likes.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/model/UserPost.dart';
import 'package:pets_app/repositories/community_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class CommunityProfileController extends GetxController
    with StateMixin<dynamic> {
  PostModel model;
  CommunityProfileController(this.model);

  UserPost? userPosts = UserPost();
  UserPost? userPostsList = UserPost();

  var communityRepository = getIt<ICommunityRepository>();
  var storage = getIt<ILocalStorageService>();
  final _paginationFilter = PaginationFilter().obs;

  final _lastPage = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    model = args['userPost']!;
    ever(_paginationFilter, (_) => getUserPosts(model.createdByUsername));
    _changePaginationFilter(0, 10);
  }

  @override
  void onClose() {
  }

  void getUserPosts(userName) async {
    try {
      await communityRepository
          .getUserPosts(_page, limit, userName)
          .then((value) {
        if (value.posts!.isEmpty) {
          _lastPage.value = true;
        }
        userPosts!.posts =  value.posts;
        userPosts!.postsCount = value.postsCount!;
        userPosts!.followingCount = value.followingCount!;
        userPosts!.followersCount = value.followersCount!;
        userPosts!.profileName = value.profileName!;
        userPosts!.profileImage = value.profileImage!;

        userPostsList = userPosts;
        change(value, status: RxStatus.success());
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error', ex.message.tr,
          backgroundColor: Colors.red, colorText: Colors.white);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }

  void changeTotalPerPage(int limitValue) {
    userPosts!.posts!.clear();
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }

  void _changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void loadNextPage() {
    _changePaginationFilter(_page + 1, limit);
  }

  Future<void> addComment(content, postSerial) async {
    try {
      await communityRepository.addComment(content, postSerial).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Comment added successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }

  Future<void> likePost(postSerial, post) async {
    try {
      Likes like = Likes();
      if (post.liked == true) {
        post.likes!.removeLast();
      } else {
        post.likes!.add(like);
      }
      await communityRepository.likePost(postSerial, post.liked).then((value) {
        post.liked = !post.liked!;
      });
    } on SocketException catch (ex) {
      Get.snackbar('Error'.tr, ex.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    } on Exception catch (ex) {
      Get.snackbar('Error'.tr, ex.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    update();
  }
}
