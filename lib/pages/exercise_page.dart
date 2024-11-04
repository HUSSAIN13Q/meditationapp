import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/exercise_provider.dart';
import 'package:meditationapp/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExerciseProvider>().fetchExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final exerciseProvider = Provider.of<ExerciseProvider>(context);
    final isDarkTheme = themeProvider.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Videos'),
        backgroundColor: isDarkTheme ? Colors.black : Color(0xFF8990FF),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8990FF), Color(0xFFE0E7FF)],
          ),
        ),
        child: exerciseProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: exerciseProvider.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exerciseProvider.exercises[index];
                  return ListTile(
                    title: Text(
                      exercise.title,
                      style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      Icons.play_arrow,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                    onTap: exerciseProvider.canPlayNextVideo(index)
                        ? () {
                            context.push('/video/${exercise.id}');
                          }
                        : null,
                  );
                },
              ),
      ),
    );
  }
}
