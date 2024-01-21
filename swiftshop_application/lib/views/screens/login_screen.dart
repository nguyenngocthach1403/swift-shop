import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/view_models/login_creen_view_model.dart';
import 'package:swiftshop_application/views/screens/add_product_screen.dart';
import 'package:swiftshop_application/views/screens/admin_profile_screen.dart';
import 'package:swiftshop_application/views/screens/edit_profile_user_screen.dart';
import 'package:swiftshop_application/views/screens/update_product_screen.dart';
import '../Animation/animation.dart';
import 'register_screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
class SignInScreen extends ConsumerWidget {
  String? user1;
  // bool pass = true;
  final _formSignInKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    final _isObscure = ref.watch(passwordVisibleProvider);
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
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1,
                      const Text(
                        'Welcome to SwiftShop',
                        style: TextStyle(
                          fontSize: 31.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FadeAnimation(
                      1.2,
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
                      1.4,
                      TextFormField(
                        controller: _password,
                        // obscureText: pass ? _isObscure : false,
                        // obscureText: ref.watch(passwordVisibleProvider),
                        // obscureText: ref.watch(passwordVisibleProvider),
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
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     // setState(() {
                          //     //   _isObscure = !_isObscure;
                          //     // });
                          //     ref.read(passwordVisibleProvider).state =
                          //         !passwordVisibleProvider.state;
                          //   },
                          //   icon: Icon(_isObscure
                          //       ? Icons.visibility_off
                          //       : Icons.visibility),
                          // ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    FadeAnimation(
                      1.6,
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

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: ((context) => UpdateProductScreen(
                                //           product: Product(
                                //               id: "",
                                //               path: "",
                                //               price: 0,
                                //               title: "",
                                //               promotionalPrice: 0,
                                //               type: "",
                                //               quantity: 0,
                                //               quantitySold: 0,
                                //               rate: 0,
                                //               description: ""),
                                //         ))));
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
                      1.8,
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
                      2.0,
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
                      2.2,
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
