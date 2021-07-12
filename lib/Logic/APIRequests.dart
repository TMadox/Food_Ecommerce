import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/HomeScreen.dart';
import 'package:test_store/Models/UserModel.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:get/get.dart';
import 'package:test_store/Models/ProductModel.dart';

class APIRequests {
  Future firstSuperRequest(
      {required String? userToken,
      required String? userId,
      required int pageNumber,
      required BuildContext context}) async {
    await requestUserOrders(userToken!, userId!, pageNumber, context).then(
        (value) =>
            context.read(generalmanagment).setTotalOrderPages(value.lastPage));

    await requestProducts(userToken, context, pageNumber, false).then((value) =>
        context
            .read(generalmanagment)
            .setTotalProductsPages(value[0].lastPage));

    await requestUserInfo(userToken, context);
  }

  Future requestLogin(Map loginInfo, BuildContext contextm) async {
    final Map<String, String?> data = {
      'email': loginInfo["email"],
      'password': loginInfo["password"]
    };
    Options requestOptions = Options(
      headers: {"Content-Type": "application/json"},
    );
    Dio dio = Dio();
    var response =
        await dio.post(apiLoginUrl, data: data, options: requestOptions);

    SharedPreferences.getInstance().then((value) {
      value.setString("token", response.data["token"]);
      value.setString("user_id", response.data["user"]["id"].toString());
    });
    return response.data;
  }

  Future requestSignUp(Map signupInfo) async {
    Options requestOptions = Options(
      headers: {"Content-Type": "application/json"},
    );
    Dio dio = Dio();
    var response =
        await dio.post(apiSignupUrl, data: signupInfo, options: requestOptions);
    print(response.data["user"]);
  }

  Future requestUserOrders(String userToken, String userId, int pageNumber,
      BuildContext contextm) async {
    Dio dio = Dio();
    Options requestOptions = Options(
      responseType: ResponseType.plain,
      headers: {
        "Content-Type": "application/json",
        "Authorization": userToken,
        'Charset': 'utf-8'
      },
    );
    try {
      var response = await dio.get(
        apiOrdesrUrl + userId + "&page=" + pageNumber.toString(),
        options: requestOptions,
      );
      if (response.statusCode == 200) {
        if (response.data.toString().contains("html")) {
          Get.snackbar("Error", "Invalid Token");
          throw {printError()};
        } else {
          Map<String, dynamic> body = jsonDecode(response.data);
          var orders = ProductModel.fromJson(body);
          contextm.read(generalmanagment).addOrders(orders.data);
          contextm.read(generalmanagment).setCurrentOrderPage(++pageNumber);
          return orders;
        }
      }
    } on Exception catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future requestProducts(String? userToken, BuildContext contextm,
      int pagenumber, bool isRefresh) async {
    Dio dio = Dio();
    Options requestOptions = Options(
      responseType: ResponseType.json,
      headers: {
        "Content-Type": "application/json",
        "Authorization": userToken,
        'Charset': 'utf-8'
      },
    );
    // if (isRefresh) {
    //   contextm.read(generalmanagment).setcurrentpages(1);   // to be used later in refreshing the data if requested.
    // }
    try {
      var response = await dio.get(
        apiProductsUrl + pagenumber.toString(),
        options: requestOptions,
      );
      if (response.statusCode == 200) {
        if (response.data.contains("html")) {
          Get.snackbar("Error", "Invalid Token");
        } else {
          var products =
              response.data.map((e) => ProductModel.fromJson(e)).toList();
          contextm.read(generalmanagment).addproducts(products[0].data);
          contextm.read(generalmanagment).setcurrentpages(++pagenumber);

          return products;
        }
      }
    } on Exception catch (e) {
      // print(e);
    }
  }

  Future requestUserInfo(String? userToken, BuildContext context) async {
    print(userToken);
    Options requestOptions = Options(
      responseType: ResponseType.plain,
      headers: {"Authorization": userToken, "Content-Type": "application/json"},
    );
    Dio dio = Dio();

    var response = await dio.get(apiUserInfo, options: requestOptions);
    if (response.statusCode == 200) {
      if (response.data.toString().contains("html")) {
        Get.snackbar("Error", "Invalid Token");
      } else {
        Map<String, dynamic> body = jsonDecode(response.data);
        var userInfo = UserModel.fromJson(body["user"]);
        context.read(generalmanagment).setUserInfo(userInfo);
        return userInfo;
      }
    }
  }

  // Future requestAds(String userToken, int pageNumer) async {
  //   Dio dio = Dio();
  //   Options requestOptions = Options(
  //     responseType: ResponseType.json,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": userToken,
  //       'Charset': 'utf-8'
  //     },
  //   );
  //   try {
  //     var response = await dio.get(
  //       apiProductsUrl + pageNumer.toString(),
  //       options: requestOptions,
  //     );
  //     if (response.statusCode == 200) {
  //       if (response.data.contains("html")) {
  //         Get.snackbar("Error", "Invalid Token");
  //       } else {
  //         var products =
  //             response.data.map((e) => ProductModel.fromJson(e)).toList();
  //         contextm.read(generalmanagment).addproducts(products[0].data);
  //         contextm.read(generalmanagment).setcurrentpages(++pagenumber);

  //         return products;
  //       }
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }
}
