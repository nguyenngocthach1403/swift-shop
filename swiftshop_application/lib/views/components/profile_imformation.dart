// Profile_Info
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  late User _user;
  late String _accountId;
  late ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _accountId = _user.uid;
    _viewModel = ProfileViewModel(_accountId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _viewModel.getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          UserModel userModel = snapshot.data!;

          return Container(
            width: MediaQuery.of(context).size.width - 3,
            height: MediaQuery.of(context).size.height / 3 - 10,
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFE9E9E9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username : ${userModel.fullname}",
                              style: TextStyle(fontSize: 17)),
                          Text("Email : ${userModel.email}",
                              style: TextStyle(fontSize: 17)),
                          Text("Phone : ${userModel.phonenumber}",
                              style: TextStyle(fontSize: 17)),
                          Text("Address : ${userModel.address}",
                              style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.red, // Màu nền của nút
                //       ),
                //       child: const Row(
                //         children: [
                //           Text(
                //             "Log out ->]",
                //             style: TextStyle(color: Colors.white),
                //           )
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/",
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Màu nền của nút
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Log out ->]",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ], // Thịnh đã cập nhật sự kiện cho nút Logout
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text("Tổng tiền đã chi",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          height: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6088CA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/money.png",
                                height: 20,
                                width: 20,
                              ),
                              const Text("1.000.000đ",
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 5),
                    Column(
                      children: [
                        const Text("Tổng tháng này",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 120,
                          height: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6088CA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money_outlined),
                              Text("100.000đ", style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 5),
                    Column(
                      children: [
                        const Text("Tổng đơn ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 120,
                          height: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6088CA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/3d-cube.png",
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              const Text("10", style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
