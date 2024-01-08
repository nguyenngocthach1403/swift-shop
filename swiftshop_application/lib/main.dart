import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:swiftshop_application/views/screens/admin_profile_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';
import 'package:swiftshop_application/views/screens/order_manager_screen.dart';
=======
>>>>>>> 051032475271de7dae9d14f5575b663091e11d18

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
      home: OrderManagementScreen(),
    );
  }
}
//first