import 'package:flutter/material.dart';
import 'package:estate2/components/app_padding.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/header_title.dart';
import 'package:estate2/components/signup_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../utils/route_name.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AppPadding(
                padddingValue: 15,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(isWidth: false, isHeight: true, height: height * 0.01),
                      const HeaderTitle(
                        title: "Create your ",
                        bottomTitle:
                            "quis nostrud exercitation ullamco laboris nisi ut.",
                        subtitle: "account"
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.04),
                      SignupForm()
                    ],
                  ),
                )),
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthFailure) {
                Fluttertoast.showToast(msg: state.message);
              }
              if (state is SignUpSuccess) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutesName.authScreen, (route) => false);
              }
            }, builder: (context, state) {
              if (state is SignUpLoading) {
                return Container(
                    width: double.infinity,
                    height: height,
                    color: Colors.grey.withOpacity(.3),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
              return SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
