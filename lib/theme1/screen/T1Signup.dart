import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sciquest_mobile/main/utils/AppWidget.dart';
import 'package:sciquest_mobile/theme1/utils/T1Colors.dart';
import 'package:sciquest_mobile/theme1/utils/T1Constant.dart';
import 'package:sciquest_mobile/theme1/utils/T1Images.dart';
import 'package:sciquest_mobile/theme1/utils/T1Strings.dart';
import 'package:sciquest_mobile/theme1/utils/T1Widget.dart';

import '../../../main.dart';

class T1Signup extends StatefulWidget {
  static var tag = "/T1SignUp";

  @override
  State<T1Signup> createState() => _T1SignupState();
}

class _T1SignupState extends State<T1Signup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fnameController = TextEditingController();

  String _fname = '';
  void initState() {
    super.initState();

    // Start listening to changes.
    _fnameController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('text field: ${_fnameController.text}');
  }

  void onPressedSubmit() {
    //if validate -> save state
    //_formKey.currentState?.save();

    print("Submit Name " + _fnameController.text);
  }

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
                  SizedBox(height: 30),
                  Image.asset(t1_ic_ring, height: 100, width: 100),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      formHeading(t1_lbl_sign_up_header),
                      formSubHeadingForm(t1_lbl_sign_in),
                    ],
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          editTextStyleValidatorOnchanged(
                            t1_hint_fullName,
                            isPassword: false,
                            controller: _fnameController,
                          ),
                          SizedBox(height: 16),
                          editTextStyle(t1_email_phone_no, isPassword: false),
                          SizedBox(height: 16),
                          editTextStyle(t1_hint_password, isPassword: true),
                          SizedBox(height: 16),
                          editTextStyle(t1_hint_re_password, isPassword: true),
                          SizedBox(height: 20),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: shadowButtonWithAction(
                                  t1_lbl_sign_up, onPressedSubmit)),
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
                        ],
                      )),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _fnameController.dispose();
    super.dispose();
  }
}
