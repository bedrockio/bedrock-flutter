import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BRTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color backgroundColor;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final String? label;
  final TextStyle? textStyle;
  final bool hasBorder;
  final List<TextInputFormatter>? inputFormatters;
  final bool isEnabled;
  final String? initialValue;
  final TextCapitalization textCapitalization;

  const BRTextField(
      {super.key,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.focusNode,
      this.onSubmit,
      this.onChanged,
      this.label,
      this.backgroundColor = BRColors.secondary,
      this.textStyle = const TextStyle(fontSize: 18, color: BRColors.primaryText),
      this.hasBorder = true,
      this.inputFormatters,
      this.isEnabled = true,
      this.initialValue,
      this.textCapitalization = TextCapitalization.none});

  @override
  State<BRTextField> createState() => _BRTextField();

  static BRTextField outlined(
      {TextEditingController? controller,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      FocusNode? focusNode,
      Color backgroundColor = BRColors.secondary,
      Function(String)? onSubmit,
      Function(String)? onChanged,
      String? label,
      TextStyle? textStyle,
      List<TextInputFormatter>? inputFormatters,
      bool isEnabled = true,
      String? initialValue,
      TextCapitalization textCapitalization = TextCapitalization.none}) {
    return BRTextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      backgroundColor: backgroundColor,
      onSubmit: onSubmit,
      onChanged: onChanged,
      label: label,
      textStyle: textStyle,
      hasBorder: true,
      inputFormatters: inputFormatters,
      isEnabled: isEnabled,
      initialValue: initialValue,
      textCapitalization: textCapitalization,
    );
  }
}

class _BRTextField extends State<BRTextField> {
  late FocusNode focusNode;
  late TextEditingController controller;

  void focusNodeListener() {
    if (widget.controller != null) {
      controller.text = widget.controller!.text;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    focusNode = widget.focusNode ?? FocusNode();
    controller = widget.controller ?? TextEditingController();

    focusNode.addListener(focusNodeListener);
  }

  @override
  void dispose() {
    focusNode.removeListener(focusNodeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(BRPadding.small)),
      padding: widget.hasBorder
          ? null
          : EdgeInsets.fromLTRB(BRPadding.small, focusNode.hasFocus || controller.text.isNotEmpty ? BRPadding.small : 0,
              BRPadding.small, 0),
      child: TextFormField(
        enabled: widget.isEnabled,
        controller: widget.controller,
        initialValue: widget.initialValue,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        style: widget.textStyle,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmit,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          errorBorder: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BRPadding.small),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  gapPadding: 2.0,
                )
              : null,
          focusedBorder: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BRPadding.small),
                  borderSide: const BorderSide(color: BRColors.primary, width: 1),
                  gapPadding: 2.0,
                )
              : null,
          enabledBorder: widget.hasBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(BRPadding.small),
                  borderSide: BorderSide(color: BRColors.primary.withValues(alpha: 0.5), width: 1),
                  gapPadding: 2.0,
                )
              : null,
          border: widget.hasBorder
              ? null
              : OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(BRPadding.small)),
          floatingLabelStyle: widget.textStyle,
          labelStyle: widget.textStyle,
        ),
      ),
    );
  }
}
