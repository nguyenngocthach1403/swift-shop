import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/components/cart_items.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';
import 'package:swiftshop_application/views/screens/login_screen.dart';
import 'package:swiftshop_application/views/screens/register_screen.dart';

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
      routes: {
        "/": (context) => SignInScreen(),
        "/signup": (context) => SignUpScreen(),
        "/homepage": (context) => HomeScreen(),
      },
    );
  }
}
//first