import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomAppBar.dart';
import 'package:test_store/CustomWidgets/addToCartButton.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
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
  static int _currentpagenumber = 1;
  late int totalpages = 0;
  late String? userToken = "";
  late var response;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      userToken = value.getString("token");
      response = portal
          .requestProducts(userToken, context, _currentpagenumber, false)
          .then((value) {
        context.read(generalmanagment).settotalpages(value[0].lastPage);
      });
    });
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
              child: Consumer(
                builder: (context, watch, child) =>
                    watch(generalmanagment).products.length == 0
                        ? Container(
                            padding: EdgeInsets.only(top: height * 0.3),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: watch(generalmanagment).products.length,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: Card(
                                elevation: 0.1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: CachedNetworkImage(
                                      imageUrl: apiBaseUrl +
                                          watch(generalmanagment)
                                              .products[index]["images"][0],
                                      placeholder: (context, url) =>
                                          Image.asset("Images/plcholder.jpeg"),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        title: Text(watch(generalmanagment)
                                            .products[index]["name"]),
                                        subtitle: Text(
                                          watch(generalmanagment)
                                                  .products[index]["price"]
                                                  .toString() +
                                              "EGB",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                    addToCartButton()
                                  ],
                                ),
                              ));
                            }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(generalmanagment).currentPage <=
        context.read(generalmanagment).totalPages) {
      try {
        await portal.requestProducts(userToken, context,
            context.read(generalmanagment).currentPage, false);
      } catch (e) {
        print(e);
      }
    }
  }
}
