import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/models/update_user_request.dart';
import '../auth/models/user_model.dart';
import '../profile/profile_controller.dart';

class ProfileView extends StatefulWidget {
  static const String appBarLabel = 'Profile';

  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;

  void _submit() async {
    final controller = Provider.of<ProfileController>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      controller.updateUser(
        UpdateUserRequest(
          firstName: _firstName,
          lastName: _lastName,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfileController>(context);

    return FutureBuilder(
      future: controller.user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const CircularProgressIndicator.adaptive();
            case ConnectionState.done:
              User user = snapshot.data!;
              _firstName = user.firstName ?? '';
              _lastName = user.lastName ?? '';

              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'First Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'First Name cannot be empty';
                                    }
                                  },
                                  initialValue: user.firstName,
                                  onChanged: (value) => _firstName = value,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Last Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Last Name cannot be empty';
                                    }
                                  },
                                  initialValue: user.lastName,
                                  onChanged: (value) => _lastName = value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (user.createdAt != null)
                            Column(
                              children: [
                                const Text('Account created on'),
                                Text(user.createdAt!),
                              ],
                            ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'There was an error making that request. Try again later',
            ),
          );
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}
