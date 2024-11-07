import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healio/core/const.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const CustomNavigationBar({
    required this.currentIndex,
    required this.onTabChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GNav(
        haptic: true,
        tabBorderRadius: 20,
        tabActiveBorder: Border.all(color: Colors.black, width: 3),
        tabBorder: Border.all(color: Colors.grey, width: 1),
        tabShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
        ],
        curve: Curves.easeInCirc,
        duration: const Duration(milliseconds: 500),
        gap: 1,
        color: Colors.black,
        activeColor: lightBlue,
        iconSize: 24,
        tabBackgroundColor: orange.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTabChange: onTabChange,
        selectedIndex: currentIndex,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.chat_bubble,
            text: 'AI Chat',
          ),
          GButton(
            icon: Icons.alarm,
            text: 'Reminders',
          ),
          GButton(
            icon: Icons.person_2_rounded,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
