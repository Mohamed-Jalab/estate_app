import 'dart:async';

import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';

class Helper {
  void isOnBoarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final showOnBoarding = prefs.getBool("showOnBoard") ?? false;
    if (Constant.user != null) {
      Timer(const Duration(seconds: 3), (() {
        Navigator.pushNamed(context, RoutesName.authScreen);
        // Navigator.pushNamed(context, RoutesName.homeScreen);

      }));
    } else if (showOnBoarding) {
      Timer(const Duration(seconds: 3), (() {
        Navigator.pushNamed(context, RoutesName.startedScreen);
      }));
    } else {
      Timer(const Duration(seconds: 3), (() {
        Navigator.pushNamed(context, RoutesName.onboardingScreen);
      }));
    }
  }

  void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppColors.textPrimary,
        textColor: AppColors.whiteColor,
        fontSize: 16);
  }

  bool emailValid(String email) {
    final validEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return validEmail;
  }
}
