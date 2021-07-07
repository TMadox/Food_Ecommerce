import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';

class APIRequests {
  static late CacheStore? cacheStore;
  // we will start with implementing and running the following methods to build a prototype.
  //the following function is used to retrieve products from the server-side using API endpoint.
  static Future retrieveproducts(String token) async {
    try {
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      final response = await Dio().get("https://flkwatches.flk.sa/api/products",
          options: requestOptions);
      return response.data;
    } catch (e) {}
  }

// the following function is used to retrieve categories of the products.
  static Future retrievecategories(String token) async {
    try {
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      final response = await Dio().get("https://flkwatches.flk.sa/api/category",
          options: requestOptions);
      return response.data;
    } catch (e) {}
  }

  static Future retrieveorders(String token) async {
    try {
      Options requestOptions = Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
          'Charset': 'utf-8'
        },
      );
      final response = await Dio().get(
          "https://flkwatches.flk.sa/api/orders?customer_id=39&page=1",
          options: requestOptions);
   
      return response.data;
    } catch (e) {}
  }
}
