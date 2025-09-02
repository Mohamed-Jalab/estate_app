import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class Constant {
  static SharedPreferences? preferences;
  static UserModel? user;
  static String? token;
  static String baseUrl = "https://razan-estate.mustafafares.com/api";
  static List favoriteEstates = [];
}
