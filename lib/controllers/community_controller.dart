import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/controllers/pagination_filter_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Likes.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/repositories/community_repository.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';

class CommunityController extends GetxController with StateMixin<dynamic> {
  TextEditingController textContentController = TextEditingController();

  List<PostModel> posts = <PostModel>[].obs;
  List<PostModel> postsList = <PostModel>[].obs;

  List<PostModel> myPosts = <PostModel>[].obs;
  List<PostModel> myPostsList = <PostModel>[].obs;

  var communityRepository = getIt<ICommunityRepository>();
  var storage = getIt<ILocalStorageService>();
  final _paginationFilter = PaginationFilter().obs;
  final _paginationFilter2 = PaginationFilter().obs;

  final _lastPage = false.obs;
  final _lastPage2 = false.obs;

  int get limit => _paginationFilter.value.limit!;
  int get _page => _paginationFilter.value.page!;
  bool get lastPage => _lastPage.value;

  int get limit2 => _paginationFilter.value.limit!;
  int get _page2 => _paginationFilter.value.page!;
  bool get lastPage2 => _lastPage.value;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  @override
  Future<void> onInit() async {
    textContentController.clear();
    super.onInit();
    var token = storage.get(STORAGE_KEYS.token);
    if(token){
      ever(_paginationFilter, (_) => getPosts());
      _changePaginationFilter(0, 10);
      ever(_paginationFilter2, (_) => getMyPosts());
      _changePaginationFilter2(0, 10);
    }

  }

  @override
  void onClose() {
    print("close community controller");
    textContentController.clear();
    imageFileList!.clear();
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    update();
  }

  Future<void> getPostBySerial() async {}

  Future<void> getPosts() async {
    try {
      await communityRepository.getPosts(_page, limit).then((value) {
        if (value.isEmpty) {
          _lastPage.value = true;
        }
        posts = posts + value;
        print("posts = ${posts[0].comments!}");

        postsList = posts;
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

  Future<void> getMyPosts() async {
    try {
      await communityRepository.getMyPosts(_page2, limit2).then((value) {
        if (value.isEmpty) {
          _lastPage2.value = true;
        }
        myPosts = myPosts + value;
        myPostsList = myPosts;
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
    posts.clear();
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

  void changeTotalPerPage2(int limitValue) {
    myPosts.clear();
    _lastPage2.value = false;
    _changePaginationFilter2(1, limitValue);
  }

  void _changePaginationFilter2(int page, int limit) {
    _paginationFilter2.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void loadNextPage2() {
    _changePaginationFilter2(_page2 + 1, limit);
  }

  Future<void> addPost() async {
    try {
      print("add post");
      await communityRepository
          .addPost(textContentController.text, imageFileList)
          .then((value) {
        print("value = ${value.statusCode}");
        if (value.statusCode == 200) {
          Get.back();

          Get.snackbar('Success'.tr, "Post added successfully",
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
  }

  Future<void> editPost(postSerial) async {
    try {
      await communityRepository
          .editPost(postSerial, textContentController.text, imageFileList)
          .then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Post edited successfully",
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
  }

  Future<void> removePost(postSerial, index) async {
    myPosts.remove(myPosts[index]);
    try {
      await communityRepository.deletePost(postSerial).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar('Success'.tr, "Post removed successfully",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
        change(value, status: RxStatus.success());
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

  Future<void> addComment(content, postSerial) async {
    // posts[index].comments!.add( Comments(content:content));

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

  Future<void> likePost(postSerial, PostModel post) async {
    print("this is like post" + postSerial);
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
