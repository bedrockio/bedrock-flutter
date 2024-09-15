import '/src/auth/cubit/auth_cubit.dart';
import '/src/auth/otp_screen.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/widgets/button.dart';
import '/src/utils/widgets/checkbox.dart';
import '/src/utils/widgets/textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class RegisterScreen extends StatelessWidget {
  static const route = '/register';

  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController = TextEditingController();
  final ValueNotifier<bool> _agreeTerms = ValueNotifier(false);
  final ValueNotifier<bool> _formValidated = ValueNotifier(false);

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BRColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32, color: BRColors.primary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(BRPadding.small),
              child: Column(children: [
                Hero(
                  tag: 'bedrockImage',
                  child: Image.asset('assets/images/bedrock.png', width: 44, height: 44),
                ),
                const SizedBox(height: BRPadding.small),
                Text('Create an account', style: Theme.of(context).textTheme.titleMedium),
              ]),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: BRPadding.small),
                child: Form(
                  onChanged: () => _validate(),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    BRTextField(
                      controller: _firstNameTextController,
                      label: 'First name',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: BRPadding.small),
                    BRTextField(
                        controller: _lastNameTextController, label: 'Last name', textInputAction: TextInputAction.next),
                    const SizedBox(height: BRPadding.small),
                    BRTextField(
                        controller: _emailTextController,
                        label: 'Email address',
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: BRPadding.small),
                    BRTextField(
                        controller: _phoneNumberTextController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LibPhonenumberTextFormatter(
                            phoneNumberFormat: PhoneNumberFormat.national,
                            inputContainsCountryCode: true,
                            country: const CountryWithPhoneCode.us(),
                          )
                        ],
                        label: 'Phone number'),
                    const SizedBox(height: BRPadding.small),
                    ValueListenableBuilder<bool>(
                        valueListenable: _agreeTerms,
                        builder: (_, value, __) => InkWell(
                            onTap: () {
                              _agreeTerms.value = !_agreeTerms.value;
                              _validate();
                            },
                            child: AbsorbPointer(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CheckBox(selected: value),
                                const SizedBox(width: BRPadding.xsmall),
                                Expanded(
                                    child: Text('I agree to the Terms & Conditions',
                                        style: Theme.of(context).textTheme.bodySmall))
                              ],
                            )))),
                    const SizedBox(height: BRPadding.small),
                    BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
                      state.maybeWhen(
                          registerSuccess: () {
                            BlocProvider.of<AuthCubit>(context).requestVerificationCode(
                                '+1${_phoneNumberTextController.text.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}',
                                isRegistration: true);
                          },
                          registerOtpRequested: () {
                            Navigator.pushNamed(
                              context,
                              OtpScreen.registerRoute,
                              arguments: _phoneNumberTextController.text,
                            );
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
                                  BlocProvider.of<AuthCubit>(context).registerUser(
                                      firstName: _firstNameTextController.text,
                                      lastName: _lastNameTextController.text,
                                      email: _emailTextController.text,
                                      phoneNumber:
                                          '+1${_phoneNumberTextController.text.replaceAll(RegExp(' |-|\\(|\\)'), '').toString()}');
                                },
                                enabled: value,
                                text: 'Register'));
                      });
                    })
                  ]),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void _validate() {
    _formValidated.value = _firstNameTextController.text.isNotEmpty &&
        _lastNameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _phoneNumberTextController.text.length == 14 &&
        _agreeTerms.value == true;
  }
}
