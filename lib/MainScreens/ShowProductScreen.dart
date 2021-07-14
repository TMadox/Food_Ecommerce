import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/CustomWidgets/CustomButton.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class ShowProductScreen extends StatelessWidget {
  final int index;
  const ShowProductScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(

        title: Text(
            context.read(generalmanagment).products[index]["name"],
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer( builder:(context,watch,child) {
          final state = watch(generalmanagment);
          return
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: ListTile.divideTiles(context:context,tiles:[
                  CarouselSlider.builder(
                    options: CarouselOptions(enlargeCenterPage: false,viewportFraction: 1,),
                    itemCount: context
                        .read(generalmanagment)
                        .products[index]["images"].length,
                    itemBuilder: (context, imgindex, pageindex) =>
                        Container(
                          width: screenWidth(context),
                          color: Colors.transparent,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: apiBaseUrl +
                                state.products[index]["images"][imgindex],
                            placeholder: (context, url) =>
                                Image.asset("Images/plcholder.jpeg"),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )),
                  ListTile(title: Text(state.products[index]["name"],style: TextStyle(fontSize: screenWidth(context)*0.07),),subtitle: new RichText(
                    text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                          text: " جنيه مصري " + (state.products[index]["price"] - state.products[index]["discount"]).toString(),
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth(context)*0.05

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
                  )
                    ,)
                ,  ListTile(title: Text("الوصف",style: TextStyle(),),subtitle: Text(state.products[index]["description"]) ,)
                  ,  ListTile(title: Text("الكمية",style: TextStyle(),),subtitle: Text(1.toString()) ,trailing: Text("كيلو"),),
                  state.products[index]["options"]==1? Column(
                    children: ListTile.divideTiles(context: context,tiles: state.products[index]["vars"].map<Widget>((e)=>ListTile(title: Text(e["name"]),)).toList()
                  ).toList()):Container()

                ] ).toList()
              ),
              customButton(context: context, titlecolor: Colors.white, title: state.checkItemInCart(state
                  .products[index]['id']
                  .toString())
                  ? "في العربة"
                  : "اضف الي العربة", newIcon: state.checkItemInCart(state
              .products[index]['id']
              .toString())
          ? Icon(Icons.check)
              : Icon(Icons.add_shopping_cart), customOnPressed: () {      context
                  .read(generalmanagment)
                  .addOrRemovefromCart(   state.products[index]['id'].toString(),state.products[index]['price'], state.products[index]['name'].toString(),state.products[index]['images'][0].toString()); }, primarycolor: Colors.black)
            ],
          );
        }
        ),
      ),
    );
  }
}
