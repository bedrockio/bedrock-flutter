import '/src/utils/bottom_nav_tab.dart';
import '/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final BottomNavTab tab;
  final bool isSelected;
  final int notificationUnreadCount;

  const BottomBarItem({super.key, required this.tab, required this.isSelected, this.notificationUnreadCount = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _getTabIcon(tab, isSelected),
          const SizedBox(height: 6),
          Text(getTabName(tab),
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: isSelected ? BRColors.primary : Colors.grey)),
        ],
      ),
    );
  }

  Widget _getTabIcon(BottomNavTab tab, bool isSelected) {
    switch (tab) {
      case BottomNavTab.home:
        return Icon(Icons.home, color: isSelected ? BRColors.primary : Colors.grey);

      case BottomNavTab.products:
        return Icon(Icons.shopping_cart_outlined, color: isSelected ? BRColors.primary : Colors.grey);

      case BottomNavTab.profile:
        return Icon(Icons.person, color: isSelected ? BRColors.primary : Colors.grey);
    }
  }
}
