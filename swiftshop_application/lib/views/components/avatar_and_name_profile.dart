import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/views/screens/edit_profile_user_screen.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({super.key});

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  String _name = '';
  String _url = '';

  @override
  void initState() {
    super.initState();
    setUserName();
  }

  Future<void> setUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('accounts')
          .doc(user!.uid)
          .get();
      if (userDoc.exists) {
        String fullname = userDoc['fullname'];
        String avatar = userDoc['avatar'];
        setState(() {
          _name = fullname;
          _url = avatar;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // children: [
        //   Stack(
        //     clipBehavior: Clip.none,
        //     alignment: Alignment.center,
        //     children: [
        //       Image.asset("assets/images/ne.jpg"),
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                child: Image.asset(
                  "assets/images/ne.jpg",
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ), // Thịnh đã đụng dô phần này Ok
              Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _url.isEmpty
                      ? NetworkImage(
                          "https://www.w3schools.com/howto/img_avatar.png")
                      : NetworkImage(_url),
                ),
              ),
              Positioned(
                bottom: -15,
                right: 115,
                child: IconButton(
                  onPressed: () async {
                    if (user != null) {
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('accounts')
                          .doc(user!.uid)
                          .get();
                      if (userDoc.exists) {
                        String accountId = userDoc['accountId'];
                        String address = userDoc['address'];
                        String avatar = userDoc['avatar'];
                        String fullname = userDoc['fullname'];
                        String phonenumber = userDoc['phonenumber'];
                        String position = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileSettingScreen(
                              user: UserModel(
                                  accountId: accountId,
                                  address: address,
                                  avatar: avatar,
                                  fullname: fullname,
                                  phonenumber: phonenumber,
                                  position: position),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  _name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
        ]);
  }
}
