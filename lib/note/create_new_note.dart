import 'package:flutter/material.dart';
import 'package:my_flutter_project/my_app_colors.dart';
import 'package:my_flutter_project/note/note.dart';

class CreateNewNote extends StatelessWidget {
  final int i;
  final Function removeNote;
  final Function updateNote;
  final List<Map<String, String>> listNotes;

  const CreateNewNote({
    super.key,
    required this.i,
    required this.removeNote,
    required this.updateNote,
    required this.listNotes,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Note(
              listNotes[i]['title']!,
              i,
              listNotes[i]['body']!,
              listNotes[i]['date_create']!,
              listNotes[i]['last_update']!,
              listNotes,
            ),
          ),
        );
      },
      leading: IconButton(
        onPressed: () => removeNote(i),
        icon: Icon(
          Icons.delete_forever_outlined,
          size: 30,
          color: MyAppColors.clrBaseIconColor,
        ),
      ),
      title: Text(
        listNotes[i]['title']!,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        onPressed: () => updateNote(i),
        icon: Icon(Icons.edit, color: MyAppColors.clrBaseIconColor),
      ),
    );
  }
}
