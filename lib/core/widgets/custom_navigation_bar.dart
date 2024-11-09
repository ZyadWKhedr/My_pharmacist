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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.05),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
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
        gap: screenWidth * 0.002,
        color: Colors.black,
        activeColor: lightBlue,
        iconSize: screenWidth * 0.06,
        tabBackgroundColor: orange.withOpacity(0.1),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.007),
        onTabChange: onTabChange,
        selectedIndex: currentIndex,
        tabs: [
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home_outlined,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.black,
                    shadows: currentIndex == 0
                        ? [
                            BoxShadow(
                                color: Colors.blue.withOpacity(0.6),
                                blurRadius: 8)
                          ]
                        : null,
                  ),
                ),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.chat_bubble,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  'AI Chat',
                  style: TextStyle(
                      fontSize: screenWidth * 0.03, color: Colors.black),
                ),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.clock,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  'Reminders',
                  style: TextStyle(
                      fontSize: screenWidth * 0.03, color: Colors.black),
                ),
              ],
            ),
          ),
          GButton(
            icon: Icons.circle,
            iconColor: Colors.transparent,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.heart,
                    color: Color(0xff003356), size: 24),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  'Favourites',
                  style: TextStyle(
                      fontSize: screenWidth * 0.03, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
