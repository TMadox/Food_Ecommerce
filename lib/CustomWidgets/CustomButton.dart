import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget customButton(
        {required Function() customOnPressed,
        required BuildContext context,
        required String title,
        required Color primarycolor,
        required Color titlecolor}) =>
    Container(
        width: screenWidth(context) * 0.8,
        child: ElevatedButton(
          onPressed: customOnPressed,
          child: Text(
            title,
            style: TextStyle(color: titlecolor, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: primarycolor,
              side: BorderSide(width: 2, color: Colors.black)),
        ));
