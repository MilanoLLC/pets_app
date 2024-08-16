import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/routes/app_pages.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

Widget postWidget(BuildContext context, model, comments, controller,
    commentController, formKey, isEditable, index) {
  var height = getScreenPercentSize(context, 35);
  double imgHeight = getPercentSize(height, 45);
  double remainHeight = height - imgHeight;
  var storage = LocalStorageService();
  double radius = getScreenPercentSize(context, 3);

  return Container(
    margin: const EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: Theme.of(context).cardColor,
      shadows: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: const Offset(0, 1))
      ],
      shape: SmoothRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 15,
          cornerSmoothing: 0.8,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PROFILE,
                          arguments: {"userPost": model});
                    },
                    child: CircleAvatar(
                      backgroundImage: model.userImage == null
                          ? CommentBox.commentImageParser(
                              imageURLorPath: 'assets/images/profile.png',
                            )
                          : CommentBox.commentImageParser(
                              imageURLorPath: networkPath + model.userImage!),
                      radius: 25,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getCustomTextWidget(
                          model.createdByUsername,
                          Theme.of(context).hintColor,
                          getPercentSize(remainHeight, 10),
                          FontWeight.bold,
                          TextAlign.center,
                          1,
                          context),
                      getCustomTextWidget(
                          "@${model.createdByUsername}",
                          Colors.grey,
                          getPercentSize(remainHeight, 8),
                          FontWeight.normal,
                          TextAlign.center,
                          1,
                          context),
                    ],
                  ),
                ],
              ),
              isEditable == true
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: const Icon(
                          Icons.more_vert,
                          size: 25,
                        ),
                        // customItemsIndexes: const [3],
                        // customItemsHeight: 8,
                        items: [
                          ...MenuItems.firstItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item, index),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          MenuItems.onChanged(
                              context, value as MenuItem, index, model);
                        },
                        dropdownStyleData: DropdownStyleData(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(theRadius),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            model.postContent.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        // SizedBox(
        //   height: 270,
        //   child: Center(
        //     child: model.images![0] == null
        //         ? Image.asset(
        //             'assets/images/no image.jpg')
        //         : FadeInImage.assetNetwork(
        //             placeholder:
        //                 'assets/images/no image.jpg',
        //             image: networkPath +
        //                 model.images![0],
        //           ),
        //   ),
        // ),
        ConstrainedBox(
            constraints: BoxConstraints.loose(
                Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/2.5)),
            child: Swiper(
              outer: true,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  networkPath + model.images![index],
                  fit: BoxFit.fill,
                );
              },
              pagination: SwiperPagination(
                margin: const EdgeInsets.only(top: 5.0),
                builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: primaryColor,
                    size: 4,
                    activeSize: 7,
                    space: 1.3),
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              TapDebouncer(
                  cooldown: const Duration(seconds: 3),
                  onTap: () async {
                    if (model.liked == false) {
                      showCupertinoModalPopup(
                          context: context, builder: (context) => LikeScreen());
                      controller
                          .likePost(model.serial, model)
                          .then((value) => Get.back());
                      // Future.delayed(
                      //     const Duration(
                      //         milliseconds:
                      //         700), () {
                      //   Get.back();
                      // });
                    } else {
                      controller.likePost(model.serial, model);
                    }
                  },
                  builder: (_, TapDebouncerFunc? onTap) => IconButton(
                        onPressed: onTap,
                        icon: storage.get(STORAGE_KEYS.theme)
                            ? Icon(
                                model.liked == false
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                color: model.liked == false
                                    ? Colors.white
                                    : Colors.red,
                              )
                            : Icon(
                                model.liked == false
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                color: model.liked == false
                                    ? Colors.black
                                    : Colors.red,
                              ),
                      )),
              Text(
                model.likes!.length.toString(),
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Icon(
                    Icons.comment,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.COMMENTS, arguments: [
                      {"serial": model.serial},
                      {"comments": model.comments}
                    ]);

                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   backgroundColor: Theme.of(context).cardColor,
                    //   shape: RoundedRectangleBorder(
                    //       side: BorderSide(color: Theme.of(context).cardColor),
                    //       borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(radius),
                    //           topRight: Radius.circular(radius))),
                    //   builder: (BuildContext builder) {
                    //     comments = model.comments!;
                    //     return StatefulBuilder(builder:
                    //         (BuildContext context, StateSetter setState) {
                    //       return CommentBox(
                    //         userImage: storage.get(STORAGE_KEYS.userImage) ==
                    //                 null
                    //             ? CommentBox.commentImageParser(
                    //                 imageURLorPath: 'assets/images/profile.png',
                    //               )
                    //             : CommentBox.commentImageParser(
                    //                 imageURLorPath: networkPath +
                    //                     storage.get(STORAGE_KEYS.userImage),
                    //               ),
                    //         labelText: 'Write a Comment',
                    //         errorText: 'Comment cannot be blank',
                    //         withBorder: false,
                    //         sendButtonMethod: () {
                    //           if (formKey.currentState!.validate()) {
                    //             setState(() {
                    //               comments.insert(
                    //                 0,
                    //                 Comments(
                    //                   deleted: false,
                    //                   serial: "aa",
                    //                   userImage: null,
                    //                   username:
                    //                       storage.get(STORAGE_KEYS.userName),
                    //                   content: commentController.text,
                    //                   displayName:
                    //                       storage.get(STORAGE_KEYS.fullName),
                    //                   commentedAt: DateTime.now().toString(),
                    //                 ),
                    //               );
                    //               controller.addComment(
                    //                   commentController.text, model.serial);
                    //             });
                    //             commentController.clear();
                    //             // FocusScope.of(context)
                    //             //     .unfocus();
                    //           } else {}
                    //         },
                    //         formKey: formKey,
                    //         commentController: commentController,
                    //         backgroundColor:
                    //             Theme.of(context).scaffoldBackgroundColor,
                    //         textColor:
                    //             Theme.of(context).hintColor.withOpacity(0.6),
                    //         sendWidget: Icon(Icons.send_sharp,
                    //             size: 25, color: Theme.of(context).hintColor),
                    //         child: commentChild(comments, model),
                    //       );
                    //     });
                    //   },
                    // );
                  }),
              Text(
                model.comments!.length.toString(),
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      upperBound: 1,
      duration: const Duration(
        milliseconds: 400,
      ),
      vsync: this,
      value: 0,
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

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({required this.text, required this.icon});
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit, delete];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);

  static Widget buildItem(MenuItem item, index) {
    return Row(
      children: [
        Icon(
          item.icon,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          item.text,
          style: TextStyle(fontSize: 14),
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
    dialogType: DialogType.warning,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    title: 'Are you sure?',
    // reverseBtnOrder: true,
    btnOkOnPress: () {
      controller.removePost(controller.myPosts[index].serial, index);
    },
    btnOkText: "ok",
    btnCancelOnPress: () {},
  ).show();
}
