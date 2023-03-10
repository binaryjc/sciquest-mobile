import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sciquest_mobile/main/utils/AppWidget.dart';
import 'package:sciquest_mobile/theme1/utils/T1Colors.dart';
import 'package:sciquest_mobile/theme1/utils/T1Constant.dart';
import 'package:sciquest_mobile/theme1/utils/T1Images.dart';
import 'package:sciquest_mobile/theme1/utils/T1Strings.dart';
import 'package:sciquest_mobile/theme1/utils/T1Widget.dart';

import '../../../main.dart';

//Uriah De La Cruz - Test Signup No Details yet

class SignupTest extends StatefulWidget {
  static var tag = "/SignupTest";

  @override
  State<SignupTest> createState() => _SignupTestState();
}

class _SignupTestState extends State<SignupTest> {
  String dropdownvalue1 = 'School';
  String dropdownvalue2 = 'Male'; 

  var afilliations = ['School', 'Government', 'Agency',];

  var sex = ['Male', 'Female', 'Complicated',];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Observer(
            builder: (_) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      formHeading(t1_lbl_sign_up),
                    ],
                  ),
                  
                  SizedBox(height: 40),
                  Text("Affiliation Type:"),
                  Padding(padding: EdgeInsets.all(5.0),
                  child: DropdownButton(
                      
                    // Initial Value
                    value: dropdownvalue1,
                      
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),    
                      
                    // Array list of items
                    items: afilliations.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) { 
                      setState(() {
                        dropdownvalue1 = newValue!;
                      });
                    },
                  ),
                  ),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_afilName, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_firstName, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_middleName, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_lastName, isPassword: false),
                  SizedBox(height: 16),
                  Text("Sex:"),
                  Padding(padding: EdgeInsets.all(5.0),
                  child: DropdownButton(
                      
                    // Initial Value
                    value: dropdownvalue2,
                      
                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),    
                      
                    // Array list of items
                    items: sex.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) { 
                      setState(() {
                        dropdownvalue2 = newValue!;
                      });
                    },
                  ),
                  ),
                  SizedBox(height: 16),
                  editTextStyle(t1_email_phone_no, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_contact, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_address, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_age, isPassword: false),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_password, isPassword: true),
                  SizedBox(height: 16),
                  editTextStyle(t1_hint_re_password, isPassword: true),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: shadowButton(t1_lbl_sign_up)),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text(t1_lbl_already_have_account,
                          textColor: appStore.textSecondaryColor,
                          fontSize: textSizeLargeMedium),
                      SizedBox(width: 8),
                      text(t1_lbl_sign_in,
                          fontFamily: fontMedium, textColor: t1_blue)
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
