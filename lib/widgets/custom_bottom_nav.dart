import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const CustomBottomNav({Key? key, required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0).copyWith(left: 6,right: 6,bottom: 9),
      child: GNav(
          rippleColor: Theme.of(context).primaryColor.withOpacity(0.1),
          hoverColor: Theme.of(context).primaryColorLight,
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Theme.of(context).primaryColor, width: 1.3),
          tabBorder: Border.all(color: Theme.of(context).primaryColorLight.withOpacity(0.4), width: 1.5),
          tabShadow: [BoxShadow(color: Theme.of(context).primaryColorLight.withOpacity(0.10), blurRadius: 10)],
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 500),
          gap: 20,
          color: Theme.of(context).primaryColorLight,
          activeColor: Theme.of(context).primaryColorDark,
          iconSize: 24, // tab button icon size
          tabBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.10),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6),
          selectedIndex:index,
          tabs: [
            GButton(
              icon: Icons.add,
              text: 'New',
            ),
            GButton(
              icon: Icons.check_circle_outline_rounded,
              text: 'Done',
            ),
            GButton(
              icon: Icons.archive,
              text: 'Archive',
            ),
          ],
          onTabChange: onTap
      ),
    );
  }
}