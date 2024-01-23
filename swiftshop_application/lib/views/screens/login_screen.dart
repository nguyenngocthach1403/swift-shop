import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiftshop_application/view_models/login_creen_view_model.dart';
import '../Animation/animation.dart';
import 'register_screen.dart';

class SignInScreen extends ConsumerWidget {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    final _isObscure = ref.watch(passwordVisibleProvider);
    // final _isObscure = ref.watch(passwordVisibleProvider);
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
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeAnimation(
                      1,
                      Container(
                        child: Image(
                          image: AssetImage('assets/icons/SwiftShop_logo.png'),
                          width: 400,
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1.2,
                      const Text(
                        'Welcome to SwiftShop',
                        style: TextStyle(
                          fontSize: 31.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                        obscureText: _isObscure,
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(passwordVisibleProvider.notifier).state =
                                  !ref.read(passwordVisibleProvider);
                            },
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
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
                          onPressed: () async {
                            try {
                              if (_formSignInKey.currentState!.validate()) {
                                await authNotifier.loginUserWithFirebase(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Success'),
                                  ),
                                );
                                // Navigate Home
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/homepage",
                                  (route) => false,
                                );
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      content: Text(
                                          'Invalid email or password!!! Please check again!!!'),
                                    );
                                  });
                            }
                          },
                          child: const Text('Sign in'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      2,
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
                              'OR',
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
                          onPressed: () async {
                            bool res = await authNotifier.signInWithGoogle();
                            if (res) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: ((context) => AddProductScreen())));
                            }
                          },
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
                            'Don\'t have an account? ',
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
                                  builder: (e) => SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign up',
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
