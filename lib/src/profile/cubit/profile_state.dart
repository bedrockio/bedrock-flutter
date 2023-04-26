part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  const ProfileLoaded(this.user);
}

class ProfileContactSubmitted extends ProfileState {}

class ProfileError extends ProfileState {
  final ApiError? error;
  const ProfileError({this.error});
}
