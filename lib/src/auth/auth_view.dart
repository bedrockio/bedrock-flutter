import 'package:bedrock_flutter/src/auth/auth_register_view.dart';
import 'package:flutter/material.dart';

import 'auth_login_view.dart';

enum AuthState { login, register }

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthState _authState = AuthState.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Text(
                _authState == AuthState.register
                    ? 'Create Your Account'
                    : 'Login',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _renderAuthView(),
              _renderAuthFooter(),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleAuthState() {
    setState(() {
      _authState = (_authState == AuthState.login)
          ? AuthState.register
          : AuthState.login;
    });
  }

  Widget _renderAuthView() {
    return (_authState == AuthState.login)
        ? AuthLoginView()
        : AuthRegisterView();
  }

  Widget _renderAuthFooter() {
    if (_authState == AuthState.login) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _toggleAuthState,
            child: const Text('Signup'),
          ),
          TextButton(
            onPressed: () {},
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
            onPressed: _toggleAuthState,
            child: const Text('Login'),
          ),
        ],
      );
    }
  }
}
