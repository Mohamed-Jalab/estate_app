import 'dart:convert';
import 'dart:math';

import 'package:estate2/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/estate_model.dart';
import '../../models/service_model.dart';

part 'estate_event.dart';
part 'estate_state.dart';

class EstateBloc extends Bloc<EstateEvent, EstateState> {
  List<EstateModel> estates = [];
  List<ServiceModel> services = [];
  List<EstateModel> myPending = [];
  num maxPrice = 100000;
  num minPrice = 100;
  num maxArea = 100;
  num minArea = 5;
  List<String> addresses = [];
  List<String> types = [];
  List<String> estateTypes = [];
  EstateBloc() : super(EstateInitial()) {
    on<GetAllEstates>((event, emit) async {
      emit(EstateLoading());
      try {
        print(Constant.token!);
        http.Response res2 = await http.get(
            Uri.parse("${Constant.baseUrl}/service"),
            headers: {"Authorization": Constant.token!});
        if (res2.statusCode == 200) {
          List body = jsonDecode(res2.body)["data"];
          services = [];

          for (final json in body) services.add(ServiceModel.fromJson(json));
        } else {
          throw "";
        }
        http.Response res = await http.get(
            Uri.parse("${Constant.baseUrl}/estate"),
            headers: {"Authorization": Constant.token!});
        print(res.statusCode);
        if (res.statusCode == 200) {
          estates = [];
          myPending = [];
          List body = jsonDecode(res.body)["data"];
          for (final json in body) {
            if (json["status"] != "accepted") {
              if (json["user_Id"] == Constant.user!.id) {
                myPending.add(EstateModel.fromJson(json));
              }
              continue;
            }
            ;
            // maxPrice = max(maxPrice, json["price"]);
            // minPrice = min(minPrice, json["price"]);
            maxArea = max(maxArea, json["area"]);
            minArea = min(minArea, json["area"]);
            if (!addresses.contains(json["address"]) &&
                json["address"] != null) {
              addresses.add(json["address"]);
            }
            if (!types.contains(json["listing_type"]) &&
                json["listing_type"] != null) {
              types.add(json["listing_type"]);
            }
            if (!estateTypes.contains(json["estate_type"]) &&
                json["estate_type"] != null) {
              estateTypes.add(json["estate_type"]);
            }
            print(types);
            estates.add(EstateModel.fromJson(json));
          }
          print(estates.length);
          emit(EstateSuccess());
        } else if (jsonDecode(res.body)["message"] != null) {
          emit(EstateFailure(message: jsonDecode(res.body)["message"]));
        } else if (jsonDecode(res.body)["error"] != null) {
          emit(EstateFailure(message: jsonDecode(res.body)["error"]));
        } else {
          throw "";
        }
      } catch (e) {
        print(e.toString());
        emit(EstateFailure(message: "Unexpected Error"));
      }
    });
    on<GetOneEstate>((event, emit) async {
      emit(EstateOneLoading());
      try {
        print(Constant.token!);
        http.Response res = await http.get(
            Uri.parse("${Constant.baseUrl}/estate/${event.id}"),
            headers: {"Authorization": Constant.token!});
        print(res.statusCode);
        if (res.statusCode == 200) {
          EstateModel estate =
              EstateModel.fromJson(jsonDecode(res.body)["data"]);
          http.Response res2 = await http.get(
              Uri.parse("${Constant.baseUrl}/comment?estate_id=${estate.id}"),
              headers: {"Authorization": Constant.token!});
          if (res.statusCode == 200) {
            for (final comment in jsonDecode(res2.body)["data"]) {
              if (comment["estate_id"] == event.id) {
                if (comment["comment_id"] == null) {
                  estate.comments.add({
                    "id": comment["id"],
                    "comment_id": comment["comment_id"],
                    "user_id": comment["user_id"],
                    "estate_id": comment["estate_id"],
                    "comment": comment["comment"],
                    "user_name": comment["user"]["name"],
                    "email": comment["user"]["email"],
                    "comments": []
                  });
                } else {
                  for (int i = 0; i < estate.comments.length; i++) {
                    if (estate.comments[i]["id"] == comment["comment_id"]) {
                      estate.comments[i]["comments"].add({
                        "id": comment["id"],
                        "comment_id": comment["comment_id"],
                        "user_id": comment["user_id"],
                        "comment": comment["comment"],
                        "user_name": comment["user"]["name"],
                        "email": comment["user"]["email"],
                      });
                      break;
                    }
                  }
                }
              }
            }
            print(estate.comments);
          } else {
            throw "";
          }
          emit(EstateOneSuccess(estate: estate));
        } else {
          throw "";
        }
      } catch (e) {
        print(e.toString());
        emit(EstateOneFailure());
      }
    });
  }
}


// {
//     "id": 4,
//     "comment_id": null,
//     "user_id": 9,
//     "estate_id": 21,
//     "comment": "nice pdffddfdflace",
//     "created_at": "2025-09-06T15:50:45.000000Z",
//     "user": {
//         "id": 9,
//         "name": "Mohammed",
//         "email": "moh123@gmail.com",
//         "photo": null,
//         "location": null,
//         "location_text": null,
//         "is_active": true,
//         "phone": "0954802408"
//     }
// }