import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';

class SignupOrLogin extends StatelessWidget {
  const SignupOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/Group 2 (3).png'),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Welcome to \n',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.w700,
                color: lightBlue,
                height: 0.5,
              ),
            ),
            Text(
              "My Pharmacist",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.w700,
                color: orange,
              ),
            ),
            Text(
              'Access an extensive database of drug information, check for interactions, and ensure safe and informed patient care',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w400,
                color: grey,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              label: 'Sign Up',
              onPressed: () {
                Get.offAllNamed('/sign-up');
              },
              color: lightBlue,
              textColor: backgroungColor,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: 'Login',
              onPressed: () {
                Get.offAllNamed('/sign-in');
              },
              color: Colors.transparent,
              textColor: lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
