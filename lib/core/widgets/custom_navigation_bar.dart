import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healio/core/const.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const CustomNavigationBar({
    required this.currentIndex,
    required this.onTabChange,
    Key? key,
  }) : super(key: key);

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
        curve: Curves.easeInCirc,
        duration: const Duration(milliseconds: 500),
        gap: 1,
        color: Colors.black,
        activeColor: lightBlue,
        iconSize: 0,
        tabBackgroundColor: orange.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTabChange: onTabChange,
        selectedIndex: currentIndex,
        tabs: const [
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_filled, color: Color(0xff003356), size: 24),
                SizedBox(height: 4),
                Text('Home',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble, color: Color(0xff003356), size: 24),
                SizedBox(height: 4),
                Text('AI Chat',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.clock_fill,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: 4),
                Text('Reminders',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.heart_fill,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: 4),
                Text('Favourites',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
