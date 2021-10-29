import 'package:bedrock_flutter/src/auth/auth_controller.dart';
import 'package:bedrock_flutter/src/auth/auth_storage.dart';
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
  Future<void> login(String email, String password) async {
    String token = generateJWT();
    if (!JwtDecoder.isExpired(token)) {
      await storage.storeAuthToken(token);
    }
  }

  @override
  Future<void> logout() async => await storage.storeAuthToken('');

  @override
  Future<void> register(
    String email,
    String firstName,
    String lastName,
    String password,
  ) async {
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
  String _token = '';

  @override
  Future<String?> readAuthToken() {
    return Future.delayed(const Duration(seconds: 1), () => _token);
  }

  @override
  Future<void> storeAuthToken(String token) {
    return Future.delayed(const Duration(seconds: 1), () => _token = token);
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
      await authController.login("example@bedrock.io", "123456");
      bool authenticated = await authController.authenticated;
      expect(authenticated, true);
    });

    test('Logout', () async {
      await authController.logout();
      bool authenticated = await authController.authenticated;
      expect(authenticated, false);
    });

    test('Register', () async {
      await authController.register(
        "example@bedrock.io",
        "John",
        "Doe",
        "123456",
      );
      bool authenticated = await authController.authenticated;
      expect(authenticated, true);
    });
  });
}
