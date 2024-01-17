import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationBarCustom extends StatelessWidget {
  BottomNavigationBarCustom({super.key, required this.idx});
  int idx;
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
    return BottomNavigationBar(
      currentIndex: idx,
      items: [
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
      ],
      onTap: (int indexOfItem) {
        if (idx != indexOfItem) {
          switch (indexOfItem) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(
                  context, '/homepage', (route) => false);
              break;
            case 1:
              Navigator.pushNamedAndRemoveUntil(
                  context, "/cartscreen", (route) => true);
              break;
            case 2:
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/searchscreen',
                (route) => false,
              );
              break;
            case 3:
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/profile',
                (route) => false,
              );
              break;
          }
        }
      },
    );
  }
}
