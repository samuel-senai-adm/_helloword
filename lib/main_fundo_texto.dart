import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo.jpeg"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: const Center(
              child: Text(
                "SENAI",
                style: TextStyle(
                  fontSize: 60,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
    );
  }  // Widget
}  // Stateless widget