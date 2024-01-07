import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/screens/admin_profile_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminProfileScreen(),
    );
  }
}
//first