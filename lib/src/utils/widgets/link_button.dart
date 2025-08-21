import '/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BRLinkButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const BRLinkButton({
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
          style:
              Theme.of(context).textTheme.bodyMedium?.copyWith(color: textColor, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
