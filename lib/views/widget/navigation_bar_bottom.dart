import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/views/screens/settings_screen.dart';


class NavigationBarBottom extends StatelessWidget {
  const NavigationBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final colors = theme.colorScheme;
    return BottomNavigationBar(
      backgroundColor: colors.primary,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            focusColor: colors.surface,
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
              color: colors.surface,
              size: 30,
            ),
          ),
          label: "Wellcome",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            ),
            icon: Icon(
              Icons.menu_book_outlined,
              color: colors.surface,
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
              color: colors.surface,
              size: 30,
            ),
          ),
          label: "الرئيسية",
        ),
      ],
    );
  }
}
