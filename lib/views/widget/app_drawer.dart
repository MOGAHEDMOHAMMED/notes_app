import 'package:flutter/material.dart';
import 'package:my_flutter_project/views/screens/archived_notes_screen.dart';
import 'package:my_flutter_project/views/screens/settings_screen.dart';


// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  var sizeb1 = SizedBox(width: 20);
  @override
  Widget build(BuildContext context) {final theme = Theme.of(context); 
    final colors = theme.colorScheme;
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.4,
      backgroundColor: colors.surface,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 10),
        children: [
          SizedBox(height: 10),
          DrawerHeader(
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
                    color: colors.primary,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: colors.surface,
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
                      color: colors.surface,
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
            tileColor: colors.surface,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            iconColor: Colors.blue,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("الأرشيف"),
            leading: Icon(Icons.archive_outlined),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: colors.surface,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => ArchivedNotesScreen()));
            },
            iconColor: colors.primary,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("المهملات"),
            leading: Icon(Icons.delete_outline),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: colors.surface,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            iconColor: colors.primary,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("الأعدادت"),
            leading: Icon(Icons.settings_outlined),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: colors.surface,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            iconColor: colors.primary,
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text("المساعدة والملاحظة"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            tileColor: colors.surface,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            iconColor: colors.primary,
          ),
        ],
      ),
    );
  }
}
