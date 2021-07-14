import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/CustomWidgets/CustomAppBar.dart';
import 'package:test_store/CustomWidgets/addToCartButton.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _scrollController = ScrollController();
  APIRequests portal = APIRequests();
  String? userToken;
  int? totalCatPages;
  initState() {
    super.initState();
    userToken = context.read(generalmanagment).userToken;
    totalCatPages = context.read(generalmanagment).totalCategoryPages;
    //////// to listen to the list and detect if it has reached the bottom and load more data.
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        final isBottom = _scrollController.position.pixels != 0;
        if (isBottom) {
          print("here");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context: context),
        body: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final state = watch(generalmanagment);
          

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  shadowColor: Colors.transparent,
                  toolbarHeight: screenHeight(context) * 0.06,
                  actions: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        width: screenWidth(context),
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: EdgeInsets.only(
                                  left: screenWidth(context) * 0.02,
                                ),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: state.selectedCategory ==
                                              state.categories[index]["id"]
                                                  .toString()
                                          ? Colors.black
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onPressed: () {
                                      state.setSelectedCategory(state
                                          .categories[index]["id"]
                                          .toString());
                                    },
                                    child: Text(
                                      state.categories[index]["name"],
                                      style: TextStyle(
                                          color: state.selectedCategory ==
                                                  state.categories[index]["id"]
                                                      .toString()
                                              ? Colors.white
                                              : Colors.black),
                                    )));
                          },
                        ),
                      ),
                    ),
                  ],
                  expandedHeight: screenHeight(context) * 0.1,
                ),
                SliverToBoxAdapter(
                  child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: state.products.length,
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
                        ));
                      }),
                )
              ],
            );
          },
        ));
  }

  Future<void> loadData(BuildContext context) async {
    if (context.read(generalmanagment).currentCategoryPage <=
        context.read(generalmanagment).totalCategoryPages) {
      try {
        await portal.requestCategoriesList(userToken, context,
            context.read(generalmanagment).currentCategoryPage);
      } catch (e) {
        print(e);
      }
    }
  }
}
