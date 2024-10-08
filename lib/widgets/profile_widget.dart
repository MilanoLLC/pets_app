import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/helpers/Constant.dart';

class ProfileWidget extends StatelessWidget {
  // final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final XFile? image;

  const ProfileWidget({
    Key? key,
    // required this.imagePath,
    required this.image,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    if (image != null && image!.path.isNotEmpty) {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Image.file(
            File(image!.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return ClipOval(
          child: Material(
        color: Colors.transparent,
        child: Image.asset(
          "${assetsPath}profile.png",
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ),
      ));
    }
    // final image = NetworkImage(imagePath);
    //
    // return ClipOval(
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Ink.image(
    //       image: image,
    //       fit: BoxFit.cover,
    //       width: 128,
    //       height: 128,
    //       child: InkWell(onTap: onClicked),
    //     ),
    //   ),
    // );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
