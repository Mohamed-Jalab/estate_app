import 'package:flutter/material.dart';
import 'package:estate2/components/gap.dart';
import 'package:estate2/components/shared/screen.dart';
import 'package:estate2/constant/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Screen(
      isBackButton: true,
      isBottomTab: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(isWidth: false, isHeight: true, height: height * 0.03),
          Text(
            "Settings",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(isWidth: false, isHeight: true, height: height * 0.02),

          _buildSettingTile(
            icon: Icons.notifications_none,
            title: "Notifications",
            onTap: () {
              // Logic here
            },
          ),
          Gap(isWidth: false, isHeight: true, height: height * 0.015),

          _buildSettingTile(
            icon: Icons.language,
            title: "Language",
            onTap: () {
              // Logic here
            },
          ),
          Gap(isWidth: false, isHeight: true, height: height * 0.015),

          _buildSettingTile(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: () {
              // Logic here
            },
          ),
          Gap(isWidth: false, isHeight: true, height: height * 0.015),

          SwitchListTile(
            title: Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            value: isDarkMode,
            activeColor: AppColors.primaryColor,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
              // ممكن تضيفي logic لتفعيل الثيم
            },
            secondary: Icon(
              Icons.brightness_6_outlined,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}