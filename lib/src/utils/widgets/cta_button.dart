import '/src/utils/constants/colors.dart';
import '/src/utils/constants/fonts.dart';
import 'package:flutter/material.dart';

class CtaButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool enabled;
  final BRColorScheme? colorScheme;
  final BorderSide border;

  const CtaButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.enabled = true,
      this.colorScheme,
      this.border = const BorderSide(color: Colors.transparent, width: 0)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 22)),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all(colorScheme?.backgroundColor.withOpacity(enabled ? 1.0 : 0.5) ??
              BRColors.brown.withOpacity(enabled ? 1.0 : 0.5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: border,
            ),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: 10,
              child: Text(
                text.toUpperCase(),
                style: BRFontStyle.bodyMedium(color: colorScheme?.textColor ?? BRColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
