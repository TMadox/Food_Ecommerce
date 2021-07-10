import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  APIRequests portal = APIRequests();
  late String? userToken = "";
  late var response;
  static int _currentpagenumber = 1;
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      userToken = value.getString("token");
      response = portal
          .requestUserOrders(userToken!, "3", _currentpagenumber, context)
          .then((value) {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Consumer(
      builder: (context, watch, child) => Container(
        child: ListView.builder(
            itemCount: watch(generalmanagment).orders.length,
            itemBuilder: (context, index) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Card(
                  child: ListTile(
                    title: Text("رقم الطلب:  " +
                        watch(generalmanagment).orders[index]["id"].toString()),
                    subtitle: Text(watch(generalmanagment)
                        .orders[index]["total"]
                        .toString()),
                  ),
                ),
              );
            }),
      ),
    ));
  }
}
