// ignore_for_file: must_be_immutable


import 'package:card_swiper/card_swiper.dart';
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
import 'package:tap_debouncer/tap_debouncer.dart';


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
  late List<Comments> comments;
  var storage = getIt<ILocalStorageService>();

  @override
  Widget build(BuildContext context) {
    cellHeight = getScreenPercentSize(context, 6.5);

    defMargin = getHorizontalSpace(context);
    padding = getScreenPercentSize(context, 2);
    var height = getScreenPercentSize(context, 35);
    double imgHeight = getPercentSize(height, 45);
    double radius = getPercentSize(height, 5);
    double remainHeight = height - imgHeight;
    var storage = LocalStorageService();
    var token = storage.get(STORAGE_KEYS.token);
    print("toke = $token");

    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Community"),
                elevation: 0,
                centerTitle: true,
              ),
              body: token == null || token == ""
                  ? emptyWidget(context)
                  : Column(
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
                                                storage.get(
                                                    STORAGE_KEYS.userImage)),
                                radius: 35,
                                backgroundColor: Colors.white,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.ADDPOST,
                                        arguments: null);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: getDecorationWithBorder(
                                          25, Theme.of(context).cardColor,
                                          color: Colors.grey),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Add new post ..",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
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
                                  itemCount: controller.posts.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    PostModel model = controller.posts[index];
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.all(10),
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).cardColor,
                                        shadows: [
                                          BoxShadow(
                                              color:
                                                  subTextColor.withOpacity(0.1),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            model
                                                                .createdByUsername,
                                                            Theme.of(context)
                                                                .hintColor,
                                                            getPercentSize(
                                                                remainHeight,
                                                                10),
                                                            FontWeight.bold,
                                                            TextAlign.center,
                                                            1),
                                                        getCustomTextWidget(
                                                            "@${model.createdByUsername}",
                                                            Colors.grey,
                                                            getPercentSize(
                                                                remainHeight,
                                                                8),
                                                            FontWeight.normal,
                                                            TextAlign.center,
                                                            1),
                                                      ],
                                                    )
                                                  ],
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
                                                  Size(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      350.0)),
                                              child: Swiper(
                                                outer: false,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Image.network(
                                                    networkPath +
                                                        model.images![index],
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                                pagination:
                                                    const SwiperPagination(
                                                        margin: EdgeInsets.all(
                                                            5.0)),
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
                                                TapDebouncer(
                                                  cooldown: const Duration(
                                                      seconds: 3),
                                                  onTap: () async {
                                                    if (model.liked == false) {
                                                      showCupertinoModalPopup(
                                                          context: context,
                                                          builder: (context) =>
                                                              const SecondScreen());
                                                      controller
                                                          .likePost(
                                                              model.serial,
                                                              model)
                                                          .then((value) =>
                                                              Get.back());
                                                      // Future.delayed(
                                                      //     const Duration(
                                                      //         milliseconds:
                                                      //         700), () {
                                                      //   Get.back();
                                                      // });
                                                    } else {
                                                      controller.likePost(
                                                          model.serial, model);
                                                    }
                                                  },
                                                  builder: (_,
                                                          TapDebouncerFunc?
                                                              onTap) =>
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor: Colors
                                                                      .transparent,
                                                                  elevation: 0),
                                                          onPressed: onTap,
                                                          // alternative with manual test onTap for null in builder
                                                          child: storage.get(
                                                                  STORAGE_KEYS
                                                                      .theme)
                                                              ? Icon(
                                                                  model.liked ==
                                                                          false
                                                                      ? Icons
                                                                          .favorite_border
                                                                      : Icons
                                                                          .favorite,
                                                                  color: model.liked ==
                                                                          false
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .red,
                                                                )
                                                              : Icon(
                                                                  model.liked ==
                                                                          false
                                                                      ? Icons
                                                                          .favorite_border
                                                                      : Icons
                                                                          .favorite,
                                                                  color: model.liked ==
                                                                          false
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .red,
                                                                )),
                                                ),
                                                // IconButton(
                                                //     onPressed: () {
                                                //       controller.likePost(
                                                //           model.serial, model);
                                                //       if (model.liked == false) {
                                                //         showCupertinoModalPopup(
                                                //             context: context,
                                                //             builder: (context) =>
                                                //                 SecondScreen());
                                                //         Future.delayed(
                                                //             const Duration(
                                                //                 milliseconds:
                                                //                     700), () {
                                                //           Get.back();
                                                //         });
                                                //       }
                                                //     },
                                                //     icon: storage.get(
                                                //             STORAGE_KEYS.theme)
                                                //         ? Icon(
                                                //             model.liked == false
                                                //                 ? Icons
                                                //                     .favorite_border
                                                //                 : Icons.favorite,
                                                //             color: model.liked ==
                                                //                     false
                                                //                 ? Colors.white
                                                //                 : Colors.red,
                                                //           )
                                                //         : Icon(
                                                //             model.liked == false
                                                //                 ? Icons
                                                //                     .favorite_border
                                                //                 : Icons.favorite,
                                                //             color: model.liked ==
                                                //                     false
                                                //                 ? Colors.black
                                                //                 : Colors.red,
                                                //           )),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    model.likes!.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                      // Get.toNamed(
                                                      //     Routes.COMMENTS,
                                                      //     arguments: [
                                                      //       {
                                                      //         "serial":
                                                      //             model.serial
                                                      //       },
                                                      //       {
                                                      //         "comments":
                                                      //             model.comments
                                                      //       }
                                                      //     ]);

                                                      showModalBottomSheet(
                                                         // isScrollControlled: true,
                                                        context: context,
                                                        builder:
                                                            (BuildContext builder) {
                                                          comments = model.comments!;
                                                          return StatefulBuilder(
                                                              builder: (BuildContext
                                                                      context,
                                                                  StateSetter
                                                                      setState) {
                                                            return CommentBox(
                                                              userImage: storage.get(
                                                                          STORAGE_KEYS
                                                                              .userImage) ==
                                                                      null
                                                                  ? CommentBox
                                                                      .commentImageParser(
                                                                      imageURLorPath:
                                                                          'assets/images/profile.png',
                                                                    )
                                                                  : CommentBox
                                                                      .commentImageParser(
                                                                      imageURLorPath:
                                                                          networkPath +
                                                                              storage.get(
                                                                                  STORAGE_KEYS.userImage),
                                                                    ),
                                                              labelText:
                                                                  'Write a comment...',
                                                              errorText:
                                                                  'Comment cannot be blank',
                                                              withBorder: false,
                                                              sendButtonMethod: () {
                                                                if (formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  print(
                                                                      commentController
                                                                          .text);
                                                                  setState(() {
                                                                    comments.insert(
                                                                      0,
                                                                      Comments(
                                                                        deleted:
                                                                            false,
                                                                        serial: "aa",
                                                                        userImage:
                                                                            null,
                                                                        username: storage.get(
                                                                            STORAGE_KEYS
                                                                                .userName),
                                                                        content:
                                                                            commentController
                                                                                .text,
                                                                        displayName:
                                                                            storage.get(
                                                                                STORAGE_KEYS
                                                                                    .fullName),
                                                                        commentedAt: DateTime
                                                                                .now()
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                    controller.addComment(
                                                                        commentController
                                                                            .text,
                                                                        model.serial);
                                                                  });
                                                                  commentController
                                                                      .clear();
                                                                  // FocusScope.of(context)
                                                                  //     .unfocus();
                                                                } else {
                                                                  print(
                                                                      "Not validated");
                                                                }
                                                              },
                                                              formKey: formKey,
                                                              commentController:
                                                                  commentController,
                                                              backgroundColor:
                                                                  primaryColor,
                                                              textColor: Colors.white,
                                                              sendWidget: const Icon(
                                                                  Icons.send_sharp,
                                                                  size: 30,
                                                                  color:
                                                                      Colors.white),
                                                              child: commentChild(
                                                                  comments),
                                                            );
                                                          });
                                                        },
                                                      );
                                                    }),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(
                                                    model.comments!.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
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

  emptyWidget(BuildContext context) {
    double height = getScreenPercentSize(context, 7);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "${iconsPath}box.png",
          height: getScreenPercentSize(context, 20),
        ),
        SizedBox(
          height: getScreenPercentSize(context, 3),
        ),
        getCustomTextWithFontFamilyWidget(
            "You are not logged in!",
            Theme.of(context).hintColor,
            getScreenPercentSize(context, 2.5),
            FontWeight.w500,
            TextAlign.center,
            1),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          onPressed: () {
            Get.toNamed(Routes.SIGNIN);
          },
          minWidth: 100,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            height: getScreenPercentSize(context, 7),
            margin: EdgeInsets.only(
                top: getScreenPercentSize(context, 1.2),
                bottom: getHorizontalSpace(context),
                left: getHorizontalSpace(context) + 40,
                right: getHorizontalSpace(context) + 40),
            decoration: ShapeDecoration(
              color: Theme.of(context).primaryColor,
              shape: SmoothRectangleBorder(
                side: BorderSide(color: primaryColor, width: 1.5),
                borderRadius: SmoothBorderRadius(
                  cornerRadius: getPercentSize(height, 25),
                  cornerSmoothing: 0.8,
                ),
              ),
            ),
            child: Center(
                child: getDefaultTextWidget("Log in", TextAlign.center,
                    FontWeight.w500, 20, Theme.of(context).cardColor)),
          ),
        ),
      ],
    );
  }
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
