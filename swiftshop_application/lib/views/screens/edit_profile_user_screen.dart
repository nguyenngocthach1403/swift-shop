import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/Animation/animation.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:path/path.dart' as Path;

class ProfileSettingScreen extends StatefulWidget {
  final UserModel user;
  const ProfileSettingScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  TextEditingController? _fullname;
  TextEditingController? _address;
  TextEditingController? _phonenumber;
  final _formSignupKey = GlobalKey<FormState>();
  XFile? _imgage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    print(image!.path);
    if (image != null) {
      // selectedImage = File(image.path);
      // setState(() {});
      return await image.readAsBytes();
    }
  }

  selectedImage() async {
    XFile img = await getImage(ImageSource.gallery);
    setState(() {
      _imgage = img;
      uploadImageToStorage('images', img);
    });
  }

  // Future<void> uploadFileToFirebaseStorage(File data) async {
  //   try {
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     String fileName = "${DateTime.now()}.png";
  //     Reference storageReference = storage.ref().child(fileName);
  //     await storageReference.putFile(data);
  //     String downloadURL = await storageReference.getDownloadURL();

  //     print('File uploaded successfully. Download URL: $downloadURL');
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }
  Future<String> uploadImageToStorage(String childName, XFile file) async {
    Reference ref = _storage.ref();
    Reference referenceDirImage = ref.child(childName);
    Reference referenceImage = referenceDirImage.child(file.path);
    referenceImage.putFile(File(file!.path));
    String url = await referenceImage.getDownloadURL();
    return url;
    // UploadTask uploadTask = ref.putData(file);
    // TaskSnapshot snapshot = await uploadTask;
    // String downloadUrl = await snapshot.ref.getDownloadURL();
    // return downloadUrl;
  }

  @override
  void initState() {
    _fullname = TextEditingController(text: widget.user.fullname);
    // _email = TextEditingController(text: widget.user.email);
    _address = TextEditingController(text: widget.user.address);
    _phonenumber = TextEditingController(text: widget.user.phonenumber);
    // _password = TextEditingController(text: widget.user.password);
    super.initState();
  }

  @override
  void dispose() {
    _fullname!.dispose();
    // _email!.dispose();
    _address!.dispose();
    _phonenumber!.dispose();
    // _password!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(96, 136, 202, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(96, 136, 202, 1),
              ),
              width: 430,
              child: Stack(alignment: Alignment.center, children: [
                InkWell(
                    onTap: () {
                      selectedImage();
                    },
                    child: _imgage != null
                        ? CircleAvatar(
                            radius: 64,
                            // backgroundImage: XFileImage(_imgage!),
                          )
                        : const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                "https://www.w3schools.com/howto/img_avatar.png"),
                          )),
              ]),
            ),
          ),
          Expanded(
            flex: 4,
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
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // FadeAnimation(
                      //   1.4,
                      //   TextFormField(
                      //     controller: _email,
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please enter Email';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       prefixIcon: Icon(Icons.email_outlined),
                      //       label: const Text('Email'),
                      //       hintText: 'Enter your Email',
                      //       hintStyle: const TextStyle(
                      //         color: Colors.black26,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.white, // Default border color
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.white, // Default border color
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 25.0,
                      // ),
                      FadeAnimation(
                        1.6,
                        TextFormField(
                          controller: _address,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email_outlined),
                            label: const Text('Address'),
                            hintText: 'Enter your Address',
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
                        1.8,
                        TextFormField(
                          controller: _phonenumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Phonenumber';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.email_outlined),
                            label: const Text('Phonenumer'),
                            hintText: 'Enter your Phonenumber',
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
                      // const SizedBox(
                      //   height: 25.0,
                      // ),
                      // FadeAnimation(
                      //   2.0,
                      //   TextFormField(
                      //     controller: _password,
                      //     obscureText: true,
                      //     obscuringCharacter: '*',
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Please enter Password';
                      //       }
                      //       return null;
                      //     },
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       prefixIcon: Icon(Icons.key_sharp),
                      //       label: const Text('Password'),
                      //       hintText: 'Enter your Password',
                      //       hintStyle: const TextStyle(
                      //         color: Colors.black26,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.black12, // Default border color
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //           color: Colors.black12, // Default border color
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      FadeAnimation(
                        2.2,
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                            ),
                            onPressed: () async {
                              if (_formSignupKey.currentState!.validate()) {
                                // String url = await uploadFileToFirebaseStorage(_imgage!);
                                UserData.updateData(UserModel(
                                    accountId: widget.user.accountId,
                                    fullname: _fullname!.text,
                                    // email: _email!.text,
                                    address: _address!.text,
                                    phonenumber: _phonenumber!.text,
                                    // password: _password!.text,
                                    avatar: widget.user.avatar));
                                Navigator.pushNamed(context, '/profile');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Update Account Success'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
