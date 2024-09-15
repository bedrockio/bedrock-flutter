import '/src/auth/cubit/auth_cubit.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/widgets/otp_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatelessWidget {
  static const loginRoute = '/login/otp';
  static const registerRoute = '/register/otp';

  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BRColors.secondary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 32, color: BRColors.primary),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(BRPadding.small),
                child: Column(children: [
                  const SizedBox(width: double.infinity, height: BRPadding.small),
                  Hero(
                    tag: 'bedrockImage',
                    child: Image.asset('assets/images/bedrock.png', width: 75, height: 75),
                  ),
                  const SizedBox(height: BRPadding.large),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    return state.maybeWhen(loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }, orElse: () {
                      return OtpWidget(
                          phoneNumber: phoneNumber,
                          instructionText: 'Enter the code below to continue.',
                          onCompleted: (code) {
                            BlocProvider.of<AuthCubit>(context).performLogin(
                                '+1${phoneNumber.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}', code);
                          });
                    });
                  })
                ]))));
  }
}
