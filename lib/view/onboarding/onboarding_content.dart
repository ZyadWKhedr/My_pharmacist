import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view/onboarding/onboarding_page.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingContent({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              page.image,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            page.title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
              fontWeight: FontWeight.w700,
              color: lightBlue,
              height: 0.5,
            ),
          ),
          Text(
            page.myPharmacist,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.1,
              fontWeight: FontWeight.w700,
              color: orange,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w400,
              color: grey,
            ),
          ),
        ],
      ),
    );
  }
}
