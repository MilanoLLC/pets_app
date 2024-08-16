import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appBarCustom(
    BuildContext context, title, actionWidget, backCheck) {

  return AppBar(
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    actions: [actionWidget],
    leading: backCheck
        ? InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios))
        : null,
  );
}



PreferredSizeWidget appBarBack(BuildContext context, title,backCheck) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(fontSize: 20,),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: backCheck,
    leading: backCheck? InkWell(
        onTap: (){
          Get.back();
        },
        child: const Icon(Icons.arrow_back_ios)):null,
  );
}

