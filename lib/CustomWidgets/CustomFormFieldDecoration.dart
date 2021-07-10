import 'package:flutter/material.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

// this is the decoration of the textformfields... it's a repetition decoration.
// so i created a variable that could be used multiple times with different variables..
// for example, the hint text.
InputDecoration customformfielddecoration(
        {required String hinttext, required BuildContext context}) =>
    InputDecoration(
        isDense: true,
        hintText: hinttext,
        fillColor: offwhite,
        filled: true,
        contentPadding: EdgeInsets.only(
            top: screenHeight(context) * 0.035,
            right: screenWidth(context) * 0.03),
        // ////////
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        // ////////
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent)),
        // ////////
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black)));
