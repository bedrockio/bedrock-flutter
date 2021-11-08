import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_controller.dart';
import 'user_model.dart';
import 'package:bedrock_flutter/src/localization/localized_strings.dart';

class AuthLoginForm extends StatefulWidget {
  const AuthLoginForm({Key? key}) : super(key: key);

  @override
  State<AuthLoginForm> createState() => _AuthLoginFormState();
}

class _AuthLoginFormState extends State<AuthLoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _submit() async {
    final controller = Provider.of<AuthController>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (_email.isNotEmpty && _password.isNotEmpty) {
        final user = User(email: _email, password: _password);
        await controller.login(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            validator: _emailValidator,
            decoration: InputDecoration(
              hintText: context.i18n.emailAddress,
            ),
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: context.i18n.password,
            ),
            validator: _passwordValidator,
            onChanged: (value) => _password = value,
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: Text(context.i18n.signIn),
          ),
        ],
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value!.isEmpty || !value.contains('@')) {
      return context.i18n.invalidEmail;
    }
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return context.i18n.emptyPassword;
    }
  }
}
