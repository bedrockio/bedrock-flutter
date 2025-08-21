import '/src/utils/bottom_nav_tab.dart';
import '/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomBarItem extends StatefulWidget {
  final BottomNavTab tab;
  final bool isSelected;
  final int notificationUnreadCount;
  final VoidCallback onSelect;

  const BottomBarItem(
      {super.key,
      required this.tab,
      required this.isSelected,
      this.notificationUnreadCount = 0,
      required this.onSelect});

  @override
  State<BottomBarItem> createState() => _BottomBarItem();
}

class _BottomBarItem extends State<BottomBarItem> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();

    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      onTapDown: (_) {
        if (widget.isSelected) return;
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (_) {
        if (widget.isSelected) return;
        setState(() {
          isSelected = false;
        });
      },
      onTap: () {
        widget.onSelect();
      },
      child: SizedBox(
        height: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _getTabIcon(widget.tab, (isSelected && !widget.isSelected) || widget.isSelected),
            const SizedBox(height: 6),
            Text(getTabName(widget.tab),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: isSelected || widget.isSelected ? BRColors.primary : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _getTabIcon(BottomNavTab tab, bool isSelected) {
    switch (tab) {
      case BottomNavTab.home:
        return Icon(isSelected ? Icons.home : Icons.home_outlined, color: isSelected ? BRColors.primary : Colors.grey);

      case BottomNavTab.products:
        return Icon(isSelected ? Icons.shopping_cart : Icons.shopping_cart_outlined,
            color: isSelected ? BRColors.primary : Colors.grey);

      case BottomNavTab.profile:
        return Icon(isSelected ? Icons.person : Icons.person_outline,
            color: isSelected ? BRColors.primary : Colors.grey);
    }
  }
}
