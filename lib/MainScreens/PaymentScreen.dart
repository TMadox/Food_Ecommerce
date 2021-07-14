import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:test_store/Logic/APIRequests.dart';
import 'package:test_store/Logic/StateManagement.dart';
import 'package:test_store/Variables/ScreenSize.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  APIRequests portal = APIRequests();

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    double height = screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          "الدفع",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context,
            T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
          final state = watch(generalmanagment);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: FormBuilder(
                key: _formKey,
                child: SettingsList(
                  contentPadding: EdgeInsets.only(top: height * 0.02),
                  backgroundColor: Colors.white,
                  sections: [
                    SettingsSection(
                      title: "معلومات التوصيل ",
                      titleTextStyle: TextStyle(color: Colors.black),
                      tiles: [
                        SettingsTile(
                          enabled: false,
                          titleTextStyle: TextStyle(color: Colors.black),
                          title: 'العنوان:',
                          trailing: Container(
                            width: width * 0.5,
                            child: FormBuilderTextField(
                              name: 'address',
                              cursorColor: Colors.black,
                              validator:
                                  FormBuilderValidators.required(context),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: height * 0.02, right: width * 0.05,),
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                          leading: Icon(Icons.location_on, color: Colors.black),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          enabled: false,
                          title: 'المحافظة:',
                          titleTextStyle: TextStyle(color: Colors.black),
                          trailing: Container(
                            width: width * 0.5,
                            child: FormBuilderDropdown(
                              name: 'gov',
                              allowClear: true,
                              hint: Text("اختر محافظتك"),
                              onChanged: (value) {
                                state.setSelectedGov(value);
                                _formKey.currentState!.fields["city"]!
                                    .setValue(null);
                              },
                              items: state.governorates
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                          e["governorate_name_ar"],
                                          textAlign: TextAlign.center,
                                        ),
                                        value: e["id"],
                                      ))
                                  .toList(),
                              validator:
                                  FormBuilderValidators.required(context),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: height * 0.015, right: width * 0.05),
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                          leading: ImageIcon(AssetImage("Images/egypt.png"),
                              color: Colors.black),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          enabled: false,
                          titleTextStyle: TextStyle(color: Colors.black),
                          title: 'المدينة:',
                          trailing: Container(
                            width: width * 0.5,
                            child: FormBuilderDropdown(
                              name: 'city',
                              allowClear: true,
                              hint: Text("اختر المدينة"),
                              enabled: state.selectedGov != null,
                              items: state.cities
                                  .where((element) {
                                    if (element["governorate_id"] ==
                                        state.selectedGov) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  })
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                          e["city_name_ar"],
                                          textAlign: TextAlign.center,
                                        ),
                                        value: e["id"],
                                      ))
                                  .toList(),
                              validator:
                                  FormBuilderValidators.required(context),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: height * 0.015, right: width * 0.05),
                                isDense: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                          leading: ImageIcon(AssetImage("Images/buildings.png"),
                              color: Colors.black),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                            leading: ImageIcon(
                                AssetImage("Images/money-bag.png"),
                                color: Colors.black),
                            title: "تكلفة الطلب",
                            trailing: Text(
                              state.cart.getTotalAmount().toString() +
                                  " جنيه مصري",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SettingsTile(
                            leading:
                                Icon(Icons.local_shipping, color: Colors.black),
                            title: "تكلفة الشحن",
                            trailing: state.selectedGov == null
                                ? Text("...")
                                : Text(
                                    state.countries
                                            .where((element) =>
                                                element["id"] ==
                                                int.parse(state.selectedGov))
                                            .toList()[0]["price"]
                                            .toString() +
                                        " جنيه مصري",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                        SettingsTile(
                            leading: ImageIcon(
                              AssetImage("Images/money.png"),
                              color: Colors.black,
                            ),
                            title: "الاجمالي",
                            trailing: state.selectedGov == null
                                ? Text("...")
                                : Text(
                                    (state.countries
                                                    .where((element) =>
                                                        element["id"] ==
                                                        int.parse(
                                                            state.selectedGov))
                                                    .toList()[0]["price"] +
                                                state.cart.getTotalAmount())
                                            .toString() +
                                        " جنيه مصري",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
