import 'package:flutter/material.dart';
import 'package:finalproject/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter book store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 10, 10, 10),
        ),
        useMaterial3: true,
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
      ),
      home: HomePage(),
    );
  }
}
