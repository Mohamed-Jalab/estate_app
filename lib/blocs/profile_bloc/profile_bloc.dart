import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../constant/constant.dart';
import '../../models/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        MultipartRequest request =
            MultipartRequest("POST", Uri.parse("${Constant.baseUrl}/profile"));
        request.headers.addAll({"Authorization": Constant.token!});
        request.fields.addAll({"_method": "PUT"});
        request.files
            .add(await MultipartFile.fromPath("photo", event.imagePath));
        StreamedResponse res = await request.send();
        Map<String, dynamic> body =
            jsonDecode(await res.stream.bytesToString());
        print(res.statusCode);
        print(body);
        if (res.statusCode == 200 || res.statusCode == 201) {
          Constant.user = UserModel.fromJson(body["data"]);
          await Constant.preferences!
              .setString("user_model", jsonEncode(body["data"]));
          emit(ProfileSuccess());
        } else if (body["message"] != null) {
          emit(ProfileFailure(message: body["message"]));
        } else if (body["error"] != null) {
          emit(ProfileFailure(message: body["error"]));
        } else {
          throw "";
        }
      } catch (e) {
        print(e.toString());
        emit(ProfileFailure(message: "Unexpected Error"));
      }
    });
  }
}
