import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final Color selectedColor;
  final Color unselectedColor;
  final Color unselectedBorderColor;
  final bool selected;

  const CheckBox({
    super.key,
    this.selected = false,
    this.selectedColor = BRColors.primary,
    this.unselectedColor = BRColors.secondary,
    this.unselectedBorderColor = BRColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: selected ? selectedColor : unselectedBorderColor, width: 2))),
        Positioned(
          top: 2,
          left: 2,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: selected ? selectedColor : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
              ),
              child: selected
                  ? Icon(
                      Icons.check,
                      color: unselectedColor,
                      size: 12,
                    )
                  : null),
        ),
      ],
    );
  }
}

class CheckBoxItem extends StatelessWidget {
  final String leftLabel;
  final String? rightLabel;
  final bool selected;
  final VoidCallback onSelect;

  const CheckBoxItem(
      {super.key, required this.leftLabel, this.rightLabel, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: BRPadding.xsmall),
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: onSelect,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            constraints: const BoxConstraints(minHeight: 70),
            padding: const EdgeInsets.symmetric(horizontal: BRPadding.small, vertical: BRPadding.small),
            decoration: BoxDecoration(
                color: selected ? BRColors.primary.withOpacity(0.75) : BRColors.primary.withOpacity(0.25),
                borderRadius: BorderRadius.circular(11)),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  leftLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: selected ? BRColors.secondary : BRColors.primary),
                )),
                if (rightLabel != null) ...[
                  Text(rightLabel!, style: Theme.of(context).textTheme.bodySmall),
                ],
                Padding(
                    padding: const EdgeInsets.only(left: BRPadding.small),
                    child: CheckBox(
                      selected: selected,
                      selectedColor: BRColors.secondary,
                      unselectedColor: BRColors.primary,
                    )),
              ],
            ),
          ),
        ));
  }
}

class CheckBoxGroup extends StatefulWidget {
  final List<String> leftLabels;
  final List<String>? rightLabels;
  final List<int>? selected;
  final Function(List<int> selectedIndexes) onSelect;

  const CheckBoxGroup({
    super.key,
    required this.leftLabels,
    this.rightLabels,
    this.selected,
    required this.onSelect,
  });

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroup();
}

class _CheckBoxGroup extends State<CheckBoxGroup> {
  late List<int> _selected;

  @override
  void initState() {
    super.initState();

    _selected = widget.selected ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.leftLabels.map((option) {
      int index = widget.leftLabels.indexOf(option);

      return CheckBoxItem(
          leftLabel: option,
          rightLabel:
              widget.rightLabels != null && widget.rightLabels!.length > index ? widget.rightLabels![index] : null,
          selected: _selected.contains(index),
          onSelect: () {
            setState(() {
              if (_selected.contains(index)) {
                _selected.remove(index);
              } else {
                _selected.add(index);
              }
            });
            widget.onSelect(_selected);
          });
    }).toList());
  }
}
