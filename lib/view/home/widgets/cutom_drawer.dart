import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Drawer(
      child: Column(
        children: [
          // User information header with light blue background
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: lightBlue, // Set background color to light blue
            ),
            accountName: Text(userViewModel.userName),
            accountEmail: Text(userViewModel.userEmail),
            currentAccountPicture: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.black,
                size: 30.0,
              ),
            ),
          ),

          // Main navigation options
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(CupertinoIcons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
          ),

          // Logout option at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: ListTile(
              leading: const Icon(CupertinoIcons.square_arrow_right),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                userViewModel.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
