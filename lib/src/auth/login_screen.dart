import '/src/utils/constants/validators.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/auth/register_screen.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/widgets/button.dart';
import '/src/utils/widgets/link_button.dart';
import '/src/utils/widgets/textfield.dart';
import 'otp_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const route = '/login';

  final TextEditingController _phoneNumberTextController = TextEditingController();
  final ValueNotifier<bool> _formValidated = ValueNotifier(false);

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(BRPadding.small),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                  child: Column(children: [
                const SizedBox(width: double.infinity, height: BRPadding.large),
                Hero(tag: 'bedrockImage', child: Image.asset('assets/images/bedrock.png', width: 150, height: 150)),
                const SizedBox(height: BRPadding.large),
                Text('Welcome to', style: Theme.of(context).textTheme.titleMedium),
                Text('bedrock flutter', style: Theme.of(context).textTheme.titleLarge),
              ])),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(BRPadding.xsmall),
                      child: Form(
                        onChanged: () {
                          _formValidated.value = Validators.phoneNumberRegExp.hasMatch(_phoneNumberTextController.text);
                        },
                        child: Column(children: [
                          BRTextField(
                            controller: _phoneNumberTextController,
                            label: 'Phone number',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LibPhonenumberTextFormatter(
                                phoneNumberFormat: PhoneNumberFormat.national,
                                inputContainsCountryCode: true,
                                country: const CountryWithPhoneCode.us(),
                              )
                            ],
                          ),
                          const SizedBox(height: BRPadding.small),
                          BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
                            state.maybeWhen(
                                loginOtpRequested: () {
                                  context.push(OtpScreen.loginRoute, extra: _phoneNumberTextController.text);
                                },
                                orElse: () {});
                          }, builder: (context, state) {
                            return state.maybeWhen(loading: () {
                              return const Center(child: CircularProgressIndicator());
                            }, orElse: () {
                              return ValueListenableBuilder<bool>(
                                  valueListenable: _formValidated,
                                  builder: (_, value, __) => BRCtaButton(
                                      onPressed: () {
                                        FocusManager.instance.primaryFocus?.unfocus();

                                        BlocProvider.of<AuthCubit>(context).requestVerificationCode(
                                            '+1${_phoneNumberTextController.text.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}');
                                      },
                                      enabled: value,
                                      text: 'Login'));
                            });
                          }),
                          const SizedBox(height: BRPadding.xsmall),
                          BRLinkButton(
                              text: 'No account yet? Register now!',
                              onPressed: () {
                                context.push(RegisterScreen.route);
                              }),
                        ]),
                      ),
                    )
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
