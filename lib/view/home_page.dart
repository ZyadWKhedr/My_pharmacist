import 'package:flutter/material.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Center(
        child: CustomButton(
            label: 'Sign out',
            onPressed: () {
              userViewModel.signOut();
            }),
      ),
    );
  }
}
