import 'dart:convert';
import 'dart:math';

import 'package:estate2/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/estate_model.dart';

part 'estate_event.dart';
part 'estate_state.dart';

class EstateBloc extends Bloc<EstateEvent, EstateState> {
  List<EstateModel> estates = [];
  num maxPrice = 2000;
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
        http.Response res = await http.get(
            Uri.parse("${Constant.baseUrl}/estate"),
            headers: {"Authorization": Constant.token!});
        print(res.statusCode);
        if (res.statusCode == 200) {
          estates = [];
          List body = jsonDecode(res.body)["data"];
          for (final json in body) {
            maxPrice = max(maxPrice, json["price"]);
            minPrice = min(minPrice, json["price"]);
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
