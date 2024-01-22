// TabCustom
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';

class TabCustom extends StatefulWidget {
  const TabCustom({
    Key? key,
    required this.width,
    required this.lstTab,
    required this.selectedTab,
    required this.onTabSelected,
  }) : super(key: key);
  final double width;
  final int selectedTab;
  final List<TabItem> lstTab;
  final Function(int) onTabSelected;

  @override
  State<TabCustom> createState() => _TabCustomState();
}

class _TabCustomState extends State<TabCustom> {
  @override
  void initState() {
    super.initState();
    widget.lstTab[widget.selectedTab].active = true;
  }

  int returnIdexTab(int index) => index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width - 20 - 20,
      height: 30,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.lstTab.length,
        itemBuilder: (context, index) {
          TabItem btn = widget.lstTab[index];
          return GestureDetector(
            onTap: () {
              widget.onTabSelected(index);
            },
            child: Container(
              width: (widget.width - 20 - 20) / 4,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: btn.active
                    ? const Color.fromRGBO(54, 84, 134, 1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                btn.title,
                style: TextStyle(
                  fontSize: 12,
                  color: btn.active ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
