import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/pages/create_tip_page.dart';
import 'package:meditationapp/pages/exercise_page.dart';
import 'package:meditationapp/pages/home_page.dart';
import 'package:meditationapp/pages/onboarding_page.dart';
import 'package:meditationapp/pages/splash_page.dart';
import 'package:meditationapp/pages/tips_page.dart';
import 'package:meditationapp/providers/auth_proider.dart';
import 'package:meditationapp/providers/exercise_provider.dart';
import 'package:meditationapp/providers/theme_provider.dart';
import 'package:meditationapp/providers/tips_provider.dart';
import 'package:meditationapp/sign/siginin_page.dart';
import 'package:meditationapp/sign/signUp_page.dart';
import 'package:meditationapp/widgets/video_player.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<TipProvider>(create: (_) => TipProvider()),
        ChangeNotifierProvider<ExerciseProvider>(
            create: (_) => ExerciseProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meditation App',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF8990FF),
        scaffoldBackgroundColor: Color(0xFFE0E7FF),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF8990FF),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      // home: HomePage(),
    );
  }
}

final _router = GoRouter(
  initialLocation: "/onboarding",
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => SigninPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: '/tips',
      builder: (context, state) => TipsPage(),
    ),
    GoRoute(
      path: '/CreateTipPage',
      builder: (context, state) => CreateTipPage(),
    ),
    GoRoute(
      path: '/exercises',
      builder: (context, state) => ExercisePage(),
    ),
    GoRoute(
      path: '/video/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final exercise = context.read<ExerciseProvider>().getExerciseById(id);
        return VideoPlayerPage(
          exerciseId: id,
          videoUrl: exercise.file,
        );
      },
    ),
  ],
);
