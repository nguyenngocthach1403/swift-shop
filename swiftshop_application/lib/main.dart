import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiftshop_application/views/components/cart_items.dart';
import 'package:swiftshop_application/views/screens/add_product_screen.dart';
import 'package:swiftshop_application/views/screens/admin_profile_screen.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/detail_order_screen.dart';
import 'package:swiftshop_application/views/screens/edit_profile_user_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';
import 'package:swiftshop_application/views/screens/login_screen.dart';
import 'package:swiftshop_application/views/screens/payment_screen.dart';
import 'package:swiftshop_application/views/screens/register_screen.dart';
import 'package:swiftshop_application/views/screens/searching_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftshop_application/views/screens/user_profile_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
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
          // "/": (context) => SignInScreen(),
          "/": (context) => AdminProfileScreen(),
          "/signup": (context) => SignUpScreen(),
          "/homepage": (context) => HomeScreen(),
          "/cartscreen": (context) =>
              Cart_Screen() // Thach 11/1 10:00 AM Thêm route cho Cart Screen
        });
  }
}
//first