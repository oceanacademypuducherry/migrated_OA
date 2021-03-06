import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login/Login_View/otp.dart';
import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../getx_controller.dart';

class WebinarFooter extends StatelessWidget {
  final valueController = Get.find<ValueListener>();
  // getSession() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
  //   print("thanks for ${LoginResponsive.registerNumber}");
  //   print("thanks for ${OTP.userID}");
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
        // BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     blurRadius: 6,
        //     offset: Offset(0, -3))
      ]),
      child: Row(
        children: [
          Spacer(),
          Container(
            width: 350,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Ocean.oa,
                      size: 40,
                      color: Colors.blue,
                    ),
                    Text(
                      'ocean academy',
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          inherit: false,
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          Spacer(flex: 11),
          Container(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Terms',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text(
                    'Privacy',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.googlePlusG,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      FontAwesomeIcons.linkedinIn,
                      size: 20,
                    ),
                    splashRadius: 20,
                    color: Colors.grey[700],
                    onPressed: () {}),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
