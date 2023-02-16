// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:we_link_app/views/auth/create_account_screen.dart';
import 'package:we_link_app/views/auth/login_screen.dart';
import 'package:we_link_app/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => CreateAccountScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
    );
  }
}
