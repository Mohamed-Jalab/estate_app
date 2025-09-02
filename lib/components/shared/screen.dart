import 'package:flutter/material.dart';
import 'package:estate2/components/app_button.dart';
import 'package:estate2/components/app_padding.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/route_name.dart';

class Screen extends StatelessWidget {
  final Widget child;
  final bool isBackButton, isActions, isBottomTab;
  const Screen(
      {Key? key,
      this.isActions = false,
      this.isBottomTab = false,
      required this.child,
      required this.isBackButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isBackButton
          ? AppBar(
              elevation: 0,
              actions: isActions
                  ? [
                      AppButton(
                        onPress: () {
                          Navigator.pushNamed(
                              context, RoutesName.userAccountScreen);
                        },
                        title: "Next",
                        width: 100,
                        isMarginLeft: true,
                        bgColor: AppColors.primaryColor,
                        textColor: AppColors.whiteColor,
                      )
                    ]
                  : null,
            )
          : null,
      body: SafeArea(
        child: AppPadding(
            padddingValue: 15, child: SingleChildScrollView(child: child)),
      ),
    );
  }
}
