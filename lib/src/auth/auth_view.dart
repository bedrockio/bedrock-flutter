import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_controller.dart';
import '../auth/auth_register_form.dart';
import '../auth/auth_reset_password_form.dart';
import 'auth_login_form.dart';

enum AuthState { login, register, passwordReset }

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthState _authState = AuthState.login;

  String _setTitle() {
    switch (_authState) {
      case AuthState.login:
        return 'Login';
      case AuthState.register:
        return 'Create Your Account';
      case AuthState.passwordReset:
        return 'Password Reset';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(
                _setTitle(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _renderErrorMessages(context),
              _renderAuthView(),
              _renderAuthFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderErrorMessages(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, child) {
        if (controller.apiResponse != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              controller.apiResponse!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _toggleAuthState(AuthState state) => setState(() => _authState = state);

  Widget _renderAuthView() {
    switch (_authState) {
      case AuthState.login:
        return const AuthLoginForm();
      case AuthState.register:
        return const AuthRegisterForm();
      case AuthState.passwordReset:
        return const AuthResetPasswordForm();
    }
  }

  Widget _renderAuthFooter() {
    if (_authState == AuthState.login) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _toggleAuthState(AuthState.register),
            child: const Text('Signup'),
          ),
          TextButton(
            onPressed: () => _toggleAuthState(AuthState.passwordReset),
            child: const Text('Forgot Password'),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account?'),
          TextButton(
            onPressed: () => _toggleAuthState(AuthState.login),
            child: const Text('Login'),
          ),
        ],
      );
    }
  }
}
