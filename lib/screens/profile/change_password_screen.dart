import 'package:flutter/material.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/shared/screen.dart';
import 'package:estate2/constant/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Screen(
        isBackButton: true,
        isBottomTab: false,
        child: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Gap(isWidth: false, isHeight: true, height: height * 0.02),
    const Text(
    "Change Your Password",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    ),
    ),
    Gap(isWidth: false, isHeight: true, height: height * 0.008),
    const Text(
    "Make sure your new password is strong.",
    style: TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    ),
    ),
    Gap(isWidth: false, isHeight: true, height: height * 0.03),

    _buildPasswordField(
    label: "Current Password",
    controller: currentPasswordController,
    obscureText: _obscureCurrent,
    onToggleVisibility: () {
    setState(() {
    _obscureCurrent = !_obscureCurrent;
    });
    },
    ),
    Gap(isWidth: false, isHeight: true, height: height * 0.02),

    _buildPasswordField(
    label: "New Password",
    controller: newPasswordController,
    obscureText: _obscureNew,
    onToggleVisibility: () {
    setState(() {
    _obscureNew = !_obscureNew;
    });
    },
    ),
    Gap(isWidth: false, isHeight: true, height: height * 0.02),

    _buildPasswordField(
    label: "Confirm New Password",
    controller: confirmPasswordController,
    obscureText: _obscureConfirm,
    onToggleVisibility: () {
    setState(() {
    _obscureConfirm = !_obscureConfirm;
    });
    },
    ),
    Gap(isWidth: false, isHeight: true, height: height * 0.04),

    SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // تنفيذ تغيير كلمة المرور
        }
      },
      child: const Text(
        "Update Password",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
    ),
      Gap(isWidth: false, isHeight: true, height: height * 0.03),
    ],
    ),
    ),
        ),
        ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 14),
      validator: (value) {
        if (value == null || value.isEmpty) return "Required field";
        if (label == "Confirm New Password" &&
            value != newPasswordController.text) {
          return "Passwords do not match";
        }
        if (label == "New Password" && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
          ),
          onPressed: onToggleVisibility,
        ),
        filled: true,
        fillColor: AppColors.bgLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }
}