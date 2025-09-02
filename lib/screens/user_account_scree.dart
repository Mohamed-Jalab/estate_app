import 'package:estate2/components/account_form.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/header_title.dart';
import 'package:estate2/components/shared/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../utils/route_name.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Screen(
            isBackButton: true,
            isBottomTab: false,
            child: Column(
              children: [
                const HeaderTitle(
                  title: "Fill your",
                  title1: "information below",
                  bottomTitle:
                      "You can edit this later on your account setting.",
                  subtitle: "",
                  isUnderTitle: true,
                ),
                Gap(
                  isWidth: false,
                  isHeight: true,
                  height: height * 0.03,
                ),
                const AccountForm()
              ],
            ),
          ),
        ),
        BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthFailure) Fluttertoast.showToast(msg: state.message);
          if (state is SignUpSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                RoutesName.authScreen, (route) => false);
          }
        }, builder: (context, state) {
          if (state is SignUpLoading) {
            return Container(
                width: width,
                height: height,
                color: Colors.grey.withOpacity(.3),
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return SizedBox();
        })
      ],
    );
  }
}
