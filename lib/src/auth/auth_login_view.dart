import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'auth_controller.dart';

class AuthLoginView extends StatefulWidget {
  AuthLoginView({Key? key}) : super(key: key);

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _apiResponse;
  late String _email;
  late String _password;

  void _submit(BuildContext context) async {
    final controller = Provider.of<AuthController>(context, listen: false);
    if (_email.isNotEmpty && _password.isNotEmpty) {
      controller.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Invalid email';
                }
              },
              decoration: const InputDecoration(
                hintText: 'E-mail Address',
              ),
              onChanged: (value) => _email = value,
            ),
            const SizedBox(height: 5),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) => _password = value,
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
