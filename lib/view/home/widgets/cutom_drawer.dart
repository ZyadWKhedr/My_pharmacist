import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Drawer(
      child: Column(
        children: [
          // User information header with gradient background
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: lightBlue),
            accountName: Text(
              userViewModel.userName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              userViewModel.userEmail,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.white,
              child: Icon(
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
                // Home option with enhanced visual feedback
                ListTile(
                  leading: Icon(
                    CupertinoIcons.home,
                    color: lightBlue,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    if (Get.currentRoute != '/home') {
                      Get.offAllNamed('/home');
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const Divider(thickness: 1.0, color: Colors.grey),
              ],
            ),
          ),

          // Logout option at the bottom with better styling
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.square_arrow_right,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                userViewModel.signOut();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              tileColor: Colors.red.shade50,
            ),
          ),
        ],
      ),
    );
  }
}
