import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/FurtherLogic.dart';
import 'package:test_store/Logic/StateManagement.dart';

import 'NavigationBar.dart';

class CustomSplashScreen extends StatelessWidget {
  CustomSplashScreen({Key? key}) : super(key: key);
  APIRequests portal = APIRequests();
  FutherLogic logic = FutherLogic();
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'Images/Logos/RedSeaLogo.png',
      screenFunction: () async {
        await logic.readJson(context);
        await SharedPreferences.getInstance().then((sharedvalue) async =>
            await portal
                .firstSuperRequest(
                    context: context,
                    pageNumber: 1,
                    userId: sharedvalue.getString("user_id").toString(),
                    userToken: sharedvalue.getString("token"))
                .then((value) {
              context
                  .read(generalmanagment)
                  .setUserToken(sharedvalue.getString("token")!);
              context
                  .read(generalmanagment)
                  .setUserId(sharedvalue.getString("user_id").toString());
            }));

        return CustomNavigationBar();
      },
    );
  }
}
