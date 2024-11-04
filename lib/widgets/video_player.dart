import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditationapp/providers/exercise_provider.dart';
import 'package:provider/provider.dart';

class VideoPlayerPage extends StatelessWidget {
  final int exerciseId;
  final String videoUrl;

  VideoPlayerPage({required this.exerciseId, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final exerciseProvider = Provider.of<ExerciseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Video'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              exerciseProvider.markExerciseFinished(exerciseId);
              //Navigator.pop(context);
              context.pop();
            },
            child: Text('Mark as Finished'),
          ),
        ],
      ),
    );
  }
}
