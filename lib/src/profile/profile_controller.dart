import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../auth/models/update_user_request.dart';
import '../auth/models/user_model.dart';
import '../services/bedrock_service.dart';

class ProfileController extends ChangeNotifier {
  final BedrockService apiService;

  ProfileController({required this.apiService});

  Future<User?> get user async {
    Response response = await apiService.get('/users/me');
    return User.fromJson(response.data['data']);
  }

  Future<void> updateUser(UpdateUserRequest request) async {
    await apiService.patch('/users/me', body: request.toJson());

    notifyListeners();
  }
}
