import 'package:get/get.dart';
import 'package:healio/view/auth/sign_up_page.dart';
import 'package:healio/view/auth/sign_in_page.dart';
import 'package:healio/view/auth/signup_or_login.dart';
import 'package:healio/view/home_page.dart';
import 'package:healio/view/onboarding/onboarding_screen.dart';
import 'package:healio/view/splash_screen.dart';

import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignInPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signUpOrLogin,
      page: () => SignupOrLogin(),
      transition: Transition.size,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.native,
    ),
  ];
}
