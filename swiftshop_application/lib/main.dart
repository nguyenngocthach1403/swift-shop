import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiftshop_application/firebase_options.dart';
import 'package:swiftshop_application/views/screens/admin_profile_screen.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';
import 'package:swiftshop_application/views/screens/login_screen.dart';
import 'package:swiftshop_application/views/screens/register_screen.dart';
import 'package:swiftshop_application/views/screens/searching_screen.dart';
import 'package:swiftshop_application/views/screens/user_profile_screen.dart';

//first
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //     apiKey: "AIzaSyB4uR5_QlrE5TwAPReT-bN93MH2SvH1HOM",
    //     appId: "1:475664841613:android:bb3894c3094a582cec5bc4",
    //     messagingSenderId: "475664841613",
    //     projectId: "swiftshop-5e2eb",
    //     storageBucket: "swiftshop-5e2eb.appspot.com"));
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String idCurrentUser = FirebaseAuth.instance.currentUser!.uid;
  String position = "";
  //Lấy posion
  Future<String> positionOfUser(String idCurrentUser) async {
    QuerySnapshot a =
        await FirebaseFirestore.instance.collection('accounts').get();
    for (var i in a.docs) {
      if (i.id == idCurrentUser) {
        return i['position'];
      }
    }
    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    positionOfUser(idCurrentUser).then((value) {
      setState(() {
        position = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              final user = snapshot.data as User?;
              return user != null ? HomeScreen() : SignInScreen();
            }
          },
        ),
        routes: {
          //": (context) => SignInScreen(),
          // "/": (context) => SignInScreen(),
          "/signup": (context) => SignUpScreen(),
          "/homepage": (context) => HomeScreen(),
          "/cartscreen": (context) => Cart_Screen(),
          "/searchscreen": (context) =>
              SearchScreen(), // Thach 11/1 10:00 AM Thêm route cho Cart Screen
          "/profile": (context) => position == "User"
              ? UserProfileScreen()
              : AdminProfileScreen(), // Toan 17/1 10:28 AM Thêm route cho UserProfile // Toan 17/1 10:28 AM Thêm route cho UserProfile
        });
  }
}
//first
