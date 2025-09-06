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
        // home: Scaffold(
        //     body: Center(
        //         child: CommentCard(
        //   title: "moh123@gmail.com",
        //   comment:
        //       "This estate is awesome and beautiful estate Bla Bla Bla Bla",
        //   // replies: [
        //   //   {
        //   //     "title": "moh@gmail.com",
        //   //     "comment":
        //   //         "This estate is awesome and beautiful moh@gmail.com estate Bla Bla Bla Bla"
        //   //   },
        //   //   {
        //   //     "title": "moh1@gmail.com",
        //   //     "comment":
        //   //         "This estate is awesome and beautiful moh1@gmail.com estate Bla Bla Bla Bla"
        //   //   },
        //   // ],
        // )))
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  const CommentCard(
      {super.key,
      required this.id,
      required this.commentId,
      required this.estateId,
      required this.name,
      required this.email,
      required this.comment,
      this.onAddPressed,
      this.replies = const []});
  final int id;
  final int? commentId;
  final int estateId;
  final String name;
  final String email;
  final String comment;
  final void Function()? onAddPressed;
  final List<dynamic> replies;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: [
                CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1332100919/vector/man-icon-black-icon-person-symbol.jpg?s=612x612&w=0&k=20&c=AVVJkvxQQCuBhawHrUhDRTCeNQ3Jgt0K1tXjJsFy1eg="),
                    radius: 20),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18)),
                        Text(email,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        SizedBox(height: 10),
                        Text(comment, style: TextStyle(fontSize: 16)),
                      ]),
                ),
              ]),
              TextButton(child: Text("add comment"), onPressed: onAddPressed),
              if (replies.isNotEmpty)
                ...replies.map((reply) => Card(
                      color: Color(0xFFEEEEEE),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: MediaQuery.sizeOf(context).width),
                            Text(reply["user_name"] ?? "NULL",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            Text(reply["email"] ?? "NULL",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            SizedBox(height: 10),
                            Text(reply["comment"] ?? "NULL",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ))
            ],
          ),
        ));
  }
}
