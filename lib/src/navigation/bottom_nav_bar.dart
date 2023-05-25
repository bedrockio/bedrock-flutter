import '/src/navigation/cubit/bottom_nav_cubit.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final TabController tabController;

  const BottomNavBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavTab>(builder: (context, state) {
      return BottomAppBar(
          notchMargin: 1,
          color: BRColors.lightBrown,
          elevation: 1,
          clipBehavior: Clip.hardEdge,
          shape: const CircularNotchedRectangle(),
          child: Theme(
              data: ThemeData(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: TabBar(
                  onTap: (value) {
                    BlocProvider.of<BottomNavCubit>(context).changeTab(getTabFromIndex(value));
                  },
                  enableFeedback: false,
                  automaticIndicatorColorAdjustment: false,
                  indicatorWeight: 1,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    _TabBarItem('Home', icon: Icons.home, isSelected: state == BottomNavTab.home),
                    _TabBarItem('Products',
                        icon: Icons.shopping_cart_outlined, isSelected: state == BottomNavTab.products),
                    _TabBarItem('Profile', icon: Icons.person, isSelected: state == BottomNavTab.profile)
                  ],
                  controller: tabController)));
    });
  }
}

class _TabBarItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;

  const _TabBarItem(this.name, {required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 6),
          Icon(icon, color: isSelected ? BRColors.brown : Colors.grey),
          const SizedBox(height: 3),
          Text(name, style: BRFontStyle.body(size: 10, color: BRColors.brown)),
        ],
      ),
    );
  }
}
