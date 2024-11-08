import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pill Reminders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: lightBlue,
      ),
    );
  }
}
