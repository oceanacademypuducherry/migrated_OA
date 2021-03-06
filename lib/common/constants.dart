import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const primaryColor = const Color(0xFFECF5FF);

var buttonRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
);
const menuTextStyle = TextStyle(
    fontSize: 22.0,
    color: Color(0xFF6792B1),
    inherit: false,
    fontWeight: FontWeight.normal);
const kcontentcolor = Color(0xFF1C1C1C);
const kfontname = "Mulish";

const contentTextStyle = TextStyle(
  inherit: false,
  fontWeight: FontWeight.w400,
  fontSize: 20,
  fontFamily: kfontname,
  color: kcontentcolor,
);
const otherSmallContentTextStyle = TextStyle(
  fontSize: 18,
  color: kcontentcolor,
  inherit: false,
  fontFamily: 'Mulish',
  // fontWeight: FontWeight.bold,
);
const otherSmallHeaddingTextStyle = TextStyle(
  inherit: false,
  fontWeight: FontWeight.w400,
  fontSize: 20,
  fontFamily: kfontname,
  color: kcontentcolor,
);

const logInButtonPadding = EdgeInsets.all(20.0);
const textColor = Color(0xFF0091D2);
const adminTextColor = Color(0xFF0090E9);
const adminDefaultText = Colors.black;

const pagePadding = EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0);

const aCourseStyle = TextStyle(
    color: Color(0xFF002C47), fontSize: 18, fontWeight: FontWeight.w600);
const aCourseMainStyle = TextStyle(
    color: Color(0xFF0091D2), fontSize: 22, fontWeight: FontWeight.w600);

const ktextediting = TextStyle(
    color: Color(0xFF155575), fontSize: 20.0, fontWeight: FontWeight.bold);
const kbottom = TextStyle(
    color: Colors.white,
    fontSize: 17.0,
    letterSpacing: 1,
    fontWeight: FontWeight.w100,
    fontFamily: kfontname);

const kactiveColour = Color(0xFF155575);
const kinactiveColour = Color(0xFFACACAC);

const kcardtext1 = TextStyle(
    color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20.0);
const kcardtext2 = TextStyle(
  color: Colors.black87,
  fontSize: 20.0,
);
