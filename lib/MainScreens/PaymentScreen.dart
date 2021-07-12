import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "الدفع",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final state = watch(generalmanagment);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Card(
                  elevation: 0.1,
                  child: ListTile(
                    title: Text("ألعنوان"),
                  ),
                ),
                Card(
                  elevation: 0.1,
                  child: ListTile(
                    title: Text(
                      "المدينة-شارع-منزل رقم",
                    ),
                  ),
                ),
                Card(
                  elevation: 0.1,
                  child: ListTile(
                    title: Text(
                      "تكلفة الطلب",
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      state.cart.getTotalAmount().toString() + " جنيه مصري",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Card(
                  elevation: 0.1,
                  child: ListTile(
                    title: Text(
                      "تكلفة شحن",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Card(
                  elevation: 0.1,
                  child: ListTile(
                    title: Text(
                      "الاجمالي",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
