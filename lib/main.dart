import 'dart:convert';

import 'package:estate2/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/estate_bloc/estate_bloc.dart';
import 'blocs/profile_bloc/profile_bloc.dart';
import 'models/user_model.dart';
import 'theme/theme.dart';
import 'utils/route_name.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constant.preferences = await SharedPreferences.getInstance();
  if (Constant.preferences!.getString("user_model") != null) {
    print(Constant.preferences!.getString("user_model"));
    Constant.user = UserModel.fromJson(
        jsonDecode(Constant.preferences!.getString("user_model")!));
    Constant.token = Constant.preferences!.getString("token");
    print(Constant.token);
  }
  Constant.favoriteEstates =
      jsonDecode(Constant.preferences!.getString("favorites") ?? "[]");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) {
          if (Constant.token == null) return EstateBloc();
          return EstateBloc()..add(GetAllEstates());
        }),
        BlocProvider(create: (context) => ProfileBloc())
      ],
      child: MaterialApp(
        title: "Estate App",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
