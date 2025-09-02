import 'dart:core';
import 'dart:io';

import 'package:estate2/components/app_input.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import 'app_button.dart';

class AccountForm extends StatefulWidget {
  const AccountForm({super.key});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formkey = GlobalKey<FormState>();
  final phoneNumber = TextEditingController();
  final focusNodePhone = FocusNode();

  Future<String?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return image.path;
    } catch (e) {
      print('Upload failed $e');
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumber.dispose();
    focusNodePhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.sizeOf(context).width;
    final bloc = context.read<AuthBloc>();
    Helper helper = Helper();
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: bloc.imagePath == null
                    ? AssetImage("lib/assets/logo.png")
                    : FileImage(File(bloc.imagePath!)),
              ),
              Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () async {
                      String? imagePath = await pickImage();
                      if (imagePath != null) {
                        bloc.imagePath = imagePath;
                        setState(() {});
                      }
                    },
                    elevation: 2.0,
                    fillColor: AppColors.inputBackground,
                    // ignore: sort_child_properties_last
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.textFieldFocusBorderColor,
                      size: 15,
                    ),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  )),
            ],
          ),
        ),
        Gap(isWidth: false, isHeight: true, height: height * 0.02),
        Form(
          key: _formkey,
          child: Column(
            children: [
              AppInput(
                  myController: phoneNumber,
                  focusNode: focusNodePhone,
                  onFiledSubmitedValue: (value) {
                    bloc.userModel.phone = value;
                    print(value);
                  },
                  keyBoardType: TextInputType.phone,
                  obscureText: false,
                  hinit: "Enter Phone Number",
                  leftIcon: true,
                  icon: const Icon(Icons.phone),
                  isFilled: true,
                  onValidator: (value) {
                    if (value.isEmpty) return 'Enter Phone number';
                    bloc.userModel.phone = value;
                    return null;
                  }),
            ],
          ),
        ),
        Gap(isWidth: false, isHeight: true, height: height * 0.30),
        AppButton(
            title: "Next",
            height: height * 0.06,
            textColor: AppColors.whiteColor,
            onPress: () {
              if (_formkey.currentState!.validate()) {
                if (bloc.imagePath == null) {
                  Fluttertoast.showToast(msg: "must select image");
                } else {
                  bloc.add(SignUpEvent());
                }
              }
            })
      ],
    );
  }
}
