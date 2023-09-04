import '/src/utils/constants/colors.dart';
import '/src/utils/constants/fonts.dart';
import 'package:flutter/material.dart';

class CtaLinkButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const CtaLinkButton({
    super.key,
    required this.text,
    this.textColor = BRColors.primaryText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: BRFontStyle.body(color: textColor, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
