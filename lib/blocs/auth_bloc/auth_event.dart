part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {

  SignUpEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String phone;
  final String name;
  RegisterEvent({required this.email, required this.password, required this.phone, required this.name});
}
