
import 'package:flutter/material.dart';

Widget customIcon(func,icon){
  return Container(
    margin: const EdgeInsets.all(8.0),
    width: 40.0,
    height: 40.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black.withOpacity(0.3), // Adjust color as needed
    ),
    child: Center(
      child: IconButton(
        icon:  Icon(icon),
        color: Colors.white, // Adjust color as needed
        onPressed: func,
      ),
    ),
  );
}