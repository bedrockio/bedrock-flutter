import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/auth/login_otp_screen.dart';
import 'package:bedrock_flutter/src/network/api_error.dart';
import 'package:bedrock_flutter/src/utils/constants/fonts.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class RegisterScreen extends StatelessWidget {
  static const route = '/register';

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final ValueNotifier<bool> _formValidated = ValueNotifier(false);

  RegisterScreen({super.key});

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
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Column(children: [
                    Image.asset('assets/images/bedrock.png', width: 44, height: 44),
                    const SizedBox(height: BRPadding.small),
                    Text('Create an account', style: BRFontStyle.h2()),
                    const Spacer()
                  ]),
                  Column(children: [
                    const Spacer(),
                    Container(
                        padding: const EdgeInsets.all(BRPadding.xsmall),
                        color: Colors.white,
                        child: Form(
                            onChanged: () {
                              _formValidated.value = _firstNameTextController.text.isNotEmpty &&
                                  _lastNameTextController.text.isNotEmpty &&
                                  _phoneNumberTextController.text.isNotEmpty;
                            },
                            child: Column(children: [
                              TextFormField(
                                  controller: _firstNameTextController,
                                  decoration: const InputDecoration(label: Text('First name'))),
                              TextFormField(
                                  controller: _lastNameTextController,
                                  decoration: const InputDecoration(label: Text('Last name'))),
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
                                if (state is RegistrationSuccess) {
                                  Navigator.pushNamed(
                                    context,
                                    LoginOtpScreen.route,
                                    arguments: _phoneNumberTextController.text,
                                  );
                                }

                                if (state is RegistrationError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.error?.message ?? ApiError.defaultErrorMessage)));
                                }
                              }, builder: (context, state) {
                                if (state is RegistrationLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return ValueListenableBuilder<bool>(
                                    valueListenable: _formValidated,
                                    builder: (_, value, __) => CtaButton(
                                        onPressed: () {
                                          BlocProvider.of<AuthCubit>(context).registerUser(
                                              firstName: _firstNameTextController.text,
                                              lastName: _lastNameTextController.text,
                                              phoneNumber:
                                                  '+1${_phoneNumberTextController.text.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}');
                                        },
                                        enabled: value,
                                        text: 'Register'));
                              })
                            ])))
                  ])
                ]))));
  }
}
