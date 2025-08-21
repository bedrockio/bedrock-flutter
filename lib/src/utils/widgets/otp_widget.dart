import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '/src/utils/constants/colors.dart';

class OtpWidget extends StatelessWidget {
  final String phoneNumber;
  final String instructionText;
  final Function(String code) onCompleted;
  final TextEditingController textEditingController = TextEditingController();

  OtpWidget({super.key, required this.phoneNumber, required this.instructionText, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('We just sent you a six-digit code to $phoneNumber. $instructionText',
          style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 30),
      PinCodeTextField(
        appContext: context,
        length: 6,
        obscureText: true,
        obscuringWidget:
            const Padding(padding: EdgeInsets.only(top: 10), child: Text('*', style: TextStyle(fontSize: 34))),
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderWidth: 2,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 65,
            fieldWidth: 50,
            selectedFillColor: Colors.white,
            activeColor: BRColors.primaryText,
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.white,
            inactiveColor: BRColors.primaryText),
        cursorColor: BRColors.primary,
        animationDuration: const Duration(milliseconds: 100),
        enableActiveFill: true,
        controller: textEditingController,
        keyboardType: TextInputType.number,
        onChanged: (v) {},
        onCompleted: onCompleted,
        beforeTextPaste: (text) {
          return true;
        },
      )
    ]);
  }
}
