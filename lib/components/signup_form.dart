import 'package:estate2/components/app_button.dart';
import 'package:estate2/components/app_input.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/helper.dart';
import 'package:estate2/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final phone = TextEditingController();
  final focusNodeEmail = FocusNode();
  final focusNodePhone = FocusNode();
  final focusNodePassword = FocusNode();
  final focusNodeUser = FocusNode();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    username.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    focusNodeUser.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    Helper helper = Helper();
    final bloc = context.read<AuthBloc>();
    return Column(
      children: [
        Form(
          key: _formkey,
          child: Column(
            children: [
              AppInput(
                  myController: username,
                  focusNode: focusNodeUser,
                  onFiledSubmitedValue: (value) {
                    print(value);
                  },
                  keyBoardType: TextInputType.text,
                  obscureText: false,
                  isFilled: true,
                  hinit: "Enter fullname",
                  leftIcon: true,
                  icon: const Icon(Icons.man),
                  onValidator: (value) {
                    if (value.isEmpty)
                      return 'Enter fullname';
                    else if (value.length < 3) return "Full name at least 3 characters";
                    bloc.userModel.name = value;
                    return null;
                  }),
              Gap(isWidth: false, isHeight: true, height: height * 0.019),
              AppInput(
                  myController: email,
                  focusNode: focusNodeEmail,
                  onFiledSubmitedValue: (value) {
                    print(value);
                  },
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  isFilled: true,
                  hinit: "Enter Email",
                  leftIcon: true,
                  icon: const Icon(Icons.email),
                  onValidator: (value) {
                    if (value.isEmpty)
                      return 'Enter email';
                    else if (!helper.emailValid(value)) return "Enter invalid email";
                    bloc.userModel.email = value;
                    return null;
                  }),
              Gap(isWidth: false, isHeight: true, height: height * 0.019),
              AppInput(
                  myController: phone,
                  focusNode: focusNodePhone,
                  onFiledSubmitedValue: (value) {
                    print(value);
                  },
                  keyBoardType: TextInputType.phone,
                  obscureText: true,
                  hinit: "Enter Phone Number",
                  leftIcon: true,
                  icon: const Icon(Icons.lock),
                  isFilled: true,
                  onValidator: (value) {
                    if (value.isEmpty)
                      return 'Enter Phone Number';
                    else if (value.length < 10) return "Phone Number at least 10 numbers ";
                    return null;
                  }),
              Gap(isWidth: false, isHeight: true, height: height * 0.019),
              AppInput(
                  myController: password,
                  focusNode: focusNodePassword,
                  onFiledSubmitedValue: (value) {
                    print(value);
                  },
                  keyBoardType: TextInputType.text,
                  obscureText: true,
                  hinit: "Enter Password",
                  leftIcon: true,
                  icon: const Icon(Icons.lock),
                  isFilled: true,
                  onValidator: (value) {
                    if (value.isEmpty)
                      return 'Enter Password';
                    else if (value.length < 4) return "Password at least 6 characters ";
                    bloc.userModel.password = value;
                    return null;
                  }),
            ],
          ),
        ),
        Gap(isWidth: false, isHeight: true, height: height * 0.03),
        AppButton(
          onPress: () {
            if (_formkey.currentState!.validate()) {
              context.read<AuthBloc>().add(RegisterEvent(email: email.text, password: password.text, phone: phone.text, name: username.text));
            }
          },
          title: "Register",
          height: 63,
          textColor: AppColors.whiteColor,
        )
      ],
    );
  }
}
