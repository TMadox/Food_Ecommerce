import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomButton.dart';
import 'package:test_store/CustomWidgets/CustomFormBuilder.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/NavigationBar.dart';
import 'package:test_store/MainScreens/SignupScreen.dart';
import 'package:test_store/MainScreens/SplashScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Those two variables contain screen's size (width and height).
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (context, watch, child) => ModalProgressHUD(
          inAsyncCall: watch(generalmanagment).isLoading,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Images/Logos/RedSeaLogo.png",
                    scale: width * 0.004,
                  ),
                  SizedBox(
                    height: height * 0.10,
                  ),
                  //  this customformfield contains the 2 input fields and the forgot password/remember me checkbox.
                  customformfield(
                    globalkey: _formkey,
                    context: context,
                  ),
                  customButton(
                      context: context,
                      customOnPressed: () {
                        validation(context);
                      },
                      title: 'تسجيل الدخول',
                      newIcon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      primarycolor: Colors.black,
                      titlecolor: Colors.white),
                  customButton(
                      context: context,
                      customOnPressed: () {
                        Get.to(() => SignupScreen());
                      },
                      title: 'حساب جديد',
                      newIcon: Icon(
                        Icons.person_add,
                        color: Colors.black,
                      ),
                      primarycolor: Colors.white,
                      titlecolor: Colors.black)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future validation(BuildContext contextm) async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      var loginInfo = _formkey.currentState!
          .value; // containes login info extracted from both email and password fields.
      try {
        contextm.read(generalmanagment).setIsLoading();
        await APIRequests().requestLogin(loginInfo);
        if (loginInfo['rememberme']) {
          SharedPreferences.getInstance().then((value) {
            value.setString("email", loginInfo["email"]);
          });
          // this line is disposable..
        }
        contextm.read(generalmanagment).setIsLoading();
        Get.off(() => CustomSplashScreen());
      } on Exception catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }
}
