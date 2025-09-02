part of 'estate_bloc.dart';

sealed class EstateEvent {}

class GetAllEstates extends EstateEvent {}

class GetOneEstate extends EstateEvent {
  final int id;

  GetOneEstate({required this.id});
}
