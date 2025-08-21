import '/src/utils/widgets/button.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/profile/cubit/profile_cubit.dart';
import '/src/utils/constants/padding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          return state.maybeWhen(
            loaded: (user) {
              return Padding(
                  padding: const EdgeInsets.all(BRPadding.small),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text('Logged in as:', style: Theme.of(context).textTheme.bodyMedium),
                    Text(user.firstName, style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    BRCtaButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).performLogout();
                        },
                        text: 'Log out')
                  ]));
            },
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        }));
  }
}
