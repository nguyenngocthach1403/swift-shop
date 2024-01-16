import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/screens/edit_profile_user_screen.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({super.key});

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/ne.jpg"),
              const Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://www.w3schools.com/howto/img_avatar.png"),
                ),
              ),
              Positioned(
                bottom: -15,
                right: 115,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Center(
            child: Column(
              children: [
                Text(
                  "Ku Ton",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
        ]);
  }
}
