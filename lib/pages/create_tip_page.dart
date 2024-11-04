import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:meditationapp/services/client_services.dart';

class CreateTipPage extends StatefulWidget {
  @override
  _CreateTipPageState createState() => _CreateTipPageState();
}

class _CreateTipPageState extends State<CreateTipPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  void _submitTip() async {
    String tipText = _controller.text.trim();

    if (tipText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tip can't be empty")),
      );
      return;
    } else if (tipText.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tip can't exceed 50 characters")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Client.dio.post(
        '/tips',
        data: {
          "text": tipText,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tip created successfully!")),
        );
        _controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create tip")),
        );
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $error')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Tip'),
        backgroundColor: Color(0xFF8990FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submitTip,
                    child: Text('Post Tip'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8990FF),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
