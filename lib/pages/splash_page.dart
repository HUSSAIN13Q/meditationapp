import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/auth_proider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

      if (seenOnboarding) {
        // If onboarding has been seen, proceed to check if user is logged in
        if (await context.read<AuthProvider>().isLoggedFromStoreToken()) {
          context.go("/home");
        } else {
          context.go('/signin');
        }
      } else {
        // If onboarding has not been seen, show onboarding and set it as seen
        prefs.setBool('seenOnboarding', true);
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthProvider>().isLoggedFromStoreToken();
        },
        child: Text("test"),
      ),
    ));
  }
}
