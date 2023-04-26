import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bedrock_flutter/src/profile/model/user_model.dart';
import 'package:bedrock_flutter/src/profile/profile_repository.dart';
import 'package:bedrock_flutter/src/network/api_error.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  UserModel user = UserModel();

  ProfileCubit(this.repository) : super(ProfileInitial());

  void fetchUser() async {
    emit(ProfileLoading());
    try {
      user = await repository.fetchUser();
      emit(ProfileLoaded(user));
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }

  void updateUser(UserModel newUser) async {
    emit(ProfileLoading());
    try {
      user = await repository.updateUser(newUser);
      emit(ProfileLoaded(user));
    } catch (e) {
      user = await repository.fetchUser();
      emit(ProfileLoaded(user));
      ErrorHelper.broadcastError(e);
    }
  }

  void updateAvatar(FormData data) async {
    emit(ProfileLoading());
    try {
      user = await repository.updateAvatar(data);
      emit(ProfileLoaded(user));
    } catch (e) {
      ErrorHelper.broadcastError(e);
    }
  }
}
