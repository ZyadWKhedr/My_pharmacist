import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';

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
          return _buildPage(_pages[index]);
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
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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

  Container buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String myPharmacist = "My Pharmacist";
  final String title = "Welcome to \n";
  final String description;

  OnboardingPage({
    required this.image,
    required this.description,
  });
}
