import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';

class ShowProductScreen extends StatelessWidget {
  final int index;
  const ShowProductScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read(generalmanagment).products[index]["name"]),
        centerTitle: true,
      ),
      
    );
  }
}
