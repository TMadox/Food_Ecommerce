import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_store/CustomWidgets/CustomAppBar.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/MainScreens/LoginScreen.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'package:shimmer/shimmer.dart';
import 'package:settings_ui/settings_ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  APIRequests portal = APIRequests();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context: context),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer(
              builder: (context, watch, child) => Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: height * 0.06),
                        child: Text(
                          watch(generalmanagment).userInfo!.fullName.toString(),
                          style: TextStyle(fontSize: width * 0.05),
                        ),
                      ),
                      Expanded(
                        child: SettingsList(
                          contentPadding: EdgeInsets.only(top: height * 0.02),
                          backgroundColor: Colors.white,
                          sections: [
                            SettingsSection(
                              tiles: [
                                SettingsTile(
                                  title: 'البريد الالكتروني',
                                  subtitle: watch(generalmanagment)
                                      .userInfo!
                                      .email
                                      .toString(),
                                  leading:
                                      Icon(Icons.mail, color: Colors.black),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'الهاتف',
                                  subtitle: watch(generalmanagment)
                                      .userInfo!
                                      .phone
                                      .toString(),
                                  leading: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                                SettingsTile(
                                  title: 'كلمة السر',
                                  subtitle: "********",
                                  leading: Icon(
                                    Icons.vpn_key,
                                    color: Colors.black,
                                  ),
                                  onPressed: (BuildContext context) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              // ListView(
              //   children: [
              //     // ElevatedButton(
              //     //     onPressed: () {
              //     //       Navigator.push(context,
              //     //           MaterialPageRoute(builder: (BuildContext context) {
              //     //         return LoginScreen();
              //     //       }));
              //     //     },
              //     //     child: Text("data")),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text("البريد الالكتروني"),
              //         subtitle: Text(
              //             watch(generalmanagment).userInfo!.email.toString()),
              //       ),
              //     ),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text("رقم الهاتف"),
              //         subtitle: Text(
              //             watch(generalmanagment).userInfo!.phone.toString()),
              //       ),
              //     ),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text("كلمة السر"),
              //         subtitle: Text("*********"),
              //       ),
              //     ),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text(""),
              //         subtitle: Text(""),
              //       ),
              //     ),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text(""),
              //         subtitle: Text(""),
              //       ),
              //     ),
              //     Card(
              //       elevation: 0.1,
              //       child: ListTile(
              //         title: Text(""),
              //         subtitle: Text(""),
              //       ),
              //     ),
              //   ],
              // ),
              ),
        ));
  }
}
