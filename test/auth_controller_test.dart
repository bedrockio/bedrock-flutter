import 'package:bedrock_flutter/src/auth/auth_controller.dart';
import 'package:bedrock_flutter/src/auth/auth_storage.dart';
import 'package:bedrock_flutter/src/auth/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mockito/mockito.dart';

/// Mock AuthController to simulate Bedrock API behavior by generating JWT tokens
/// and implementing authentication methods through [IAuth]
class MockAuthController extends Mock implements IAuth {
  final IAuthTokenStorage storage;

  MockAuthController({required this.storage});

  Future<bool> get authenticated async {
    String? token = await storage.readAuthToken();
    if (token != null) {
      try {
        return !JwtDecoder.isExpired(token);
      } on FormatException {
        return false;
      }
    } else {
      return false;
    }
  }

  // Mock JWT generation using the same configuration that Bedrock API uses
  String generateJWT() {
    dynamic sub, userId = '1';
    var jti = '1234';

    final jwt = JWT(
      {'type': 'user', 'kid': 'user'},
      subject: sub,
      jwtId: jti,
      audience: Audience.one(userId),
    );
    final secret = SecretKey('secretKey');

    return jwt.sign(secret, expiresIn: const Duration(days: 30));
  }

  @override
  Future<void> login(User user) async {
    String token = generateJWT();
    if (!JwtDecoder.isExpired(token)) {
      await storage.storeAuthToken(token);
    }
  }

  @override
  Future<void> logout() async => await storage.deleteAuthToken();

  @override
  Future<void> register(User user) async {
    String token = generateJWT();
    if (!JwtDecoder.isExpired(token)) {
      await storage.storeAuthToken(token);
    }
  }
}

/// Implement [IAuthTokenStorage] for mocking JWT storage mechanism to use
/// in-memory variable storage since flutter_secure_storage can't be used inside
/// a unit test
class MockAuthStorage implements IAuthTokenStorage {
  String? _token = '';

  @override
  Future<String?> readAuthToken() {
    return Future.delayed(const Duration(seconds: 1), () => _token);
  }

  @override
  Future<void> storeAuthToken(String token) {
    return Future.delayed(const Duration(seconds: 1), () => _token = token);
  }

  @override
  Future<void> deleteAuthToken() {
    return Future.delayed(const Duration(seconds: 1), () => _token = '');
  }
}

void main() {
  group('Authentication', () {
    MockAuthController authController = MockAuthController(
      storage: MockAuthStorage(),
    );

    test('Initial authentication state', () async {
      bool state = await authController.authenticated;
      expect(state, false);
    });

    test('Logging in', () async {
      final user = User(email: "example@bedrock.io", password: "123456");
      await authController.login(user);
      bool authenticated = await authController.authenticated;
      expect(authenticated, true);
    });

    test('Logout', () async {
      await authController.logout();
      bool authenticated = await authController.authenticated;
      expect(authenticated, false);
    });

    test('Register', () async {
      final user = User(
        email: "example@bedrock.io",
        password: "123456",
        firstName: "John",
        lastName: "Doe",
      );
      await authController.register(user);
      bool authenticated = await authController.authenticated;
      expect(authenticated, true);
    });
  });
}
