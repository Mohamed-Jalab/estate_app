import 'package:estate2/constant/colors.dart';
import 'package:estate2/screens/account_empty_screen.dart';
import 'package:estate2/screens/account_location_screen.dart';
import 'package:estate2/screens/account_profile_screen.dart';
import 'package:estate2/screens/agentProfileScreen/agent_profile_screen.dart';
import 'package:estate2/screens/dashboard_screen.dart';
import 'package:estate2/screens/faq_screen.dart';
import 'package:estate2/screens/favourite_screen.dart';
import 'package:estate2/screens/featured/featured_screen.dart';
import 'package:estate2/screens/featuredDetailsScreen/featured_details_screen.dart';
import 'package:estate2/screens/forgot_password_screen.dart';
import 'package:estate2/screens/gallery_grid_view.dart';
import 'package:estate2/screens/home_screen.dart';
import 'package:estate2/screens/login_screen.dart';
import 'package:estate2/screens/onboarding_screen.dart';
import 'package:estate2/screens/otp_screen.dart';
import 'package:estate2/screens/profile/change_password_screen.dart';
import 'package:estate2/screens/profile/edit_profile_screen.dart';
import 'package:estate2/screens/profile/logout_screen.dart';
import 'package:estate2/screens/profile/settings_screen.dart';
import 'package:estate2/screens/promotion/promotion_screen.dart';
import 'package:estate2/screens/search_screen.dart';
import 'package:estate2/screens/signup_screen.dart';
import 'package:estate2/screens/splash_screen.dart';
import 'package:estate2/screens/started_screen.dart';
import 'package:estate2/screens/topAgentScreen/top_agent_screen.dart';
import 'package:estate2/screens/topLocationDetailsScreen/top_location_details_screen.dart';
import 'package:estate2/screens/topLocationScreen/top_location_screen.dart';
import 'package:estate2/screens/user_account_scree.dart';
import 'package:estate2/utils/route_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());
      case RoutesName.startedScreen:
        return MaterialPageRoute(builder: (context) => const StartedScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RoutesName.faqScreen:
        return MaterialPageRoute(builder: (context) => const FaqScreen());
      case RoutesName.galleryGridView:
        return MaterialPageRoute(
            builder: (context) => const GalleryGridScreen());
      case RoutesName.accountEmptyScreen:
        return MaterialPageRoute(
            builder: (context) => const AccountEmptyScreen());
      case RoutesName.accountLocationScreen:
        return MaterialPageRoute(
            builder: (context) => const AccountLocationScreen());
      case RoutesName.otpScreen:
        return MaterialPageRoute(
            builder: (context) => OtpScreen(data: settings.arguments as Map));
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());
      case RoutesName.userAccountScreen:
        return MaterialPageRoute(
            builder: (context) => const UserAccountScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.authScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case RoutesName.searchScreen:
        return MaterialPageRoute(
            builder: (context) => const SearchResultsPage());
      case RoutesName.favoriteScreen:
        return MaterialPageRoute(builder: (context) => const FavoritesScreen());
      case RoutesName.promotionScreen:
        return MaterialPageRoute(
            builder: (context) => const PermissionScreen());
      case RoutesName.featuredScreen:
        return MaterialPageRoute(builder: (context) => const FeaturedScreen());
      case RoutesName.featuredDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const FeaturedDetailsScreen());
      case RoutesName.topLocationScreen:
        return MaterialPageRoute(
            builder: (context) => const TopLocationScreen());
      case RoutesName.topLocationDetailsScreen:
        return MaterialPageRoute(
            builder: (context) => const TopLocationDetails());
      case RoutesName.topAgentScreen:
        return MaterialPageRoute(builder: (context) => const TopAgentScreen());
      case RoutesName.agentProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const AgentProfileScreen());
      case RoutesName.profileScreen:
        return MaterialPageRoute(
            builder: (context) => const AccountProfileScreen());
      case RoutesName.editProfile:
        return MaterialPageRoute(
            builder: (context) => const EditProfileScreen());

      case RoutesName.changePassword:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen());

      case RoutesName.settings:
        return MaterialPageRoute(builder: (context) => const SettingsScreen());

      case RoutesName.logout:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Invalid Route",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
            ),
          );
        });
    }
  }
}
