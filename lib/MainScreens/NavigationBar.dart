import 'package:flutter/material.dart';
import 'package:test_store/MainScreens/HomeScreen.dart';
import 'package:test_store/MainScreens/OrdersScreen.dart';
import 'package:test_store/MainScreens/ProfileScreen.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBar createState() => _CustomNavigationBar();
}

class _CustomNavigationBar extends State<CustomNavigationBar> {
  int _currentIndex = 3;
  final _HomeScreen = GlobalKey<NavigatorState>();
  final _OrdersScreen = GlobalKey<NavigatorState>();
  final _CategoriesScreen = GlobalKey<NavigatorState>();
  final _ProfileScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _HomeScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => ProfileScreen(),
            ),
          ),
          Navigator(
            key: _OrdersScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => OrdersScreen(),
            ),
          ),
          Navigator(
            key: _CategoriesScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => HomeScreen(),
            ),
          ),
          Navigator(
            key: _ProfileScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => HomeScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (val) => _onTap(val, context),
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("Images/menu.png")), label: "القائمة"),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("Images/tray.png")),
            label: "الطلبات",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("Images/dish.png")),
            label: "التصنيفات",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("Images/house.png")),
            label: "الرئيسية",
          ),
        ],
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _ProfileScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _OrdersScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _CategoriesScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          _HomeScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
