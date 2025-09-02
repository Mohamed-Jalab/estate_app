part of 'estate_bloc.dart';

sealed class EstateState {}

final class EstateInitial extends EstateState {}

class EstateSuccess extends EstateState {}

class EstateLoading extends EstateState {}

class EstateOneSuccess extends EstateState {
  final EstateModel estate;

  EstateOneSuccess({required this.estate});
}

class EstateOneLoading extends EstateState {}

final class EstateOneFailure extends EstateState {}

class EstateFailure extends EstateState {
  final String message;

  EstateFailure({required this.message});
}
