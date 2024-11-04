import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final Function onTap;

  HomeCard(
      {required this.title,
      required this.image,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(), // InkWell to handle clicks
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, height: 100, width: 100),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 105, 115, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
