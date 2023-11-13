// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/controllers/community_controller.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/model/Comments.dart';
import 'package:pets_app/service_locator.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';
import 'package:get/get.dart';
import 'package:comment_box/comment/comment.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  dynamic argumentData = Get.arguments;

  final controller = Get.put(CommunityController());

  double defMargin = 0;
  double padding = 0;
  double height = 0;

  FocusNode myFocusNode = FocusNode();
  bool isAutoFocus = false;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String serial = argumentData[0]['serial'];
    List<Comments> comments = argumentData[1]['comments'];

    defMargin = getHorizontalSpace(context);
    padding = getScreenPercentSize(context, 2);
    var height = getScreenPercentSize(context, 35);
    double imgHeight = getPercentSize(height, 45);
    double radius = getPercentSize(height, 5);
    double remainHeight = height - imgHeight;
    var storage = getIt<ILocalStorageService>();

    return GetBuilder<CommunityController>(
        init: CommunityController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Comments"),
                elevation: 0,
                centerTitle: true,
              ),
              body: CommentBox(
                userImage: storage.get(STORAGE_KEYS.userImage) == null
                    ? CommentBox.commentImageParser(
                        imageURLorPath: 'assets/images/profile.png',
                      )
                    : CommentBox.commentImageParser(
                        imageURLorPath:
                            networkPath + storage.get(STORAGE_KEYS.userImage),
                      ),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    setState(() {
                      comments.insert(
                        0,
                        Comments(
                          deleted: false,
                          serial: "aa",
                          userImage: null,
                          username: storage.get(STORAGE_KEYS.userName),
                          content: commentController.text,
                          displayName: storage.get(STORAGE_KEYS.fullName),
                          commentedAt: DateTime.now().toString(),
                        ),
                      );
                      controller.addComment(commentController.text, serial);
                    });
                    commentController.clear();
                    // FocusScope.of(context)
                    //     .unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: primaryColor,
                textColor: Colors.white,
                sendWidget:
                    const Icon(Icons.send_sharp, size: 30, color: Colors.white),
                child: commentChild(comments),
              ));
        });
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
