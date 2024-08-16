import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pets_app/helpers/Constant.dart';
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:pets_app/services/local_storage_service.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

Widget commentChild(data) {
  var storage = LocalStorageService();

  return ListView(
    children: [
      for (var i = 0; i < data.length; i++)
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: data[i].userImage == null
                        ? CommentBox.commentImageParser(
                      imageURLorPath: 'assets/images/profile.png',
                    )
                        : CommentBox.commentImageParser(
                        imageURLorPath: networkPath + data[i].userImage),
                    radius: 25,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[i].displayName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              DateFormat('HH:mm a')
                                  .format(DateTime.parse(data[i].commentedAt!))
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Text(
                        data[i].content!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              TapDebouncer(
                  cooldown: const Duration(seconds: 3),
                  onTap: () async {
                    // if (model.liked == false) {
                    //   showCupertinoModalPopup(
                    //       context: context, builder: (context) => LikeScreen());
                    //   controller
                    //       .likePost(model.serial, model)
                    //       .then((value) => Get.back());
                    //   // Future.delayed(
                    //   //     const Duration(
                    //   //         milliseconds:
                    //   //         700), () {
                    //   //   Get.back();
                    //   // });
                    // } else {
                    //   controller.likePost(model.serial, model);
                    // }
                  },
                  builder: (_, TapDebouncerFunc? onTap) => IconButton(
                    onPressed: onTap,
                    icon: Icon(Icons.favorite_border)
                    // storage.get(STORAGE_KEYS.theme)
                    //     ? Icon(
                    //   data[i].liked == false
                    //       ? Icons.favorite_border
                    //       : Icons.favorite,
                    //   color: data[i].liked == false
                    //       ? Colors.white
                    //       : Colors.red,
                    // )
                    //     :
                    // Icon(
                    //   data[i].liked == false
                    //       ? Icons.favorite_border
                    //       : Icons.favorite,
                    //   color: data[i].liked == false
                    //       ? Colors.black
                    //       : Colors.red,
                    // ),
                  )),
            ],
          ),
          // ListTile(
          //   // tileColor:Theme.of(context).backgroundColor,
          //   leading: CircleAvatar(
          //     backgroundImage: data[i].userImage == null
          //         ? CommentBox.commentImageParser(
          //       imageURLorPath: 'assets/images/profile.png',
          //     )
          //         : CommentBox.commentImageParser(
          //         imageURLorPath: networkPath + data[i].userImage),
          //     radius: 35,
          //     backgroundColor: Colors.transparent,
          //   ),
          //   title: Text(
          //     data[i].displayName!,
          //     style: const TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   subtitle: Text(data[i].content!),
          //   trailing: Text(
          //     // DateFormat('yyyy/MM/dd').parse(data[i].commentedAt).toString(),
          //       DateFormat('yyyy/MM/dd HH:mm a')
          //           .format(DateTime.parse(data[i].commentedAt!))
          //           .toString(),
          //       style: const TextStyle(fontSize: 10)),
          // ),
        )
    ],
  );
}