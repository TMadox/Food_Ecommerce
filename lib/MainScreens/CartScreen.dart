import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/CustomButton.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/PaymentScreen.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text(
          "عربة التسوق",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
        elevation: 1,
      ),
      body: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer(builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final state = watch(generalmanagment);
            return state.cart.getCartItemCount() == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Images/empty-cart.png",
                        scale: screenWidth(context) * 0.01,
                      ),
                      Text(
                        "العربة فارغة",
                        style: TextStyle(fontSize: screenWidth(context) * 0.1),
                      )
                    ],
                  ))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.cart.cartItem.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  trailing: IconButton(
                                      onPressed: () {
                                        state.deleteFromCart(index);
                                      },
                                      icon: Icon(Icons.cancel_outlined)),
                                  title: Text(
                                    state.cart.cartItem[index].productName
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth(context) * 0.045),
                                  ),
                                  leading: Container(
                                    width: screenWidth(context) * 0.25,
                                    child: CachedNetworkImage(
                                      imageUrl: state
                                          .cart.cartItem[index].uniqueCheck,
                                      placeholder: (context, url) =>
                                          Image.asset("Images/plcholder.jpeg"),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.cart.cartItem[index].unitPrice
                                              .toString() +
                                          "EGB" +
                                          "\n كيلو"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                state.incrementProduct(index);
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.deepPurple,
                                              )),
                                          Text(
                                            state.cart.cartItem[index].quantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: screenWidth(context) *
                                                    0.04),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                state.decrementProduct(index);
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.deepPurple,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: screenWidth(context) * 0.045),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          "هل لديك كود خصم ؟",
                          style:
                              TextStyle(fontSize: screenWidth(context) * 0.045),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.bottomStart,
                        padding: EdgeInsets.only(
                            left: screenWidth(context) * 0.03,
                            right: screenWidth(context) * 0.03),
                        child: FormBuilder(
                            key: _formkey,
                            child: FormBuilderTextField(
                              name: 'discount',
                              decoration: InputDecoration(
                                  isDense: true,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  fillColor: offwhite,
                                  filled: true,
                                  hintText: "كود خصم"),
                            )),
                      ),
                      Divider(
                        color: Colors.black,
                        endIndent: screenWidth(context) * 0.08,
                        indent: screenWidth(context) * 0.08,
                      ),
                      ListTile(
                        title: Text("اجمالي المبلغ"),
                        trailing: Text(
                          state.cart.getTotalAmount().toString() + " جنيه مصري",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth(context) * 0.05),
                        ),
                      ),
                      customButton(
                          context: context,
                          customOnPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return PaymentScreen();
                            }));
                          },
                          newIcon: Icon(Icons.shopping_bag),
                          primarycolor: Colors.black,
                          title: 'تاكيد الطلب',
                          titlecolor: Colors.white)
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
