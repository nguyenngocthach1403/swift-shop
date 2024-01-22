import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/profile_imformation.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final accountId = FirebaseAuth.instance.currentUser!.uid;
  Widget returnProfileScreen() {
    return AvatarProfile();
  }

  Widget returnProfileInfomation() {
    return ProfileInformation();
  }

  Future<List<Orders>> getAllOrder() async {
    QuerySnapshot docOrder =
        await FirebaseFirestore.instance.collection('orders').get();
    List<Orders> lstOrder = [];
    for (var i in docOrder.docs) {
      if (i['AccountId'] == accountId) {
        Orders newOrder = Orders(
            accountId: i['AccountId'],
            address: i['Address'],
            orderDate: i['OrderDate'],
            orderId: i.id,
            status: i['Status'],
            totalPrice: i['TotalPrice']);
        lstOrder.add(newOrder);
      }
    }
    return lstOrder;
  }

  List<Orders> order = [];
  @override
  void initState() {
    // TODO: implement initState
    getAllOrder().then((value) {
      setState(() {
        order = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height + 10,
                child: Column(
                  children: [
                    SizedBox(
                      height: 275,
                      child: Expanded(
                        child: returnProfileScreen(),
                      ),
                    ),
                    Expanded(
                      child: returnProfileInfomation(),
                    ),
                  ],
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Lịch sử đơn hàng",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            OrderList(
              orders: order,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(idx: 3),
    );
  }
}
