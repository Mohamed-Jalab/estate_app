part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String imagePath;

  UpdateProfile({required this.imagePath});
}
