import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:swiftshop_application/view_models/login_creen_view_model.dart';
import '../Animation/animation.dart';
import 'login_screen.dart';

// class SignUpScreen extends ConsumerWidget {
//   SignUpScreen({super.key});

//   // @override
//   // State<SignUpScreen> createState() => _SignUpScreenState();
// }

class SignUpScreen extends ConsumerWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _fullname = TextEditingController();
  final _formSignupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(96, 136, 202, 1),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(96, 136, 202, 1),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formSignupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    FadeAnimation(
                      1.0,
                      const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FadeAnimation(
                      1.2,
                      TextFormField(
                        controller: _fullname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Fullname';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.person),
                          label: const Text('Fullname'),
                          hintText: 'Enter your Fullname',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1.4,
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email_outlined),
                          label: const Text('Email'),
                          hintText: 'Enter your Email',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1.6,
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.key_sharp),
                          label: const Text('Password'),
                          hintText: 'Enter your Password',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1.8,
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                          onPressed: () {
                            if (_formSignupKey.currentState!.validate()) {
                              authNotifier.signupUserWithFirebase(
                                  _fullname.text, _email.text, _password.text);
                              Navigator.pushNamed(context, '/');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Create Account Success'),
                                ),
                              );
                            }
                          },
                          child: const Text('Sign up'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      2.0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Sign in with',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    FadeAnimation(
                      2.2,
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage("assets/images/logo.png"),
                            width: 20.0,
                          ),
                          label: Text("Sign-In with Google"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    FadeAnimation(
                      2.4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => SignInScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
