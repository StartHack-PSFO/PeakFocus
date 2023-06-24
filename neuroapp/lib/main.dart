import 'package:flutter/material.dart';
import 'package:neuroapp/views/homeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xF6E81D), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}
