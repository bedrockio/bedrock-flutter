import '/src/utils/error_helper.dart';
import '/src/profile/model/user_model.dart';
import '/src/profile/cubit/profile_repository.dart';
import '/src/network/api_error.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  UserModel? user;

  ProfileCubit(this.repository) : super(const ProfileState.initial());

  void fetchUser() async {
    emit(const ProfileState.loading());
    try {
      user = await repository.fetchUser();
      emit(ProfileState.loaded(user!));
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }

  void updateUser(UserModel newUser) async {
    emit(const ProfileState.loading());
    try {
      user = await repository.updateUser(newUser);
      emit(ProfileState.loaded(user!));
    } catch (e) {
      user = await repository.fetchUser();
      emit(ProfileState.loaded(user!));
      ErrorHelper.broadcastError(e);
    }
  }

  void updateAvatar(FormData data) async {
    emit(const ProfileState.loading());
    try {
      user = await repository.updateAvatar(data);
      emit(ProfileState.loaded(user!));
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }
}
