import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomButton.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_store/MainScreens/PasswordResetScreen.dart';
import 'package:test_store/Variables/ColorsNConstants.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  APIRequests portal = APIRequests();
  String? userPassword;
  @override
  void initState() {
    userPassword = context.read(generalmanagment).userPassword;
    super.initState();
  }

  final _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                context.read(generalmanagment).setSelectedGov(null);
                Navigator.of(context).pop();
              },
              icon: ImageIcon(
                AssetImage("Images/arrow.png"),
                color: Colors.black,
              ))
        ],
        title: Text(
          "تعديل البينات الشخصية",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Consumer(builder: (context, watch, child) {
          final state = watch(generalmanagment);
          return Column(
            children: [
              FormBuilder(
                key: _formkey,
                child: Expanded(
                    child: ListView(
                  children: [
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("الاسم الاول"),
                        subtitle: FormBuilderTextField(
                          initialValue: state.userInfo!.firstName,
                          name: 'first_name',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "الاسم الاول",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("أسم العائلة"),
                        subtitle: FormBuilderTextField(
                          name: 'last_name',
                          initialValue: state.userInfo!.secondName,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "أسم العائلة",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("رقم الهاتف"),
                        subtitle: FormBuilderTextField(
                          initialValue: state.userInfo!.phone,
                          name: 'phone',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "رقم الهاتف",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("العنوان"),
                        subtitle: FormBuilderTextField(
                          initialValue: state.userInfo!.address,
                          name: 'address',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "العنوان",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        title: Text("البريد الاكتروني"),
                        subtitle: FormBuilderTextField(
                          initialValue: state.userInfo!.email,
                          name: 'email',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: offwhite,
                            hintText: "البريد الاكتروني",
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.only(
                                top: height * 0.04, right: width * 0.05),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              Card(
                elevation: 0.2,
                child: ListTile(
                  title: Text("كلمة السر"),
                  subtitle: TextFormField(
                    obscureText: true,
                    initialValue: userPassword,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: offwhite,
                      hintText: "كلمة السر",
                      labelStyle: TextStyle(),
                      contentPadding: EdgeInsets.only(
                          top: height * 0.04, right: width * 0.05),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              customButton(
                  customOnPressed: () async {
                    await validation();
                  },
                  context: context,
                  title: "حفظ البيانات الشخصية",
                  primarycolor: Colors.black,
                  titlecolor: Colors.white,
                  newIcon: Icon(
                    Icons.done,
                    color: Colors.white,
                  )),
              customButton(
                  customOnPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return PasswordResetScreen();
                    }));
                  },
                  context: context,
                  title: "تغيير كلمة السر",
                  primarycolor: Colors.white,
                  titlecolor: Colors.black,
                  newIcon: Icon(
                    Icons.change_circle,
                    color: Colors.black,
                  ))
            ],
          );
        }),
      ),
    );
  }

  Future validation() async {
    var pref = await SharedPreferences.getInstance();
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      var editInfo = _formkey.currentState!.value;
      Get.defaultDialog(
          title: "Confirmation",
          content: Text("هل انت واثق من تغيير تلك المعلومات عن حسابك؟"),
          confirm: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "لا",
              style: TextStyle(color: Colors.black),
            ),
          ),
          cancel: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              onPressed: () async {
                try {
                  Get.defaultDialog(
                      title: "جاري التنفيذ",
                      content: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                      barrierDismissible: false);
                  await portal.requestChangeInfo(
                      pref.getString("token"), editInfo, context);
                  Get.back();
                  Get.back();
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: "!تم بنجاح",
                    content: Icon(Icons.check_circle),
                    confirm: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: () {
                        _formkey.currentState!.reset();
                        Get.back();
                      },
                      child: Text(
                        "تأكيد",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } on Exception catch (e) {
                  Get.back();
                  Get.back();
                  Get.snackbar("Error", e.toString());
                }
              },
              child: Text("نعم")));
    }
  }
}
