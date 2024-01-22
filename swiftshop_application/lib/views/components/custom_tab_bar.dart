import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';

class TabCustom extends StatefulWidget {
  const TabCustom({
    Key? key,
    required this.width,
    required this.lstTab,
    required this.onTabSelected,
  }) : super(key: key);

  final double width;
  final List<TabItem> lstTab;
  final Function(TabItem) onTabSelected;

  @override
  State<TabCustom> createState() => _TabCustomState();
}

class _TabCustomState extends State<TabCustom> {
  late TabItem _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.lstTab[0];
  }

  void onTapPress(TabItem tab) {
    if (_selectedTab != tab) {
      setState(() {
        _selectedTab = tab;
      });

      widget.onTabSelected(tab);
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
          TabItem tab = widget.lstTab[index];
          return GestureDetector(
            onTap: () {
              onTapPress(tab);
            },
            child: Container(
              width: (widget.width - 20 - 20) / 4,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tab == _selectedTab
                    ? const Color.fromRGBO(54, 84, 134, 1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                tab.title,
                style: TextStyle(
                  fontSize: 12,
                  color: tab == _selectedTab ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
