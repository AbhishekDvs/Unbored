import 'package:flutter/material.dart';
import 'package:paramanu/screens/BoredPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Unbored",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const BoredPage(title: "Unbored!"),
    );
  }
}
