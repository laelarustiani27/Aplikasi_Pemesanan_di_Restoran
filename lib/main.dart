import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const GoBizlyApp());
}

class GoBizlyApp extends StatelessWidget {
  const GoBizlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoBizly',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const LoginPage(),
    );
  }
}
