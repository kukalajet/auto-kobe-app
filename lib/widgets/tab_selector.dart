import 'package:auto_kobe/models/app_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_kobe/keys.dart';

// ignore: todo
// TODO: Change icons.
class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      type: BottomNavigationBarType.fixed,
      currentIndex: AppTab.values.indexOf(activeTab),
      selectedLabelStyle: TextStyle(color: Color.fromRGBO(95, 135, 231, 1)),
      selectedItemColor: Color.fromRGBO(95, 135, 231, 1),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.local_fire_department,
            key: ArchSampleKeys.feedTab,
          ),
          label: "Feed",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.face,
            key: ArchSampleKeys.profileTab,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
