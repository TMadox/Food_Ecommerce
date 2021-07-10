import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_store/Variables/ScreenSize.dart';

PreferredSizeWidget customAppBar({required BuildContext context}) => AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.black,
      ),
      onPressed: () {},
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.black,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite,
            color: Colors.black,
          ))
    ],
    centerTitle: true,
    toolbarHeight: screenHeight(context) * 0.067,
    backgroundColor: Colors.white,
    title: ImageIcon(
      AssetImage("Images/Logos/RedSeaLogo.png"),
      color: Colors.black,
      size: screenWidth(context) * 0.17,
    ));
