import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/CartScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:badges/badges.dart';

PreferredSizeWidget customAppBar({required BuildContext context}) => AppBar(
    leading: Consumer(
      builder: (context, watch, child) => IconButton(
        icon: Badge(
          badgeContent:
              Text(watch(generalmanagment).cart.cartItem.length.toString()),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return CartScreen();
          }));
        },
      ),
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
