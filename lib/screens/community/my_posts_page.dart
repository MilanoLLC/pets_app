// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/model/Comments.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/post_widget.dart';

class MyPostsPage extends StatelessWidget {
  MyPostsPage({Key? key}) : super(key: key);
  final TextEditingController commentController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Comments> comments = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return Scaffold(
              appBar: appBarCustom(
                  context,
                  "My Posts",
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADDPOST);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                  true),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(
                      () => LazyLoadScrollView(
                        onEndOfPage: controller.loadNextPage,
                        isLoading: controller.lastPage,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: controller.myPosts.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              PostModel model = controller.myPosts[index];
                              return postWidget(
                                  context,
                                  model,
                                  comments,
                                  controller,
                                  commentController,
                                  formKey,
                                  true,
                                  index);
                            }),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}