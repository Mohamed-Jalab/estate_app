import 'dart:convert';

import 'package:estate2/components/gap.dart';
import 'package:estate2/constant/colors.dart';
import 'package:estate2/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/profile_bloc/profile_bloc.dart';
import '../constant/constant.dart';
import '../models/user_model.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({super.key});

  @override
  State<AccountProfileScreen> createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body:
            BlocConsumer<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          Gap(isWidth: false, isHeight: true, height: height * 0.06),
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              children: [
                Center(
                    child: CircleAvatar(
                  radius: 50,
                  child: Image(
                    image: NetworkImage("https://i.pravatar.cc/150?img=3"),
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      final String? imagePath = await pickImage();
                      if (imagePath == null) return;
                      if (context.mounted) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Are you sure to update image profile?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No")),
                                  TextButton(
                                      onPressed: () {
                                        context.read<ProfileBloc>().add(
                                            UpdateProfile(
                                                imagePath: imagePath));
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Yes")),
                                ],
                              );
                            });
                      }
                    },
                    icon: Icon(Icons.edit, size: 20),
                    style: IconButton.styleFrom(
                        elevation: 5,
                        backgroundColor: Colors.white,
                        visualDensity:
                            VisualDensity(horizontal: -1, vertical: -1)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Gap(isWidth: false, isHeight: true, height: height * 0.015),
                Text(
                  Constant.user!.name!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  Constant.user!.email!,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Gap(isWidth: false, isHeight: true, height: height * 0.04),
          _buildTile(
            context,
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesName.editProfile);
            },
          ),
          _buildTile(
            context,
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesName.changePassword);
            },
          ),
          _buildTile(
            context,
            icon: Icons.settings,
            title: "Settings",
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesName.settings);
            },
          ),
          _buildTile(
            context,
            icon: Icons.logout,
            title: "Logout",
            color: Colors.red,
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(RoutesName.logout);
              // Add logout logic here
            },
          ),
        ],
      );
    }, listener: (context, state) {
      if (state is ProfileFailure) Fluttertoast.showToast(msg: state.message);
      if (state is ProfileSuccess) {
        Constant.user = UserModel.fromJson(
            jsonDecode(Constant.preferences!.getString("user_model") ?? "{}"));
        setState(() {});
      }
    }));
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon,
      required String title,
      Color color = AppColors.textPrimary,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: color),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

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
