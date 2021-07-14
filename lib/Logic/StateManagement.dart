import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Models/UserModel.dart';

//this is a changenotifier class to handle variabl changes and notife listener classes, of the changes.
final generalmanagment = ChangeNotifierProvider<General>((ref) => General());

class General extends ChangeNotifier {
  late Map logininfo;
  bool isLoading = false;
  late int currentProductPage = 1;
  late int totalProductsPages = 0;
  late int currentOrderPage = 1;
  late int totalOrdersPages = 0;
  late int currentCategoryPage = 1;
  late int totalCategoryPages = 0;
  late List products = [];
  late List orders = [];
  List categories = [];
  late Map ordersResponse;
  late Map productsResponse;
  UserModel? userInfo;
  String? userToken;
  String? userId;
  late bool isLoadingNewItems = false;
  var cart = FlutterCart();
  List countries = [];
  List governorates = [];
  List cities = [];
  var selectedGov;
  String? selectedCategory;
  String? userPassword;

  void setUserPassword(String input) {
    userPassword = input;
  }

  void setSelectedCategory(String input) {
    selectedCategory = input;
    notifyListeners();
  }

  void setCurrentCategoryPage(int input) {
    currentCategoryPage = input;
  }

  void setCountries(List input) {
    countries = input;
  }

  void setSelectedGov(var input) {
    selectedGov = input;
    notifyListeners();
  }

  void setCitiesandGovernates(List inputCities, List inputGovernates) {
    cities = inputCities;
    governorates = inputGovernates;
  }

  bool checkItemInCart(String id) {
    if (cart.getSpecificItemFromCart(id) != null) {
      return true;
    } else {
      return false;
    }
  }

  void addcategories(List input) {
    categories.addAll(input);
    notifyListeners();
  }

  void addOrRemovefromCart(
      String id, int price, String productName, String image) {
    if (cart.getSpecificItemFromCart(id) != null) {
      cart.deleteItemFromCart(cart.findItemIndexFromCart(id)!);
    } else {
      cart.addToCart(
          uniqueCheck: image,
          productId: id,
          unitPrice: price,
          productName: productName,
          quantity: 1);
    }
    notifyListeners();
  }

  void deleteFromCart(int index) {
    cart.deleteItemFromCart(index);
    notifyListeners();
  }

  void incrementProduct(int index) {
    cart.incrementItemToCart(index);
    notifyListeners();
  }

  void decrementProduct(int index) {
    cart.decrementItemFromCart(index);
    notifyListeners();
  }

  void setUserToken(String token) {
    userToken = token;
  }

  void setUserId(String id) {
    userId = id;
  }

  void setUserInfo(UserModel info) {
    userInfo = info;
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

  void setTotalCategoryPages(int totalPages) {
    totalCategoryPages = totalPages;
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
    currentProductPage = cpage;
    notifyListeners();
  }

  void setCurrentOrderPage(int cOPage) {
    currentOrderPage = cOPage;
    notifyListeners();
  }

  void setTotalProductsPages(int tpage) {
    totalProductsPages = tpage;
    notifyListeners();
  }
}
