import 'package:flutter/material.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userViewModel.userName),
            accountEmail: Text(userViewModel.userEmail),
            currentAccountPicture: Container(
              width: 60.0,
              height: 60.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              userViewModel.signOut();
            },
          ),
        ],
      ),
    );
  }
}
