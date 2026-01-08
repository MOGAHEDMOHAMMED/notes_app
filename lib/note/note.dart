import 'package:flutter/material.dart';
import 'package:my_flutter_project/Navigation/app_drawer.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/my_app_colors.dart';

// ignore: must_be_immutable
class Note extends StatelessWidget {
  final String noteHeader;
  final int i;
  final String noteBody;
  final String noteDateCreate;
  final String noteLastUpdate;
  List<Map<String, String>> listNotes;
  Note(
    this.noteHeader,
    this.i,
    this.noteBody,
    this.noteDateCreate,
    this.noteLastUpdate,
    this.listNotes, {
    super.key,
  });
  TextEditingController mycontroller = TextEditingController();
  String changes = '';
  String getChanges() {
    changes = mycontroller.text;
    return changes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            noteHeader,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
        ),
        drawer: AppDrawer(),
        body: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          width: double.infinity,
          height: double.infinity,
          color: MyAppColors.clrBackground,
          child: SingleChildScrollView(
            child: TextField(
              style: TextStyle(
                color: MyAppColors.clrNegativeAppColor,
                fontSize: 18,
              ),
              controller: mycontroller = TextEditingController(text: noteBody),
              maxLines: null,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                filled: true,
                fillColor: MyAppColors.clrBackground,
                // border: OutlineInputBorder(
                //   borderSide: BorderSide(width: 10, color: MyAppColors.blueBase),
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NotesList.listNotes[i]['body'] = getChanges();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          backgroundColor: MyAppColors.blueBase,
          child: Icon(Icons.save_alt_outlined, color: Colors.white),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyAppColors.clrBaseAppColor,
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
                          color: Colors.amber[100],
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
              icon: Icon(
                Icons.menu_book_outlined,
                color: MyAppColors.clrNegativeAppColor,
                size: 30,
              ),
              label: "Books",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  NotesList.listNotes[i]['body'] = getChanges();
                  Navigator.pushReplacement(
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
              label: "Home",
            ),
          ],
        ),
      ),
    );
  }
}
