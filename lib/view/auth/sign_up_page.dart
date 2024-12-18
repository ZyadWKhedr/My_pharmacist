import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/view/auth/widgets/custom_text_field.dart';
import 'package:healio/view/auth/widgets/or_divider.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/Logo 1.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                Text(
                  'Join the best pharmacy app \nMy Pharmacist now for free ',
                  style: TextStyle(
                    fontSize: 20,
                    color: lightBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: nameController,
                  label: 'Name',
                  prefixIcon: const Icon(Icons.text_format),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Have an account ?'),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Get.offAllNamed('/sign-in');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: 'Create an account',
                  onPressed: () {
                    userViewModel.signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim());
                  },
                  color: lightBlue,
                  widthFactor: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                const OrDivider(),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  label: 'Sign Up with Google',
                  onPressed: () {
                    userViewModel.signInWithGoogle();
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  widthFactor: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: 'Sign Up with X',
                  onPressed: () {},
                  color: Colors.black,
                  textColor: Colors.white,
                  widthFactor: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
