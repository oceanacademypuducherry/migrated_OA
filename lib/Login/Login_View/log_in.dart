import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login/Login_View/otp.dart';

import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isNumValid = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode = '+91';
  List<Map<String, String>> contri = codes;
  bool rememberMe = false;
  String phoneNumber;

  ConfirmationResult confirmationResult;
  getOTP() async {
    LoginResponsive.confirmationResult = await auth.signInWithPhoneNumber(
        '${countryCode.toString()} ${_phoneNumberController.text}');
    LoginResponsive.registerNumber =
        '${countryCode.toString()} ${_phoneNumberController.text}';
    print("${LoginResponsive.confirmationResult}LogIn.confirmationResult");
  }

  // session() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('login', 1);
  //   await prefs.setString('user', _phoneNumberController.text);
  //   print('Otp Submited');
  // }

  List getContryCode() {
    List<String> contryCode = [];
    for (var cCode in contri) {
      contryCode.add(cCode['code']);
    }
    return contryCode;
  }

  _launchURL() async {
    try {
      const url = 'https://oceanacademy.in/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff2b9dd1),
            image: DecorationImage(
                image: MediaQuery.of(context).size.width > 900 &&
                        MediaQuery.of(context).size.width < 1000
                    ? AssetImage('images/login-xs.png')
                    : MediaQuery.of(context).size.width > 1000 &&
                            MediaQuery.of(context).size.width < 1400
                        ? AssetImage('images/login-sm.png')
                        : MediaQuery.of(context).size.width > 1400 &&
                                MediaQuery.of(context).size.width < 1900
                            ? AssetImage('images/login-md.png')
                            : AssetImage('images/login-lg.png'),
                // alignment: Alignment.center,
                fit: BoxFit.cover),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // color: Color(0xff2B9DD1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 500.0,
                  height: 470.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xff006793),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 340,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.0,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: CountryCodePicker(
                                    backgroundColor: Colors.transparent,
                                    onChanged: (object) {
                                      print('object $object');
                                      countryCode = object.toString();
                                    },
                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    initialSelection: getContryCode()[
                                        getContryCode().indexOf('IN')],
                                    countryFilter: getContryCode(),
                                    showFlagDialog: true,
                                    showDropDownButton: true,
                                    dialogBackgroundColor: Colors.white,

                                    hideSearch: false,
                                    dialogSize: Size(300.0, 550.0),
                                    onInit: (code) {
                                      // countryCode = code.toString();

                                      print(
                                          '${countryCode.toString()} countryCode.toString()');
                                    },

                                    dialogTextStyle:
                                        TextStyle(color: Colors.white),
                                    enabled: true,
                                    boxDecoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 70.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50.0,
                                        width: 275.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Enter your Mobile Number',
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder()),
                                          controller: _phoneNumberController,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'^\d+\.?\d{0,1}')),
                                            LengthLimitingTextInputFormatter(
                                                13),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              phoneNumber = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Visibility(
                                          visible: isNumValid,
                                          child: Text(
                                            'Enter valid PhoneNumber',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15.0),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      width: 420.0,
                                      child: Text(
                                        'NEXT',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    hoverColor: Color(0xff023e57),
                                    fillColor: Color(0xff014965),
                                    elevation: 0.0,
                                    onPressed: () async {
                                      print(
                                          "${countryCode.toString()} ${_phoneNumberController.text}_phoneNumberController.text");
                                      setState(() {
                                        //Navbar.visiblity = false;
                                        OTP.userID =
                                            '${countryCode.toString()} ${_phoneNumberController.text}';
                                        // MenuBar.stayUser = OTP.userID;
                                      });

                                      if (_phoneNumberController.text.length >
                                          1) {
                                        //getData();

                                        ///todo remove the hide get otp
                                        //session();
                                        await getOTP();

                                        locator<NavigationService>()
                                            .navigateTo(OTPRoute);
                                      } else {
                                        isNumValid = true;
                                      }
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 430.0,
                                  child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        text:
                                            'By clicking the button above, you are creating an account with Ocean Academy and agree to our ',
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  locator<NavigationService>()
                                                      .navigateTo(
                                                          Privacy_Policy);
                                                  print('Privacy Policy taped');
                                                },
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                  color: Colors.cyanAccent)),
                                          TextSpan(text: ' and '),
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  locator<NavigationService>()
                                                      .navigateTo(
                                                          Terms_And_Condition);
                                                  print('Terms of Use taped');
                                                },
                                              text: 'Terms of Use',
                                              style: TextStyle(
                                                  color: Colors.cyanAccent)),
                                          TextSpan(
                                              text:
                                                  ', including receiving emails. '),
                                        ]),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  width: 500,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xff006793),
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or ',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      TextButton(
                        child: Text(
                          'click here',
                          style: TextStyle(
                              color: Colors.cyanAccent, fontSize: 18.0),
                        ),
                        onPressed: _launchURL,
                      ),
                      Text(
                        ' to visit website',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
