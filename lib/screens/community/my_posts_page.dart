// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Comments.dart';
import 'package:pets_app/model/Post_model.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:comment_box/comment/comment.dart';

class MyPostsPage extends StatelessWidget {
  MyPostsPage({Key? key}) : super(key: key);
  final TextEditingController commentController = TextEditingController();

  double defMargin = 0;
  double padding = 0;
  double height = 0;
  double cellHeight = 0;

  final formKey = GlobalKey<FormState>();
  late List<Comments> comments;

  @override
  Widget build(BuildContext context) {
    var storage = getIt<ILocalStorageService>();

    cellHeight = getScreenPercentSize(context, 6.5);
    defMargin = getHorizontalSpace(context);
    padding = getScreenPercentSize(context, 2);
    var height = getScreenPercentSize(context, 35);
    double imgHeight = getPercentSize(height, 45);
    double radius = getPercentSize(height, 5);
    double remainHeight = height - imgHeight;

    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("My Posts"),
                elevation: 0,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 70,
                    decoration:
                        BoxDecoration(color: Theme.of(context).cardColor),
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
                                          storage.get(STORAGE_KEYS.userImage)),
                          radius: 35,
                          backgroundColor: Colors.white,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ADDPOST, arguments: null);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 1))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                //
                                // getDecorationWithBorder(
                                //     25, Theme.of(context).cardColor,
                                //     color: Colors.grey),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Add new post ..",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: subTextColor,
                                    ),
                                  ],
                                )
                                // TextField(
                                //   textInputAction: TextInputAction.search,
                                //   style: const TextStyle(color: Colors.black),
                                //   decoration: InputDecoration(
                                //     contentPadding:
                                //         EdgeInsets.only(left: defMargin),
                                //     hintText: 'Add new post ..',
                                //     // prefixIcon: Icon(Icons.search),
                                //     suffixIcon: Icon(
                                //       Icons.add,
                                //       color: subTextColor,
                                //     ),
                                //     hintStyle: TextStyle(
                                //       color: subTextColor,
                                //       fontFamily: fontFamily,
                                //       fontSize: getScreenPercentSize(context, 1.7),
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //     filled: true,
                                //     isDense: true,
                                //     fillColor: Colors.transparent,
                                //     disabledBorder: getOutLineBorder(radius),
                                //     enabledBorder: getOutLineBorder(radius),
                                //   ),
                                //   onTap: () {
                                //     Get.toNamed(Routes.ADDPOST,arguments: null);
                                //   },
                                // ),
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
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
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(10),
                                decoration: ShapeDecoration(
                                  color: Theme.of(context).cardColor,
                                  shadows: [
                                    BoxShadow(
                                        color: subTextColor.withOpacity(0.1),
                                        blurRadius: 0,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 1))
                                  ],
                                  shape: SmoothRectangleBorder(
                                    borderRadius: SmoothBorderRadius(
                                      cornerRadius: radius,
                                      cornerSmoothing: 0.8,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: model
                                                            .userImage ==
                                                        null
                                                    ? CommentBox
                                                        .commentImageParser(
                                                        imageURLorPath:
                                                            'assets/images/profile.png',
                                                      )
                                                    : CommentBox.commentImageParser(
                                                        imageURLorPath:
                                                            networkPath +
                                                                model
                                                                    .userImage!),
                                                radius: 35,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  getCustomTextWidget(
                                                      model.createdByUsername,
                                                      Theme.of(context)
                                                          .hintColor,
                                                      getPercentSize(
                                                          remainHeight, 10),
                                                      FontWeight.bold,
                                                      TextAlign.center,
                                                      1),
                                                  getCustomTextWidget(
                                                      "@${model.createdByUsername}",
                                                      Colors.grey,
                                                      getPercentSize(
                                                          remainHeight, 8),
                                                      FontWeight.normal,
                                                      TextAlign.center,
                                                      1),
                                                ],
                                              )
                                            ],
                                          ),
                                          // const Icon(Icons.more_vert)
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              customButton: const Icon(
                                                Icons.more_vert,
                                                size: 30,
                                              ),

                                              // customItemsIndexes: const [3],
                                              // customItemsHeight: 8,
                                              items: [
                                                ...MenuItems.firstItems.map(
                                                  (item) => DropdownMenuItem<
                                                      MenuItem>(
                                                    value: item,
                                                    child: MenuItems.buildItem(
                                                        item, index),
                                                  ),
                                                ),
                                              ],
                                              onChanged: (value) {
                                                MenuItems.onChanged(
                                                    context,
                                                    value as MenuItem,
                                                    index,
                                                    model);
                                              },
                                              // itemHeight: 48,
                                              // itemPadding:
                                              //     const EdgeInsets.only(
                                              //         left: 16, right: 16),
                                              // dropdownWidth: 160,
                                              // dropdownPadding:
                                              //     const EdgeInsets.symmetric(
                                              //         vertical: 6),
                                              // dropdownDecoration: BoxDecoration(
                                              //   borderRadius:
                                              //       BorderRadius.circular(4),
                                              //   color:
                                              //       Theme.of(context).cardColor,
                                              // ),
                                              // dropdownElevation: 8,
                                              // offset: const Offset(0, 8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Text(
                                        model.postContent.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints.loose(Size(
                                            MediaQuery.of(context).size.width,
                                            350.0)),
                                        child: Swiper(
                                          outer: false,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Image.network(
                                              networkPath +
                                                  model.images![index],
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          pagination: const SwiperPagination(
                                              margin: EdgeInsets.all(5.0)),
                                          itemCount: model.images!.length,
                                        )),
                                    // Container(
                                    //   height: 270,
                                    //   decoration: BoxDecoration(
                                    //     color: const Color(0xff7c94b6),
                                    //     image: DecorationImage(
                                    //       image: NetworkImage(networkPath +
                                    //           controller.posts[index].images![0]),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                print("liked = ${model.liked}");

                                                controller.likePost(
                                                    model.serial, model);
                                                if (model.liked == false) {
                                                  showCupertinoModalPopup(
                                                      context: context,
                                                      builder: (context) =>
                                                          const SecondScreen());
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 700),
                                                      () {
                                                    Get.back();
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: model.liked == false
                                                    ? Colors.white
                                                    : Colors.red,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              model.likes!.length.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                Icons.comment,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                Get.toNamed(Routes.COMMENTS,
                                                    arguments: [
                                                      {"serial": model.serial},
                                                      {
                                                        "comments":
                                                            model.comments
                                                      }
                                                    ]);
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Text(
                                              model.comments!.length.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  getShapeDecoration() {
    double radius = getPercentSize(cellHeight, 20);

    return ShapeDecoration(
      color: cellColor,
      shape: SmoothRectangleBorder(
        side: BorderSide(color: primaryColor.withOpacity(0.8), width: 0.3),
        borderRadius: SmoothBorderRadius(
          cornerRadius: radius,
          cornerSmoothing: 0.8,
        ),
      ),
    );
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 20, 2.0, 0.0),
            child: ListTile(
              // tileColor:Theme.of(context).backgroundColor,
              leading: CircleAvatar(
                backgroundImage: data[i].userImage == null
                    ? CommentBox.commentImageParser(
                        imageURLorPath: 'assets/images/profile.png',
                      )
                    : CommentBox.commentImageParser(
                        imageURLorPath: networkPath + data[i].userImage),
                radius: 35,
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                data[i].displayName!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i].content!),
              trailing: Text(
                  // DateFormat('yyyy/MM/dd').parse(data[i].commentedAt).toString(),
                  DateFormat('yyyy/MM/dd HH:mm a')
                      .format(DateTime.parse(data[i].commentedAt!))
                      .toString(),
                  style: const TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit, delete];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);

  static Widget buildItem(MenuItem item, index) {
    return Row(
      children: [
        Icon(item.icon, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, index, model) {
    switch (item) {
      case MenuItems.edit:
        Get.toNamed(Routes.EDITPOST, arguments: {"editPost": model});
        break;
      case MenuItems.delete:
        deleteDialog(context, index);
        break;
    }
  }
}

deleteDialog(BuildContext context, index) {
  final controller = Get.put(CommunityController());
  AwesomeDialog(
    context: context,
    // dialogType: DialogType.infoReverse,
    headerAnimationLoop: true,
    // animType: AnimType.bottomSlide,
    title: 'Are you sure?',
    // reverseBtnOrder: true,
    btnOkOnPress: () {
      controller.removePost(controller.myPosts[index].serial, index);
    },
    btnOkText: "ok",
    btnCancelOnPress: () {},
  ).show();
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 400,
      ),
      vsync: this,
      value: 0.1,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        alignment: Alignment.center,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:
              // BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //     child:
              Center(
                  child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 200,
            color: Colors.transparent,
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 150,
            ),
            // ),
          )),
        ));
  }
}
