import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meditationapp/models/tips.dart';
import 'package:meditationapp/services/client_services.dart';

class TipProvider with ChangeNotifier {
  List<Tip> _tips = [];
  bool _isLoading = true;

  List<Tip> get tips => _tips.reversed.toList();

  bool get isLoading => _isLoading;

  Future<void> fetchTips() async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await Client.dio.get('/tips');

      if (response.data != null && response.data is List) {
        _tips = (response.data as List)
            .map((json) => Tip.fromJson(json))
            .where((tip) => tip.text != null && tip.author != null)
            .toList();
      } else {
        print('Error: Unexpected response format');
      }
    } catch (e) {
      print('Error fetching tips: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> upvoteTip(int tipId) async {
    try {
      await Client.dio.put('/tips/$tipId/upvote');
      await fetchTips();
    } catch (e) {
      print('Error upvoting tip: $e');
    }
  }

  Future<void> downvoteTip(int tipId) async {
    try {
      await Client.dio.put('/tips/$tipId/downvote');
      await fetchTips();
    } catch (e) {
      print('Error downvoting tip: $e');
    }
  }

  Future<void> createTip(String tipText, String author) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Client.dio.post(
        '/tips',
        data: {
          "text": tipText,
          "author": author,
        },
      );

      if (response.statusCode == 200) {
        print("Tip created successfully");
      } else {
        throw Exception("Failed to create tip");
      }
    } catch (error) {
      print("Error occurred: $error");
      throw error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> myFetchTips() async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await Client.dio.get('/tips');
      if (response.data != null && response.data is List) {
        _tips = (response.data as List)
            .map((json) => Tip.fromJson(json))
            .where((tip) => tip.text != null && tip.author != null)
            .toList();
      } else {
        print('Error: Unexpected response format');
      }
    } catch (e) {
      print('Error fetching tips: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTip({required int tipId}) async {
    try {
      await Client.dio.delete('/Tips/$tipId');
    } on DioException catch (error) {
      print(error);
    }
  }
}
