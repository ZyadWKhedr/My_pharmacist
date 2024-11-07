import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: screenWidth * 0.8,
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for a drug...',
            hintStyle: const TextStyle(color: Color(0xff003356)),
            prefixIcon: const Icon(Icons.search, color: Color(0xff003356)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: lightBlue, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: lightBlue, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: lightBlue, width: 2.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
