// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pets_app/controllers/community_profile_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Comments.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/model/UserPost.dart';
import 'package:pets_app/screens/community/like_page.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:get/get.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/button_widget.dart';
import 'package:pets_app/widgets/post_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  dynamic argumentData = Get.arguments;

  final TextEditingController commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Comments> comments = [];

  @override
  Widget build(BuildContext context) {
    var storage = getIt<ILocalStorageService>();
    PostModel postModel = argumentData['userPost'];

    return LoaderOverlay(
      child: GetBuilder<CommunityProfileController>(
          init: CommunityProfileController(postModel),
          builder: (controller) {
            return Scaffold(
                appBar: appBarBack(context, "Profile", true),
                body: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      // decoration:
                      //     BoxDecoration(color: Theme.of(context).cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    storage.get(STORAGE_KEYS.userImage) == null
                                        ? CommentBox.commentImageParser(
                                            imageURLorPath:
                                                'assets/images/profile.png',
                                          )
                                        : CommentBox.commentImageParser(
                                            imageURLorPath: networkPath +
                                                storage.get(
                                                    STORAGE_KEYS.userImage)),
                                radius: 45,
                                backgroundColor: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "profile name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.userPosts!.postsCount == null
                                    ? ""
                                    : controller.userPosts!.postsCount!
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Text("Posts")
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.userPosts!.followersCount == null
                                    ? ""
                                    : controller.userPosts!.followersCount!
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Text("Followers")
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.userPosts!.followingCount == null
                                    ? ""
                                    : controller.userPosts!.followingCount!
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              const Text("Following")
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //     padding: const EdgeInsets.all(10),
                        //     margin: const EdgeInsets.all(10),
                        //     width: 100,
                        //     decoration: BoxDecoration(
                        //         color: primaryColor.withOpacity(0.2),
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(30))),
                        //     // margin: EdgeInsets.symmetric(horizontal: 20),
                        //     child: const Center(
                        //         child: Text(
                        //       "Posts",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 16),
                        //     ))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: buttonWidget(
                              context, "Follow", primaryColor,Colors.white, () {
                            Loader.show(context,
                                isSafeAreaOverlay: false,
                                progressIndicator:
                                    const CircularProgressIndicator(),
                                isBottomBarOverlay: false,
                                overlayFromBottom: 0,
                                themeData: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch()
                                        .copyWith(secondary: Colors.black38)),
                                overlayColor: const Color(0x33E8EAF6));
                            // controller.addPost().then((value) => Loader.hide());
                            controller.onClose();
                            // Navigator.of(context).pop(true);
                          }),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => LazyLoadScrollView(
                          onEndOfPage: controller.loadNextPage,
                          isLoading: controller.lastPage,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: controller.userPosts!.posts == null
                                  ? 0
                                  : controller.userPosts!.posts!.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                UserPost model = controller.userPosts!;
                                PostModel pModel = model.posts![index];
                                return postWidget(
                                    context,
                                    pModel,
                                    comments,
                                    controller,
                                    commentController,
                                    formKey,
                                    false,
                                    index);
                              }),
                        ),
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
