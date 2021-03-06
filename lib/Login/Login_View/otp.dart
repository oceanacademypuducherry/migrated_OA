import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';

import 'package:flutter_app_newocean/Login/login_widget/new_user_widget/otp_inputs.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../route/navigation_locator.dart';
import '../../route/navigation_service.dart';
import '../../route/routeNames.dart';

// ignore: must_be_immutable
class OTP extends StatefulWidget {
  OTP({this.confirmationResult, this.number});
  static String userID;
  ConfirmationResult confirmationResult;
  String number;
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String otp;
  TextEditingController _otp = TextEditingController();
  UserCredential userCredential;
  String count;
  bool isLogin = false;
  _clickHere() async {
    try {
      const url = 'https://oceanacademy.in';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> otpCount(int count) {
    List<Widget> otp = [];
    for (int i = 0; i < count; i++) {
      otp.add(OTPInput());
    }
    otp.insert(0, SizedBox(width: 5));
    int lis = otp.length;
    otp.insert(lis, SizedBox(width: 5));
    return otp;
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', OTP.userID);
    // await prefs.setBool('isSession', true);

    print("${OTP.userID} ssssssssssssss");
    print('Otp Submited');
  }

  final valueController = Get.find<ValueListener>();
  _verifyOtp() async {
    try {
      userCredential =
          await LoginResponsive.confirmationResult.confirm(_otp.text);
      print('success');
      userSession =
          await _firestore.collection('new users').doc(OTP.userID).get();
      if (userSession.data() != null) {
        locator<NavigationService>().navigateTo(
            '/ClassRoom?userNumber=${OTP.userID}&typeOfCourse=${valueController.courseType.value}');
        valueController.navebars.value = 'Login';
        valueController.userNumber.value = OTP.userID;
        print(valueController.userNumber.value);
        session();
      } else {
        locator<NavigationService>().navigateTo(RegistrationRoute);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OTP Invalid',
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      )));
    }
  }

  var userSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: MediaQuery.of(context).size.width > 700
            ? DesktopOtp(context)
            : MobileOtp(context),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container DesktopOtp(BuildContext context) {
    return Container(
      color: Color(0xff2B9DD1),
      child: Center(
        child: Container(
          width: 500,
          height: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 600.0,
                height: 500.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: Color(0xff006793),
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 55.0,
                                width: 450,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: OTPTextField(
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldWidth: 50,
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onCompleted: (value) {
                                    _otp.text = value;
                                  },
                                ),
                              ),
                            ],
                            // children: otpCount(6),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Countdown(
                                seconds: 600,
                                build: (BuildContext context, double time) =>
                                    Text(
                                  '${(time ~/ 60).toString().length == 1 ? "0" + (time ~/ 60).toString() : (time ~/ 60)} : ${(time % 60).toString().length == 1 ? "0" + (time % 60).toString() : (time % 60)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.0,
                                  ),
                                ),
                                onFinished: () {
                                  // Provider.of<Routing>(context,
                                  //         listen: false)
                                  //     .updateRouting(widget: LogIn());
                                  // Provider.of<MenuBar>(context,
                                  //         listen: false)
                                  //     .updateMenu(
                                  //         widget: NavbarRouting());
                                },
                              ),
                              SizedBox(
                                width: 40.0,
                              )
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RawMaterialButton(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  width: 450.0,
                                  child: Text(
                                    'NEXT',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                elevation: 0.0,
                                fillColor: Color(0xff014965),
                                hoverColor: Color(0xff013245),
                                onPressed: () async {
                                  _verifyOtp();
                                  //_verifyPhone();
                                },
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Color(0xff006793),
                                  size: 35.0,
                                ),
                                color: Colors.white,
                                minWidth: 70.0,
                                height: 70.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(70.0)),
                                onPressed: () {
                                  locator<NavigationService>()
                                      .navigateTo(LoginRoute);
                                  // Provider.of<Routing>(context,
                                  //         listen: false)
                                  //     .updateRouting(widget: LogIn());
                                  // Provider.of<MenuBar>(context,
                                  //         listen: false)
                                  //     .updateMenu(
                                  //         widget: NavbarRouting());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 15.0),
                width: 600,
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
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: _clickHere,
                        child: Text(
                          'click here',
                          style: TextStyle(
                              color: Colors.cyanAccent, fontSize: 18.0),
                        ),
                      ),
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
    );
  }

  // ignore: non_constant_identifier_names
  Container MobileOtp(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      // decoration: BoxDecoration(
      //   color: Color(0xff006793),
      // ),
      decoration: BoxDecoration(
        color: Color(0xff006793),
        image: DecorationImage(
          image: AssetImage('images/login_bg3.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back',
            style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55.0,
                      // width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: OTPTextField(
                        length: 6,
                        width: MediaQuery.of(context).size.width - 50,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 30,
                        fieldStyle: FieldStyle.underline,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          print(value);
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onCompleted: (value) {
                          _otp.text = value;
                        },
                      ),
                    ),
                  ],
                  // children: otpCount(6),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Countdown(
                      seconds: 600,
                      build: (BuildContext context, double time) => Text(
                        '${(time ~/ 60).toString().length == 1 ? "0" + (time ~/ 60).toString() : (time ~/ 60)} : ${(time % 60).toString().length == 1 ? "0" + (time % 60).toString() : (time % 60)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23.0,
                        ),
                      ),
                      onFinished: () {
                        // Provider.of<Routing>(context,
                        //         listen: false)
                        //     .updateRouting(widget: LogIn());
                        // Provider.of<MenuBar>(context,
                        //         listen: false)
                        //     .updateMenu(
                        //         widget: NavbarRouting());
                      },
                    ),
                    SizedBox(
                      width: 40.0,
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0)),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        width: MediaQuery.of(context).size.width - 50,
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xff014965),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      elevation: 1,
                      hoverElevation: 0,
                      hoverColor: Colors.grey[200],
                      fillColor: Colors.white,
                      onPressed: () async {
                        _verifyOtp();
                        //_verifyPhone();
                      },
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      child: Icon(
                        Icons.chevron_left,
                        color: Color(0xff006793),
                        size: 35.0,
                      ),
                      color: Colors.white,
                      minWidth: 70.0,
                      height: 70.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(LoginRoute);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
