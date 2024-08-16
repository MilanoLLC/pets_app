// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Comments.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/screens/community/like_page.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:pets_app/widgets/app_bar_custom.dart';
import 'package:pets_app/widgets/empty_widget.dart';
import 'package:pets_app/widgets/post_widget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final controller = Get.put(CommunityController());
  final TextEditingController commentController = TextEditingController();

  double defMargin = 0;
  double padding = 0;
  double height = 0;
  double cellHeight = 0;

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  final formKey = GlobalKey<FormState>();
  List<Comments> comments = [];
  var storage = getIt<ILocalStorageService>();

  @override
  Widget build(BuildContext context) {
    // var storage = LocalStorageService();
    var token = storage.get(STORAGE_KEYS.token);

    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return token == null || token == ""
              ? emptyWidgetUnauthorized(context)
              : Scaffold(
                  appBar: appBarCustom(
                      context,
                      "Community",
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.ADDPOST);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Center(child: Icon(Icons.add)),
                        ),
                      ),
                      false),
                  body: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        height: 50,
                        child: Row(
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
                                              storage
                                                  .get(STORAGE_KEYS.userImage)),
                              radius: 35,
                              backgroundColor: Colors.white,
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ADDPOST, arguments: null);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: getDecorationWithBorder(
                                      theRadius, Theme.of(context).cardColor,
                                      color: Colors.grey),
                                  child: const Text(
                                    "Add New Post",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
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
                                itemCount: controller.posts.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  PostModel model = controller.posts[index];
                                  return postWidget(
                                      context,
                                      model,
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
        });
  }

  // getShapeDecoration() {
  //   double radius = getPercentSize(cellHeight, 20);
  //
  //   return ShapeDecoration(
  //     color: cellColor,
  //     shape: SmoothRectangleBorder(
  //       side: BorderSide(color: primaryColor.withOpacity(0.8), width: 0.3),
  //       borderRadius: SmoothBorderRadius(
  //         cornerRadius: radius,
  //         cornerSmoothing: 0.8,
  //       ),
  //     ),
  //   );
  // }
}

