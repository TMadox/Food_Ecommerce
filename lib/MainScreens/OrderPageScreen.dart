import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/DeliveryStatues.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';


class OrderPageScreen extends StatelessWidget  {
  final int index;
  const OrderPageScreen({Key? key,required this.index }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {

                Navigator.of(context).pop();
              },
              icon: ImageIcon(
                AssetImage("Images/arrow.png"),
                color: Colors.black,
              ))
        ],
        title: Text(
          "معلومات الطلب",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body:
      Consumer(
        builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final state =watch(generalmanagment);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: state.orders[index]["items"].length,
              itemBuilder: (context,listindex){
                final item = state.orders[index]["items"][listindex]["product_id"];
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: screenWidth(context)*0.25,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: apiBaseUrl +
                            item["images"][0],
                        placeholder: (context, url) =>
                            Image.asset("Images/plcholder.jpeg"),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),
                    ),
                  title: Text(item["name"]),
                    subtitle: new RichText(
                      text: new TextSpan(
                        children: <TextSpan>[
                          new TextSpan(
                            text: " جم. " + (state.products[index]["price"] - state.products[index]["discount"]).toString(),
                            style: new TextStyle(
                                color: Colors.black,
                            ),
                          ),
                          new TextSpan(
                            text: "  ",
                            style: new TextStyle(
                              color: Colors.black,

                            ),
                          ),
                          new TextSpan(
                            text:   state.products[index]["price"].toString()  ,
                            style: new TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),

                    trailing: deliveryStatues(),
              ),
                );}),
          );  },

      ),
    );
  }
}
