import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationBarCustom extends StatefulWidget {
  BottomNavigationBarCustom({super.key, required this.idx});
  int idx;
  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 50,
    //   alignment: Alignment.bottomCenter,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       IconButton(
    //         icon: const Icon(Icons.home_max_outlined),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.shopping_bag),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.search),
    //         onPressed: () {},
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.person),
    //         onPressed: () {},
    //       ),
    //     ],
    //   ),
    // );
    return BottomNavigationBar(currentIndex: widget.idx, items: [
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/home.png",
            width: 25,
          ),
          label: ""),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/shopping-bag.png",
            width: 25,
          ),
          label: ""),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/search.png",
            width: 25,
          ),
          label: ""),
      BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/user.png",
            width: 25,
          ),
          label: "")
    ]);
  }
}
