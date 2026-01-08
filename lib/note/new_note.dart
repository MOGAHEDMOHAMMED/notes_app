import 'package:flutter/material.dart';
import 'package:my_flutter_project/my_app_colors.dart';

class NewNote extends StatelessWidget {
  final String _noteTitle;
  // final String _noteBody;
  const NewNote(this._noteTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.abc),
      title: Text(
        _noteTitle,
        style: TextStyle(color: MyAppColors.clrNegativeAppColor, fontSize: 20),
      ),
    );
  }
}
