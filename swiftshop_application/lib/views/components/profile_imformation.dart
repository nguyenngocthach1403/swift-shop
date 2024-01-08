import 'package:flutter/material.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width - 3,
        height: MediaQuery.of(context).size.height / 3 - 10,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username : ", style: TextStyle(fontSize: 15)),
                    Text("   Email : ", style: TextStyle(fontSize: 15)),
                    Text("   Phone : ", style: TextStyle(fontSize: 15)),
                    Text(" Address : ", style: TextStyle(fontSize: 15)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Màu nền của nút
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Log out ->]",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Tổng tiền đã chi",
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
                        children: [
                          Image.asset(
                            "assets/icons/money.png",
                            height: 20,
                            width: 20,
                          ),
                          Text("1.000.000đ", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(width: 5),
                Column(
                  children: [
                    Text("Tổng tháng này",
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
                        children: [
                          Icon(Icons.attach_money_outlined),
                          Text("100.000đ", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(width: 5),
                Column(
                  children: [
                    Text("Tổng đơn ",
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
                        children: [
                          Image.asset(
                            "assets/icons/3d-cube.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          Text("10", style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
