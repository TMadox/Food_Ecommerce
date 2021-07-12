import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomAppBar.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollController = ScrollController();
  APIRequests portal = APIRequests();
  late String? userToken = "";
  late String? id;
  late var response;
  @override
  void initState() {
    userToken = context.read(generalmanagment).userToken;
    id = context.read(generalmanagment).userId;
    // //////////////////
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          loadData(context);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Consumer(
        builder: (context, watch, child) => Container(
          child: ListView.builder(
              controller: _scrollController,
              itemCount: watch(generalmanagment).orders.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Card(
                    child: ListTile(
                        title: Text("رقم الطلب:  " +
                            watch(generalmanagment)
                                .orders[index]["id"]
                                .toString()),
                        subtitle: Text(watch(generalmanagment)
                                .orders[index]["total"]
                                .toString() +
                            "ُEGB"),
                        leading: SizedBox(
                          height: width * 0.15,
                          width: width * 0.15,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: watch(generalmanagment)
                                        .orders[index]["items"]
                                        .length ==
                                    1
                                ? 1
                                : 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            children: watch(generalmanagment)
                                .orders[index]["items"]
                                .map<Widget>((e) => CachedNetworkImage(
                                      imageUrl: apiBaseUrl +
                                          e["product_id"]["images"][0],
                                      placeholder: (context, url) =>
                                          Image.asset("Images/plcholder.jpeg"),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ))
                                .toList(),
                          ),
                        )),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(generalmanagment).currentOrderPage <=
        context.read(generalmanagment).totalOrdersPages) {
      try {
        await portal.requestUserOrders(userToken!, id.toString(),
            context.read(generalmanagment).currentOrderPage, context);
      } catch (e) {
        print(e);
      }
    }
  }
}
