import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/Animation/animation.dart';

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
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _imgage;

  Future<File?> getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    print(image?.path);
    if (image != null) {
      return File(image.path);
    } else {
      print('No Images Selected');
      return null;
    }
  }

  selectedImage() async {
    File? img = await getImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _imgage = img;
        // uploadFileToFirebaseStorage(_imgage);
      });
    }
  }

  Future<String> uploadFileToFirebaseStorage(File? file) async {
    String url = '';
    if (file == null) {
      print('No image selected.');
      return '';
    }
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = "${DateTime.now()}.png";
      Reference storageReference = storage.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');
      url = downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
    }
    return url;
  }

  @override
  void initState() {
    _fullname = TextEditingController(text: widget.user.fullname);
    _address = TextEditingController(text: widget.user.address);
    _phonenumber = TextEditingController(text: widget.user.phonenumber);
    super.initState();
  }

  @override
  void dispose() {
    _fullname!.dispose();
    _address!.dispose();
    _phonenumber!.dispose();
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
                            backgroundImage: FileImage(_imgage!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: widget.user.avatar!.isEmpty
                                ? const NetworkImage(
                                    "https://www.w3schools.com/howto/img_avatar.png")
                                : NetworkImage(widget.user.avatar!),
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
                                String _avatar =
                                    await uploadFileToFirebaseStorage(_imgage);
                                UserData.updateData(
                                  UserModel(
                                    accountId: widget.user.accountId,
                                    password: widget.user.password,
                                    position: widget.user.position,
                                    fullname: _fullname!.text,
                                    address: _address!.text,
                                    phonenumber: _phonenumber!.text,
                                    avatar: _avatar,
                                  ),
                                );
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
