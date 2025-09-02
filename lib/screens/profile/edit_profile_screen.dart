import 'package:flutter/material.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/shared/screen.dart';
import 'package:estate2/constant/colors.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Screen(
      isBackButton: true,
      isBottomTab: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(isWidth: false, isHeight: true, height: height * 0.02),
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.03),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 16,
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.04),
              _buildTextField(label: "Full Name"),
              Gap(isWidth: false, isHeight: true, height: height * 0.025),
              _buildTextField(label: "Email Address"),
              Gap(isWidth: false, isHeight: true, height: height * 0.025),
              _buildTextField(label: "Phone Number"),
              Gap(isWidth: false, isHeight: true, height: height * 0.04),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.3,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Save action
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Gap(isWidth: false, isHeight: true, height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),
    SizedBox(height: 8),
    TextFormField(
    decoration: InputDecoration(
    filled: true,
    fillColor: AppColors.bgLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
    ),
      ],
    );
  }
}