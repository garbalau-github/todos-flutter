import 'package:flutter/material.dart';
import 'package:flutter_todos/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // Hive
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Todos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const HomePage());
  }
}
