import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/main_screen.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginOtpScreen extends StatelessWidget {
  static const route = '/login_otp_screen';

  final String phoneNumber;

  const LoginOtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(BRPadding.small),
                child: Column(children: [
                  const SizedBox(width: double.infinity, height: BRPadding.small),
                  Image.asset('assets/images/bedrock.png', width: 75, height: 75),
                  const SizedBox(height: BRPadding.large),
                  BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.route, (route) => false);
                    }

                    if (state is LoginError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error?.message ?? 'Something went wrong.')));
                    }
                  }, builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(child: CircularProgressIndicator(color: BRColors.black));
                    }
                    return OtpWidget(
                        phoneNumber: phoneNumber,
                        instructionText: 'Enter the code below to continue.',
                        onCompleted: (code) {
                          BlocProvider.of<AuthCubit>(context)
                              .performLogin('+1${phoneNumber.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}', code);
                        });
                  })
                ]))));
  }
}
