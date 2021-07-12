import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/Variables/ScreenSize.dart';

Widget addToCartButton({
  required BuildContext context,
  required String itemId,
  required Icon customIcon,
  required int price,
  required String title,
  required String productName,
  required String imageUrl
}) =>
    ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onPressed: () {
          context
              .read(generalmanagment)
              .addOrRemovefromCart(itemId, price, productName,imageUrl);
        },
        icon: customIcon,
        label: Text(title));
