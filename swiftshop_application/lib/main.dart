import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/components/cart_items.dart';
import 'package:swiftshop_application/views/screens/add_product_screen.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/detail_order_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';
import 'package:swiftshop_application/views/screens/login_screen.dart';
import 'package:swiftshop_application/views/screens/payment_screen.dart';
import 'package:swiftshop_application/views/screens/register_screen.dart';
import 'package:swiftshop_application/views/screens/searching_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          "/cartscreen": (context) => Cart_Screen(),
          "/searchscreen": (context) =>
              SearchScreen() // Thach 11/1 10:00 AM Thêm route cho Cart Screen
        });
  }
}
//first