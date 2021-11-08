import 'package:bedrock_flutter/src/auth/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_controller.dart';

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({Key? key}) : super(key: key);

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _tosStatus = false;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _password;

  void _submit() async {
    final controller = Provider.of<AuthController>(context, listen: false);
    // if (_formKey.currentState!.validate() && _tosStatus) {
    final user = User(
      email: 'tiago@rekall.ai',
      password: '_password_password_password',
      firstName: '_firstName',
      lastName: '_lastName',
    );
    controller.register(user);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'First Name',
            ),
            validator: (value) {
              if (value!.isEmpty) return 'First Name cannot be empty';
            },
            onChanged: (value) => _firstName = value,
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Last Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Last Name cannot be empty';
              }
            },
            onChanged: (value) => _lastName = value,
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 5),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (value) {
              if (value!.length < 12) {
                return 'Password must be at least 6 characters';
              }

              if (value.isEmpty) {
                return 'Password cannot be empty';
              }
            },
            onChanged: (value) => _password = value,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: _tosStatus,
                onChanged: (status) {
                  setState(() => _tosStatus = status ?? _tosStatus);
                },
              ),
              const Text('I accept the Terms of Service'),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _submit(),
            child: const Text('Signup'),
          ),
        ],
      ),
    );
  }
}
