import 'package:bedrock_flutter/src/profile/model/user_model.dart';
import 'package:dio/dio.dart';

import '../model/update_user_request.dart';
import '../../network/upload_response_model.dart';
import '../../network/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  const ProfileRepository(this.apiService);

  /// Fetch profile info
  /// GET /users/me

  Future<UserModel> fetchUser() async {
    try {
      Response response = await apiService.get('/users/me');
      return UserModel.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  /// Update profile info
  /// PATCH /users/me
  Future<UserModel> updateUser(UserModel newUser) async {
    try {
      Response response = await apiService.patch(
        '/users/me',
        data: UpdateUserRequest(
          firstName: newUser.firstName,
          lastName: newUser.lastName,
          email: newUser.email,
          phoneNumber: newUser.phoneNumber,
        ).toJson(),
      );
      return UserModel.fromJson(response.data['data']);
    } catch (_) {
      rethrow;
    }
  }

  /// Update profile avatar
  /// POST /uploads
  Future<UserModel> updateAvatar(FormData data) async {
    try {
      Response response = await apiService.post('/uploads', data: data);
      UploadResponseModel upload = UploadResponseModel.fromJson(response.data);
      Response res = await apiService.patch(
        '/users/me',
        data: {'profileImage': upload.images.first.id},
      );
      return UserModel.fromJson(res.data['data']);
    } catch (_) {
      rethrow;
    }
  }
}
