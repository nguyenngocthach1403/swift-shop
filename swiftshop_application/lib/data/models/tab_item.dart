class TabItem {
  TabItem({this.title = "", this.active = false});
  String title;
  bool active;

  static List<TabItem> lstTab =
      List.filled(0, TabItem(title: ""), growable: true);
}
