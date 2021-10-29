import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_controller.dart';

class AuthResetPasswordForm extends StatefulWidget {
  const AuthResetPasswordForm({Key? key}) : super(key: key);

  @override
  _AuthResetPasswordFormState createState() => _AuthResetPasswordFormState();
}

class _AuthResetPasswordFormState extends State<AuthResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;

  void _submit(BuildContext context) async {
    final controller = Provider.of<AuthController>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      controller.resetPassword(_email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'E-mail Address',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'E-mail Address cannot be empty';
              }
            },
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _submit(context),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
