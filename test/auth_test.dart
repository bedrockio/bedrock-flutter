import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:bedrock_flutter/src/auth/auth_repository.dart';
import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/auth/model/login_response_model.dart';
import 'package:bedrock_flutter/src/auth/model/registration_request.dart';
import 'package:bedrock_flutter/src/auth/model/registration_response.dart';
import 'package:bedrock_flutter/src/network/api_error.dart';
import 'package:bedrock_flutter/src/profile/model/user_model.dart';
import 'package:bedrock_flutter/src/utils/auth_storage.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mocks/mock_assets.dart';
import 'mocks/mock_auth_storage.dart';
import 'auth_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<AuthRepository>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthRepository repository;
  late AuthCubit authBloc;

  late AuthStorage authStorage;
  const String phoneNumber = '+15555555555';
  const String otp = '12345';
  const String token = '__sample_token';

  RegistrationRequestModel registrationRequestModel = RegistrationRequestModel(
      firstName: 'Test', lastName: 'Person', dateOfBirth: '10-20-1992', phoneNo: '+15551234567');
  ErrorHelper.errorStream = StreamController<ApiError>.broadcast();

  const MethodChannel('dev.fluttercommunity.plus/package_info').setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{
        'appName': 'Bedrock Flutter',
        'packageName': 'io.bedrock.flutter',
        'version': '0.0.1',
        'buildNumber': '1-test'
      };
    }
    return null;
  });

  setUp(() {
    authStorage = MockAuthStorage();
    repository = MockAuthRepository();

    SharedPreferences.setMockInitialValues({});

    authBloc = AuthCubit(repository, authStorage, ErrorHelper.errorStream);
  });

  group('Authentication', () {
    blocTest<AuthCubit, AuthState>('User log in (Phone number, success)',
        setUp: () {
          when(repository.login(phoneNumber)).thenAnswer((realInvocation) => Future.value(true));
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.requestVerificationCode(phoneNumber),
        expect: () => [const TypeMatcher<LoginLoading>(), const TypeMatcher<LoginRequestSuccess>()]);

    blocTest<AuthCubit, AuthState>('User log in (Phone number, failure)',
        setUp: () async {
          loadStub('auth_failure').then((value) {
            when(repository.login(phoneNumber)).thenAnswer((realInvocation) => throw ApiError.fromJson(value['error']));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.requestVerificationCode(phoneNumber),
        expect: () => [
              const TypeMatcher<LoginLoading>(),
              const TypeMatcher<LoginError>().having((p0) {
                return p0.error?.message;
              }, 'error.message', 'Incorrect password')
            ]);

    blocTest<AuthCubit, AuthState>('User log in (Correct code)',
        setUp: () async {
          loadStub('auth_success').then((value) {
            LoginResponseModel response =
                LoginResponseModel(value['data']['token'], UserModel.fromJson(value['data']['user']));
            when(repository.loginVerify(phoneNumber, otp)).thenAnswer((realInvocation) => Future.value(response));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performLogin(phoneNumber, otp),
        expect: () {
          authStorage.readAuthToken().then((value) {
            assert(value == '__sample_token');
          });

          return [
            const TypeMatcher<LoginLoading>(),
            const TypeMatcher<LoginSuccess>().having((p0) => p0.token, 'token', token)
          ];
        });

    blocTest<AuthCubit, AuthState>('User log in (Incorrect code)',
        setUp: () async {
          loadStub('auth_failure').then((value) {
            when(repository.loginVerify('incorrect@email.com', 'wrong_code'))
                .thenAnswer((realInvocation) => throw ApiError.fromJson(value['error']));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performLogin('incorrect@email.com', 'wrong_code'),
        expect: () => [
              const TypeMatcher<LoginLoading>(),
              const TypeMatcher<LoginError>().having((p0) {
                return p0.error?.message;
              }, 'error.message', 'Incorrect password')
            ]);

    blocTest<AuthCubit, AuthState>('User token invalid',
        setUp: () async {
          loadStub('auth_failure').then((value) {
            when(repository.loginVerify('incorrect@email.com', 'bogus_data'))
                .thenAnswer((realInvocation) => throw ApiError.fromJson(value['error']));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performLogin('incorrect@email.com', 'bogus_data'),
        expect: () => [
              const TypeMatcher<LoginLoading>(),
              const TypeMatcher<LoginError>().having((p0) {
                return p0.error?.message;
              }, 'error.message', 'Incorrect password')
            ]);

    blocTest<AuthCubit, AuthState>('User logout',
        setUp: () {
          when(repository.logout()).thenAnswer((realInvocation) => Future.value());
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performLogout(),
        expect: () {
          return [const TypeMatcher<LoginLoading>(), const TypeMatcher<LoggedOut>()];
        });
  });

  group('Registration', () {
    blocTest<AuthCubit, AuthState>('User account registration (Success)',
        setUp: () async {
          loadStub('auth_success').then((value) {
            when(repository.register(
                    lastName: registrationRequestModel.lastName,
                    firstName: registrationRequestModel.firstName,
                    dateOfBirth: registrationRequestModel.dateOfBirth,
                    phoneNo: registrationRequestModel.phoneNo))
                .thenAnswer(
              (realInvocation) => Future.value(
                RegistrationResponseModel.fromJson(value['data']),
              ),
            );
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.registerUser(
            firstName: 'Test', lastName: 'Person', dateOfBirth: '10-20-1992', phoneNumber: '+15551234567'),
        expect: () => [const TypeMatcher<RegistrationLoading>(), const TypeMatcher<RegistrationSuccess>()]);
    blocTest<AuthCubit, AuthState>('User account registration (Failure, duplicate phone number)',
        setUp: () async {
          loadStub('auth_failure').then((value) {
            when(repository.register(
                    lastName: registrationRequestModel.lastName,
                    firstName: registrationRequestModel.firstName,
                    dateOfBirth: registrationRequestModel.dateOfBirth,
                    phoneNo: registrationRequestModel.phoneNo))
                .thenAnswer(
              (realInvocation) => throw ApiError.fromJson(value['error']),
            );
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.registerUser(
            firstName: 'Test', lastName: 'Person', dateOfBirth: '10-20-1992', phoneNumber: '+15551234567'),
        expect: () => [
              const TypeMatcher<RegistrationLoading>(),
              const TypeMatcher<RegistrationError>().having((p0) {
                return p0.error?.message;
              }, 'error.message', 'Incorrect password')
            ]);

    blocTest<AuthCubit, AuthState>('User account registration (Correct code)',
        setUp: () async {
          loadStub('auth_success').then((value) {
            LoginResponseModel response =
                LoginResponseModel(value['data']['token'], UserModel.fromJson(value['data']['user']));
            when(repository.loginVerify(phoneNumber, otp)).thenAnswer((realInvocation) => Future.value(response));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performRegistrationLogin(phoneNumber, otp),
        expect: () {
          return [
            const TypeMatcher<LoginLoading>(),
            const TypeMatcher<RegistrationOTPSuccess>().having((p0) => p0.token, 'token', token)
          ];
        });

    blocTest<AuthCubit, AuthState>('User account registration (Incorrect code)',
        setUp: () async {
          loadStub('auth_failure').then((value) {
            when(repository.loginVerify(phoneNumber, otp))
                .thenAnswer((realInvocation) => throw ApiError.fromJson(value['error']));
          });
        },
        build: () => authBloc,
        wait: const Duration(seconds: 1),
        act: (bloc) => bloc.performRegistrationLogin(phoneNumber, otp),
        expect: () => [
              const TypeMatcher<LoginLoading>(),
              const TypeMatcher<LoginError>().having((p0) {
                return p0.error?.message;
              }, 'message', 'Incorrect password')
            ]);
  });
}