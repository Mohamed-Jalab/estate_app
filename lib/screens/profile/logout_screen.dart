import 'package:estate2/constant/colors.dart';
import 'package:estate2/constant/constant.dart';
import 'package:estate2/utils/route_name.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: AppColors.textPrimary)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: width),
          Icon(Icons.logout, size: 80, color: Colors.redAccent),
          const SizedBox(height: 20),
          Text(
            // "هل أنت متأكد أنك تريد تسجيل الخروج؟",
            "Are you sure that you want to logout?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            // "سيتم إعادتك إلى صفحة تسجيل الدخول.",
            "you will return to login screen",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await Constant.preferences?.remove("user_model");
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutesName.loginScreen, (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
                // "تسجيل الخروج",
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
                // "إلغاء"
                "Cancel",
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
