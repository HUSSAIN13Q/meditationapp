import 'package:flutter/material.dart';
import 'package:meditationapp/models/exercise.dart';
import 'package:meditationapp/services/client_services.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];
  bool _isLoading = true;

  List<Exercise> get exercises => _exercises;
  bool get isLoading => _isLoading;

  Future<void> fetchExercises() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Client.dio.get('/exercises');
      _exercises = (response.data as List)
          .map((data) => Exercise.fromJson(data))
          .toList();
    } catch (e) {
      print("Error fetching exercises: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  bool canPlayNextVideo(int index) {
    if (index == 0) return true;
    return _exercises[index - 1].finished;
  }

  Future<void> markExerciseFinished(int exerciseId) async {
    try {
      await Client.dio.post('/exercises/$exerciseId');
      await fetchExercises();
    } catch (e) {
      print("Error marking exercise as finished: $e");
    }
  }

  Exercise getExerciseById(int id) {
    return _exercises.firstWhere((exercise) => exercise.id == id);
  }
}
