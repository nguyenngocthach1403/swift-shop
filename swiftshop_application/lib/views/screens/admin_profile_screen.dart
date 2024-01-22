import 'package:flutter/material.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/product_list.dart';
import 'package:swiftshop_application/views/components/profile_imformation.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final AdminProfileViewModel _viewModel = AdminProfileViewModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _viewModel.fetchDataFromFirestore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AvatarProfile(),
            const ProfileInformation(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                children: const [
                  Text("Danh sách sản phẩm", style: TextStyle(fontSize: 25)),
                ],
              ),
            ),

            // Sử dụng FutureBuilder để chờ khi dữ liệu từ Firestore được load
            FutureBuilder(
              future: _viewModel.fetchDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return ProductList(viewModel: _viewModel);
                }
              },
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                children: const [
                  Text("Danh sách hóa đơn", style: TextStyle(fontSize: 25)),
                ],
              ),
            ),
            OrderList(),
          ],
        ),
      ),
    );
  }
}
