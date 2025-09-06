import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../constant/constant.dart';
import '../../models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserModel userModel = UserModel();
  String? imagePath;
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        print("start");
        MultipartRequest request =
            MultipartRequest("POST", Uri.parse("${Constant.baseUrl}/register"));
        request.headers.addAll({
          "Authorization":
              "Bearer 4|AcOAJOIrumJe87N1Z2bmtj56anbBhEJrOehAxlCpf7419185"
        });
        print(userModel.toJson());
        request.fields.addAll(userModel.toJson());
        request.files.add(await MultipartFile.fromPath("photo", imagePath!));
        StreamedResponse res = await request.send();
        print("end");
        print(res.statusCode);
        Map<String, dynamic> body =
            jsonDecode(await res.stream.bytesToString());
        if (res.statusCode == 200 || res.statusCode == 201) {
          Constant.user = UserModel.fromJson(body["data"]["user"]);
          Constant.token = "Bearer ${body["data"]["token"]}";
          await Constant.preferences!
              .setString("user_model", jsonEncode(body["data"]["user"]));
          await Constant.preferences!.setString("token", body["data"]["token"]);
          emit(SignUpSuccess());
        } else if (body["message"] != null) {
          emit(AuthFailure(message: body["message"]));
        } else {
          throw res.statusCode;
        }
      } catch (e) {
        print(e.toString());
        emit(AuthFailure(message: "Unexpected Error"));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      Response res = await post(Uri.parse("${Constant.baseUrl}/login"),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 4|AcOAJOIrumJe87N1Z2bmtj56anbBhEJrOehAxlCpf7419185"
          },
          body: jsonEncode({"email": event.email, "password": event.password}));
      print(res.statusCode);
      if (res.statusCode == 302) {
        emit(AuthFailure(message: "Unknown Server Error"));
      }
      Map<String, dynamic> body = jsonDecode(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(body["data"]["user"]);
        print(body["data"]);
        print(body);
        Constant.user = UserModel.fromJson(body["data"]["user"]);
        Constant.token = "Bearer ${body["data"]["token"]}";
        await Constant.preferences!
            .setString("user_model", jsonEncode(body["data"]["user"]));
        await Constant.preferences!
            .setString("token", "Bearer ${body["data"]["token"]}");
        emit(LoginSuccess());
      } else if (body["message"] != null) {
        emit(AuthFailure(message: body["message"]));
      } else if (body["error"] != null) {
        emit(AuthFailure(message: body["error"]));
      } else {
        emit(AuthFailure(message: "Unknown Error"));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(SignUpLoading());
      Response res = await post(Uri.parse("${Constant.baseUrl}/register"),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer 4|AcOAJOIrumJe87N1Z2bmtj56anbBhEJrOehAxlCpf7419185"
          },
          body: jsonEncode({
            "email": event.email,
            "password": event.password,
            "phone": event.phone,
            "name": event.name,
          }));
      print(res.statusCode);
      Map<String, dynamic> body = jsonDecode(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        print(body["data"]["user"]);
        print(body["data"]);
        print(body);
        Constant.user = UserModel.fromJson(body["data"]["user"]);
        Constant.token = "Bearer ${body["data"]["token"]}";
        await Constant.preferences!
            .setString("user_model", jsonEncode(body["data"]["user"]));
        await Constant.preferences!
            .setString("token", "Bearer ${body["data"]["token"]}");
        emit(SignUpSuccess());
      } else if (body["message"] != null) {
        emit(AuthFailure(message: body["message"]));
      } else if (body["error"] != null) {
        emit(AuthFailure(message: body["error"]));
      } else {
        throw res.statusCode;
      }
    });
  }
}
