import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final General portal = General();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context
          .read(generalmanagment)
          .ultramethod("Bearer 1181|Qxd9laSMxbYP2rTeHOpE4g4FqguFCZRz1y0nO2KO")
          .then((value) => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = screenWidth(context);
    var height = screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Test-Model"),
      ),
      body: context.read(generalmanagment).categories != null
          ? ListView(
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.06),
                    )),
                Consumer(
                  builder: (context, watch, child) => Container(
                    height: height * 0.2,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: watch(generalmanagment)
                            .categories[0]['data']
                            .length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contect, index) {
                          return Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: "https://flkwatches.flk.sa/" +
                                    watch(generalmanagment).categories[0]
                                        ['data'][index]["image"],
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Text(watch(generalmanagment).categories[0]['data']
                                  [index]["name"]),
                              Text(watch(generalmanagment).categories[0]['data']
                                  [index]["seo_description"])
                            ],
                          ));
                        }),
                  ),
                ),
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Products",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.06),
                    )),
                Consumer(
                  builder: (context, watch, child) => Container(
                    height: height * 0.2,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            watch(generalmanagment).products[0]['data'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contect, index) {
                          return Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: "https://flkwatches.flk.sa/" +
                                    watch(generalmanagment)
                                        .products[0]['data'][index]["images"]!
                                        .toString(),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Text(watch(generalmanagment).products[0]['data']
                                  [index]["name"]),
                              Text(watch(generalmanagment)
                                  .products[0]['data'][index]["price"]
                                  .toString())
                            ],
                          ));
                        }),
                  ),
                ),
                Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "Orders",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.06),
                    )),
                Consumer(
                  builder: (context, watch, child) => Container(
                    height: height * 0.2,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            watch(generalmanagment).orders['links'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (contect, index) {
                          return Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // CachedNetworkImage(
                              //   imageUrl: "https://flkwatches.flk.sa/" +
                              //       watch(generalmanagment)
                              //           .orders[0]['data'][index]["images"]!
                              //           .toString(),
                              //   placeholder: (context, url) =>
                              //       CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       Icon(Icons.error),
                              // ),
                              Text(watch(generalmanagment).orders['links']
                                  [index]["label"]),
                              Text(watch(generalmanagment)
                                  .orders['links'][index]["active"]
                                  .toString())
                            ],
                          ));
                        }),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(generalmanagment).test();
        },
      ),
    );
  }
}
// ListView(
//         children: [
//           Container(
//               alignment: AlignmentDirectional.center,
//               child: Text(
//                 "Categories",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: width * 0.06),
//               )),
//           Consumer(
//             builder: (context, watch, child) => Container(
//               height: height * 0.2,
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount:
//                       watch(generalmanagment).categories[0]['data'].length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (contect, index) {
//                     return Card(
//                         child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CachedNetworkImage(
//                           imageUrl: "https://flkwatches.flk.sa/" +
//                               watch(generalmanagment).categories[0]['data']
//                                   [index]["image"],
//                           placeholder: (context, url) =>
//                               CircularProgressIndicator(),
//                           errorWidget: (context, url, error) =>
//                               Icon(Icons.error),
//                         ),
//                         Text(watch(generalmanagment).categories[0]['data']
//                             [index]["name"]),
//                         Text(watch(generalmanagment).categories[0]['data']
//                             [index]["seo_description"])
//                       ],
//                     ));
//                   }),
//             ),
//           ),
//           Container(
//               alignment: AlignmentDirectional.center,
//               child: Text(
//                 "Products",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, fontSize: width * 0.06),
//               )),
//           // Container(
//           //   height: height * 0.2,
//           //   child: ListView.builder(
//           //       shrinkWrap: true,
//           //       itemCount: state.categories[0]['data'].length,
//           //       scrollDirection: Axis.horizontal,
//           //       itemBuilder: (contect, index) {
//           //         return Card(
//           //             child: Column(
//           //           mainAxisAlignment: MainAxisAlignment.center,
//           //           children: [
//           //             CachedNetworkImage(
//           //               imageUrl: "https://flkwatches.flk.sa/" +
//           //                   state.products[0]['data'][index]["images"][0],
//           //               placeholder: (context, url) =>
//           //                   CircularProgressIndicator(),
//           //               errorWidget: (context, url, error) => Icon(Icons.error),
//           //             ),
//           //             Text(state.products[0]['data'][index]["name"]),
//           //             Text(state.products[0]['data'][index]["pos_price"]
//           //                 .toString())
//           //           ],
//           //         ));
//           //       }),
//           // ),
//         ],
//       ),