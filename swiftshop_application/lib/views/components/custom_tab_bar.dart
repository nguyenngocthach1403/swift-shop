// TabCustom
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';

class TabCustom extends StatefulWidget {
  const TabCustom(
      {Key? key,
      required this.width,
      required this.lstTab,
      required this.onTabSelected})
      : super(key: key);
  final double width;
  final List<TabItem> lstTab;
  final Function(int) onTabSelected;

  @override
  State<TabCustom> createState() => _TabCustomState();
}

class _TabCustomState extends State<TabCustom> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    widget.lstTab[_selectedTab].active = true;
  }

  void onTapPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      for (int i = 0; i < widget.lstTab.length; i++) {
        if (widget.lstTab[i].active) widget.lstTab[i].active = false;
      }
      widget.lstTab[index].active = true;

      widget.onTabSelected(index);
    }
  }

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
              onTapPress(index);
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
