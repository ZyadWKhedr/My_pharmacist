import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/view/onboarding/onboarding_content.dart';
import 'package:healio/view/onboarding/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/Group 2 (1).png',
      description:
          'Transform your pharmacy practice with PharmaCare — your all-in-one app for efficient medication management and enhanced patient care.',
    ),
    OnboardingPage(
      image: 'assets/images/rb_162852 1.png',
      description:
          'Manage prescriptions, track patient histories, and set up medication reminders — all from one convenient app.',
    ),
    OnboardingPage(
      image: 'assets/images/Group 2.png',
      description:
          'Access an extensive database of drug information, check for interactions, and ensure safe and informed patient care.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardingContent(page: _pages[index]);
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (_currentIndex < _pages.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            Get.offNamed('/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _currentIndex == _pages.length - 1
                    ? Icons.check
                    : Icons.arrow_forward,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
