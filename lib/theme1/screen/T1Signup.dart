import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sciquest_mobile/api/api_services.dart';
import 'package:sciquest_mobile/main/utils/AppWidget.dart';
import 'package:sciquest_mobile/shared_services.dart';
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
  bool isApiCallProcess = false;
  final LocalStorage storage = LocalStorage('sciquest_app');

  TextEditingController _fnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _fname = '';
  void initState() {
    super.initState();

    // Start listening to changes.
    _fnameController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('text field: ${_fnameController.text}');
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
                          editTextStyleValidatorOnchanged(t1_email_phone_no,
                              isPassword: false, controller: _emailController),
                          SizedBox(height: 16),
                          editTextStyle(t1_hint_password,
                              isPassword: true,
                              controller: _passwordController),
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

  void onPressedSubmit() {
    /*
      this function is call on submit button press
      then calls the actual function onSubmit for the API
      results is a snackbar or a redirect call
    */
    onSubmit(context).then((int res) {
      if (res == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User not Found"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      } else if (res == 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Wrong credentials"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      } else if (res == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login Successful"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        ));
        //navigate after success
        //Navigator.of(context).pushReplacementNamed('/mainscreen');
      } else if (res == 3) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Network Failed - Check your Connection"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Future<int> onSubmit(BuildContext context) async {
    /**
      this function is the actual api to our server
      import APISERVICE code
      process all form values into a MAP and send as formdata to api
      results will be in json and processed
     */

    setState(() {
      isApiCallProcess = true;
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to the internet.
      setState(() {
        isApiCallProcess = false;
      });
      return 3;
    } else {
      APIService apiService = APIService();

      Map<String, String> formdata = {
        'name': _fnameController.text,
        'password': _passwordController.text,
        'email': _emailController.text,
        'error': 'true' //Comment out if want to test success
      };

      //perform API call and save results to variable
      var checkloginresults = await apiService.register_user(formdata);

      if (checkloginresults != false) {
        setState(() {
          isApiCallProcess = false;
        });

        //decode the resulting json from the api call
        var jsonresult = jsonDecode(checkloginresults);

        if (jsonresult['error'] == 'true') {
          return 0;
        } else {
          print(jsonresult);
          return 1;
        }
      }
      setState(() {
        isApiCallProcess = false;
      });
      return 0; // api error
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _fnameController.dispose();
    super.dispose();
  }
}
