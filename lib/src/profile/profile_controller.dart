import 'package:bedrock_flutter/src/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../services/bedrock_service.dart';

class ProfileController extends ChangeNotifier {
  final BedrockService apiService;

  ProfileController({required this.apiService});

  Future<User?> get user async {
    Response response = await apiService.get('/users/me');
    return User.fromJson(response.data['data']);
  }

  Future<void> updateUser(User user) async {
    await apiService.patch('/users/me', body: user.updateParams);

    notifyListeners();
  }
}
