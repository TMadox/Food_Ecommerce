import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Logic/APIRequests.dart';

//this is a changenotifier class to handle variabl changes and notife listener classes, of the changes.
final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  late Map logininfo;
  bool isLoading = false;
  late String userToken = "";
  late int currentPage = 1;
  late int currentOrderPage = 1;
  late int totalPages = 2;
  late int totalOrdersPages;
  late List products = [];
  late List orders = [];
  late bool isLoadingNewItems=false;
  void setUserToken(String token) {
    userToken = token;
    notifyListeners();
  }

  void setIsLoadingNewItems() {
    isLoadingNewItems = !isLoadingNewItems;
    notifyListeners();
  }

  void setIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void setTotalOrderPages(int totalPages) {
    totalOrdersPages = totalPages;
    notifyListeners();
  }

  void addproducts(List input) {
    products.addAll(input);
    notifyListeners();
  }

  void addOrders(List input) {
    orders.addAll(input);
    notifyListeners();
  }

  void setcurrentpages(int cpage) {
    currentPage = cpage;
    notifyListeners();
  }

  void setCurrentOrderPage(int cOPage) {
    currentOrderPage = cOPage;
    notifyListeners();
  }

  void settotalpages(int tpage) {
    totalPages = tpage;
    notifyListeners();
  }
}
