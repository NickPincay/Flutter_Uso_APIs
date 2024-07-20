import 'package:flutter/material.dart';
import 'package:flutter_uso_apis/widgets/home.dart';
import 'package:flutter_uso_apis/widgets/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0XFFF95B1A),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Apis en Flutter',
      home: const Login(),
      routes: {
        '/home': (context) => const Home(),
      },
    );
  }
}
