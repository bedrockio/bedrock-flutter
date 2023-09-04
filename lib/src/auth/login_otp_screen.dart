import '/src/auth/cubit/auth_cubit.dart';
import '/src/main_screen.dart';
import '/src/profile/cubit/profile_cubit.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/widgets/otp_widget.dart';
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
                      BlocProvider.of<ProfileCubit>(context).fetchUser();
                      Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.route, (route) => false);
                    }
                  }, builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(child: CircularProgressIndicator(color: BRColors.primaryText));
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
