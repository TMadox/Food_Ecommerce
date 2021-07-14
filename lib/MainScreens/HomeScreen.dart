import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomAppBar.dart';
import 'package:test_store/CustomWidgets/addToCartButton.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/ShowProductScreen.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Models/ProductModel.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  APIRequests portal = APIRequests();
  late int totalpages = 0;
  String? userToken;
  late var response;

  @override
  initState() {
    super.initState();
    userToken = context.read(generalmanagment).userToken;

    //////// to listen to the list and detect if it has reached the bottom and load more data.
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          loadData(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = screenWidth(context);
    var height = screenHeight(context);
    return Container(
      child: Scaffold(
        appBar: customAppBar(context: context),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: CarouselSlider.builder(
                      options: CarouselOptions(height: 400.0),
                      itemCount: 10,
                      itemBuilder: (context, index, pageindex) => Container(
                            width: width,
                            color: Colors.red,
                            child: Text(index.toString()),
                          )),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Consumer(builder: (context, watch, child) {
                final state = watch(generalmanagment);
                return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return Center(
                          child: InkWell(
                        onTap: () {
                            Navigator.push(context,
              MaterialPageRoute(
                builder: (BuildContext context) {
            return ShowProductScreen(index: index,);
          }));
                        },
                        child: Card(
                          elevation: 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: CachedNetworkImage(
                                imageUrl: apiBaseUrl +
                                    state.products[index]["images"][0],
                                placeholder: (context, url) =>
                                    Image.asset("Images/plcholder.jpeg"),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  title: Text(state.products[index]["name"]),
                                  subtitle: Text(
                                    state.products[index]["price"].toString() +
                                        "EGB",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                              addToCartButton(
                                  context: context,
                                  itemId:
                                      state.products[index]['id'].toString(),
                                  customIcon: state.checkItemInCart(state
                                          .products[index]['id']
                                          .toString())
                                      ? Icon(Icons.check)
                                      : Icon(Icons.shopping_cart),
                                  title: state.checkItemInCart(state
                                          .products[index]['id']
                                          .toString())
                                      ? "في العربة"
                                      : "اضف الي العربة",
                                  price: state.products[index]["price"],
                                  productName: state.products[index]["name"],
                                  imageUrl: apiBaseUrl +
                                      state.products[index]["images"][0])
                            ],
                          ),
                        ),
                      ));
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(generalmanagment).currentProductPage <=
        context.read(generalmanagment).totalProductsPages) {
      try {
        await portal.requestProducts(userToken, context,
            context.read(generalmanagment).currentProductPage, false);
      } catch (e) {
        print(e);
      }
    }
  }
}
