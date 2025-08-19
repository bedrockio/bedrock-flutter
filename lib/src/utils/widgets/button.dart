import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';

class BRCtaButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final Color backgroundColor;
  final Color textColor;
  final bool compact;
  final Function() onPressed;

  const BRCtaButton(
      {super.key,
      required this.text,
      this.backgroundColor = BRColors.primary,
      this.textColor = BRColors.secondary,
      this.enabled = true,
      this.compact = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(backgroundColor.withValues(alpha: enabled ? 1.0 : 0.5)),
            overlayColor: WidgetStateProperty.all<Color>(textColor.withValues(alpha: 0.15)),
            foregroundColor: WidgetStateProperty.all<Color>(textColor.withValues(alpha: enabled ? 1.0 : 0.5)),
            splashFactory: NoSplash.splashFactory,
            elevation: WidgetStateProperty.all<double>(0.0),
            shape:
                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(BRPadding.small)))),
        onPressed: enabled ? onPressed : null,
        child: SizedBox(
          width: compact ? null : double.infinity,
          height: compact ? null : 56,
          child: Center(
              widthFactor: compact ? 1 : 100, child: Text(text, style: TextStyle(fontSize: compact ? null : 18))),
        ));
  }

  static BRCtaButton small({
    required String text,
    bool enabled = true,
    Color backgroundColor = BRColors.primary,
    Color textColor = BRColors.secondary,
    required Function() onPressed,
  }) {
    return BRCtaButton(
      text: text,
      enabled: enabled,
      backgroundColor: backgroundColor,
      textColor: textColor,
      compact: true,
      onPressed: onPressed,
    );
  }
}
