import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Meditation App",
          body: "Track your meditation, yoga, and exercises all in one app.",
          image: Image.asset(
            'assets/images/onboarding1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            imageFlex: 3,
            bodyFlex: 2,
            fullScreen: true,
          ),
        ),
        PageViewModel(
          title: "Discover Tips & Music",
          body: "Find the best tips and music for mindfulness and meditation.",
          image: Image.asset(
            'assets/images/onboarding2.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            imageFlex: 3,
            bodyFlex: 2,
            fullScreen: true,
          ),
        ),
        PageViewModel(
          title: "Get Started Today",
          body: "Sign up and begin your mindfulness journey now!",
          image: Image.asset(
            'assets/images/onboarding3.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            imageFlex: 3,
            bodyFlex: 2,
            fullScreen: true,
          ),
        ),
      ],
      onDone: () {
        context.go('/signin');
      },
      onSkip: () {
        context.go('/signin');
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
