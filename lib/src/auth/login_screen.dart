import '/src/auth/cubit/auth_cubit.dart';
import '/src/auth/login_otp_screen.dart';
import '/src/auth/register_screen.dart';
import '/src/network/api_error.dart';
import '/src/utils/constants/fonts.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/widgets/cta_button.dart';
import '/src/utils/widgets/cta_link_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  final TextEditingController _phoneNumberTextController = TextEditingController();
  final ValueNotifier<bool> _formValidated = ValueNotifier(false);

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(BRPadding.small),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Column(children: [
                    const SizedBox(width: double.infinity, height: BRPadding.large),
                    Image.asset('assets/images/bedrock.png', width: 150, height: 150),
                    const SizedBox(height: BRPadding.large),
                    Text('Welcome to', style: BRFontStyle.h2()),
                    Text('bedrock flutter', style: BRFontStyle.h1()),
                    const Spacer()
                  ]),
                  Column(children: [
                    const Spacer(),
                    Container(
                        padding: const EdgeInsets.all(BRPadding.xsmall),
                        color: Colors.white,
                        child: Form(
                            onChanged: () {
                              _formValidated.value = _phoneNumberTextController.text.isNotEmpty;
                            },
                            child: Column(children: [
                              TextFormField(
                                  controller: _phoneNumberTextController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LibPhonenumberTextFormatter(
                                      phoneNumberFormat: PhoneNumberFormat.national,
                                      inputContainsCountryCode: true,
                                      country: const CountryWithPhoneCode.us(),
                                    )
                                  ],
                                  decoration: const InputDecoration(label: Text('Phone number'))),
                              const SizedBox(height: BRPadding.small),
                              BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
                                if (state is LoginRequestSuccess) {
                                  Navigator.pushNamed(
                                    context,
                                    LoginOtpScreen.route,
                                    arguments: _phoneNumberTextController.text,
                                  );
                                } else if (state is LoginError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.error?.message ?? ApiError.defaultErrorMessage)));
                                }
                              }, builder: (context, state) {
                                if (state is LoginLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return ValueListenableBuilder<bool>(
                                    valueListenable: _formValidated,
                                    builder: (_, value, __) => CtaButton(
                                        onPressed: () {
                                          BlocProvider.of<AuthCubit>(context).requestVerificationCode(
                                              '+1${_phoneNumberTextController.text.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}');
                                        },
                                        enabled: value,
                                        text: 'Login'));
                              }),
                              const SizedBox(height: BRPadding.xsmall),
                              CtaLinkButton(
                                  text: 'No account yet? Register now!',
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(RegisterScreen.route);
                                  })
                            ])))
                  ])
                ]))));
  }
}
