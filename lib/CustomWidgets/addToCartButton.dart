import 'package:flutter/material.dart';

Widget addToCartButton() => ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ),
    onPressed: () {},
    icon: Icon(Icons.shopping_cart),
    label: Text("اضف للعربة"));
