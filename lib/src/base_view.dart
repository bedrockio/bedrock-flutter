import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/auth/login_screen.dart';
import 'package:bedrock_flutter/src/main_screen.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseView extends StatefulWidget {
  static const route = '/base';

  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
    ErrorHelper.errorStream.stream.listen((error) {
      showErrorBottomSheet(error, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        buildWhen: (previous, current) => current is LoggedIn || current is LoggedOut || current is LoginInitial,
        builder: (context, state) {
          if (state is LoggedIn) {
            return const MainScreen();
          }

          if (state is LoginInitial) {
            return const Center(child: CircularProgressIndicator(color: BRColors.white));
          }

          return LoginScreen();
        });
  }
}