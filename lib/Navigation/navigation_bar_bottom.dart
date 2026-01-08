import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/settings_page.dart';

import '../my_app_colors.dart';

class NavigationBarBottom extends StatelessWidget {
  const NavigationBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: MyAppColors.blueBase,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            focusColor: Colors.amber,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "wellcome to my flutter project",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // color: Colors.amber[100],
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.front_hand_outlined,
              color: MyAppColors.clrNegativeAppColor,
              size: 30,
            ),
          ),
          label: "Wellcome",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
            icon: Icon(
              Icons.menu_book_outlined,
              color: MyAppColors.clrNegativeAppColor,
              size: 30,
            ),
          ),
          label: "الاعدادات",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            icon: Icon(
              Icons.home,
              color: MyAppColors.clrNegativeAppColor,
              size: 30,
            ),
          ),
          label: "الرئيسية",
        ),
      ],
    );
  }
}
