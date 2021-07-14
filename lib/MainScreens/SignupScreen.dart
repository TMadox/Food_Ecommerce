import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomButton.dart';
import 'package:test_store/CustomWidgets/CustomFormFieldDecoration.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/LoginScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'HomeScreen.dart';

class SignupScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    // Those two variables contain screen's size (width and height).
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height*0.1,),
                Image.asset(
                  "Images/Logos/RedSeaLogo.png",
                  scale: width * 0.004,
                ),
                FormBuilder(
                  key: _formkey,
                  child: Wrap(
                    runSpacing: height * 0.02,
                    children: [
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'first_name',
                            decoration: customformfielddecoration(
                                hinttext: "الاسم الاول", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال الاسم الاول"),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'last_name',
                            decoration: customformfielddecoration(
                                hinttext: "الاسم الاخير", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال الاسم الاخير"),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                              name: 'email',
                              decoration: customformfielddecoration(
                                  hinttext: "البريد الالكتروني",
                                  context: context),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.email(context,
                                    errorText:
                                        "بالرجاء ادخال بريد الكتروني صحيح"),
                                FormBuilderValidators.required(
                                  context,
                                  errorText: "بالرجاء ادخال البريد الالكتروني",
                                )
                              ])),
                        ),
                      ),
                      Container(
                        width: width* 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'password',
                            decoration: customformfielddecoration(
                                hinttext: "كلمة السر", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال كلمة السر"),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'password_confirmation',
                            decoration: customformfielddecoration(
                                hinttext: "تأكيد كلمة السر", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: " بالرجاء ادخال كلمة السر مجددا"),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'phone',
                            decoration: customformfielddecoration(
                                hinttext: "رقم الهاتف", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال رقم الهاتف"),
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.8,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: FormBuilderTextField(
                            name: 'address',
                            decoration: customformfielddecoration(
                                hinttext: "العنوان", context: context),
                            validator: FormBuilderValidators.required(context,
                                errorText: "بالرجاء ادخال العنوان"),
                          ),
                        ),
                      ),
                      customButton(
                          customOnPressed: () {
                            validation(context);
                          },
                          context: context,
                          title: "حساب جديد",
                          newIcon: Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          primarycolor: Colors.black,
                          titlecolor: Colors.white),
                      customButton(
                          customOnPressed: () {
                            Get.to(() => LoginScreen());
                          },
                          context: context,
                          title: "تسجيل دخول ",
                          newIcon: Icon(
                            Icons.login,
                            color: Colors.black,
                          ),
                          primarycolor: Colors.white,
                          titlecolor: Colors.black)
                    ],
                  ),
                )
              ],
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
        var response = await APIRequests().requestSignUp(loginInfo);
        contextm.read(generalmanagment).setIsLoading();
        // Get.off(() => Login());
      } on Exception catch (e) {
        if (e is DioError) {
          Get.snackbar("Error", e.response!.data.values.toString());
        }
        contextm.read(generalmanagment).setIsLoading();
      }
    }
  }
}
