import '/src/auth/login_screen.dart';
import '/src/home/home_screen.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/profile/cubit/profile_cubit.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/error_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BaseView extends StatefulWidget {
  static const route = '/';

  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseView();
}

class _BaseView extends State<BaseView> {
  @override
  void initState() {
    ErrorHelper.errorStream.stream.listen((error) {
      if (mounted) {
        showErrorBottomSheet(error, context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRColors.primary,
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        state.maybeWhen(
            loggedIn: () {
              BlocProvider.of<ProfileCubit>(context).fetchUser();

              context.replace(HomeScreen.route);
            },
            loggedOut: () {
              context.go(LoginScreen.route);
            },
            orElse: () {});
      }, builder: (context, state) {
        return const Center(child: CircularProgressIndicator(color: BRColors.secondary));
      }),
    );
  }
}
