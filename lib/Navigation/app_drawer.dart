import 'package:flutter/material.dart';
import 'package:my_flutter_project/my_app_colors.dart';
import 'package:my_flutter_project/settings_page.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  var clrBaseBlack = const Color.fromARGB(255, 46, 48, 52);
  var clrBaseWhite1 = const Color.fromARGB(255, 224, 252, 254);
  var clrBaseWhite2 = const Color.fromARGB(255, 237, 231, 237);
  var sizeb1 = SizedBox(width: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.4,
      backgroundColor: MyAppColors.clrBaseAppColor,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 10),
        children: [
          SizedBox(height: 10),
          DrawerHeader(
            decoration: BoxDecoration(color: MyAppColors.clrBaseAppColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(width:-20),
                Text(
                  "Google Keep",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Tahoma",
                    color: clrBaseBlack,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: MyAppColors.clrBaseIconColor,
                    ),
                    Text(
                      "ملاحظات",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Tahoma",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: MyAppColors.clrBaseIconColor,
                    ),
                    Text(
                      "رسائل التذكير",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Tahoma",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("التصنيفات"),
            leading: Icon(Icons.label_outline),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: Colors.amber[100],
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            iconColor: Colors.blue,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("الأرشيف"),
            leading: Icon(Icons.archive_outlined),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: Colors.amber[100],
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            iconColor: Colors.blue,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("المهملات"),
            leading: Icon(Icons.delete_outline),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: Colors.amber[100],
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            iconColor: Colors.blue,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("الأعدادت"),
            leading: Icon(Icons.settings_outlined),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: Colors.amber[100],
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            iconColor: Colors.blue,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("المساعدة والملاحظة"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: Colors.amber[100],
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            iconColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
