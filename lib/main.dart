import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:my_flutter_project/users_managment/create_acount.dart';
import 'package:my_flutter_project/note/create_new_note.dart';
// import 'package:my_flutter_project/login_page.dart';
import 'Navigation/app_drawer.dart';
import 'my_app_colors.dart';
import 'Navigation/navigation_bar_bottom.dart';

void main() {
  runApp(const MyApp());
}

class UsersInfo {
  static Map<String, Map<String, String>> usersInfo = {
    'admin': {'full_name': 'Admin', 'password': 'admin123'},
  };
}

class NotesList {
  static var listNotes = [
    {
      'title': "لماذا ننام",

      'body':
          "لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام لماذا ننام ",

      'date_create': '2025-12-18',
      'last_update': '2025-12-18',
    },
    {
      'title': "ذكريات الجامعة",
      'body':
          "ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ذكريات الجامعة ",
      'date_create': '2025-12-18',
      'last_update': '2025-12-18',
    },
    {
      'title': "ذكريات السكن",
      'body':
          "ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ذكريات السكن ",
      'date_create': '2025-12-18',
      'last_update': '2025-12-18',
    },
    {
      'title': "أسماء كتب رائعة",

      'body':
          "أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة أسماء كتب رائعة ",

      'date_create': '2025-12-18',
      'last_update': '2025-12-18',
    },
    {
      'title': "مواقف طريفة",

      'body':
          "مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة مواقف طريفة ",

      'date_create': '2025-12-18',
      'last_update': '2025-12-18',
    },
  ];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController mycontroller = TextEditingController();
  var sizeb1 = SizedBox(width: 20);
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColors.blueBase,
        actions: [
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                Color temp = MyAppColors.clrBaseAppColor;
                MyAppColors.clrBaseAppColor = MyAppColors.clrNegativeAppColor;
                MyAppColors.clrNegativeAppColor = temp;
                temp = MyAppColors.clrBackground;
                MyAppColors.clrBackground = MyAppColors.clrNegativeBackground;
                MyAppColors.clrNegativeBackground = temp;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        color: MyAppColors.clrBackground,
        padding: const EdgeInsets.all(8.0),
        child: makeListViewOfNotes(),
      ),

      bottomNavigationBar: NavigationBarBottom(),
    );
  }

  ListView makeListViewOfNotes() => ListView(
    children: [
      Container(
        decoration: BoxDecoration(
          color: MyAppColors.clrBaseAppColor,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8.0),

        child: TextField(
          controller: mycontroller,
          style: TextStyle(color: MyAppColors.clrNegativeAppColor),
          decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ElevatedButton(
          onPressed: () => addNote(),
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 20)),
            backgroundColor: WidgetStatePropertyAll(MyAppColors.blueBase),
          ),
          child: Text("Add Student", style: TextStyle(color: Colors.white)),
        ),
      ),
      for (int i = 0; i < NotesList.listNotes.length; i++)
        Card(
          color: MyAppColors.clrBaseAppColor,
          child: CreateNewNote(
            i: i,
            removeNote: removeNote,
            updateNote: updateNote,
            listNotes: NotesList.listNotes,
          ),
        ),
    ],
  );

  void removeNote(int i) {
    return setState(() {
      NotesList.listNotes.remove(NotesList.listNotes[i]);
    });
  }

  void updateNote(int i) {
    return setState(() {
      NotesList.listNotes[i]['title'] = mycontroller.text.isEmpty
          ? NotesList.listNotes[i]['title']!
          : mycontroller.text;
      mycontroller.text = "";
    });
  }

  void addNote() {
    return setState(() {
      if (mycontroller.text.isNotEmpty) {
        NotesList.listNotes.insert(NotesList.listNotes.length, {
          'title': mycontroller.text,
          'body': '',
          'date_create': DateTime.now().toString(),
          'last_update': DateTime.now().toString(),
        });
        mycontroller.clear();
      }
    });
  }
}
