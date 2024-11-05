import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            indent: 10,
            thickness: 2,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: Divider(
            endIndent: 10,
            thickness: 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
