import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/APIRequests.dart';

//this is a changenotifier class to handle variabl changes and notife listener classes of the changes.
final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  var products;
  var categories;
  var orders;
  void test() {
    categories = 12;
    print("test");
    notifyListeners();
  }

  ultramethod(String token) async {
    products = await APIRequests.retrieveproducts(token);
    categories = await APIRequests.retrievecategories(token);
    orders = await APIRequests.retrieveorders(token);
  }
}
