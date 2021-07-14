import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_store/Variables/ScreenSize.dart';
import 'CustomFormFieldDecoration.dart';

// this is a customformfield widget in a variable form.
// the context her is sent from the main build context of the widget tree of loginscreen.dart
// it is used to run the validation and get screenwidth proportions.
// the globalkey is sent out from the main class,aswell. to insure the form field is pointing to the right direction(key).

// ignore: must_be_immutable
Widget customformfield(
        {required GlobalKey globalkey, required BuildContext context}) =>
    FormBuilder(
      key: globalkey,
      child: Column(
        children: [
          Container(
            width: screenWidth(context) * 0.8,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: FormBuilderTextField(
                  name: 'email',
                  decoration: customformfielddecoration(
                      hinttext: "البريد الالكتروني", context: context),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context,
                        errorText: "بالرجاء ادخال بريد الكتروني صحيح"),
                    FormBuilderValidators.required(
                      context,
                      errorText: "بالرجاء ادخال البريد الالكتروني",
                    )
                  ])),
            ),
          ),
          SizedBox(
            height: screenHeight(context) * 0.03,
          ),
          Container(
            width: screenWidth(context) * 0.8,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: FormBuilderTextField(
                  name: 'password',
                  decoration: customformfielddecoration(
                      hinttext: "كلمة السر", context: context),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(context, 7,
                        errorText:
                            "كلمة السر يجب ان تكون علي الاقل 7 احرف/ارقام/رموز"),
                    FormBuilderValidators.required(
                      context,
                      errorText: "بالرجاء ادخال كلمة السر",
                    )
                  ])),
            ),
          ),
          Container(
            width: screenWidth(context) * 0.8,
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: Text(
                          "نسيت كلمة السر؟",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ))),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: FormBuilderCheckbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      name: "rememberme",
                      title: Text(
                        "تذكرني",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      initialValue: false,
                      tristate: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
