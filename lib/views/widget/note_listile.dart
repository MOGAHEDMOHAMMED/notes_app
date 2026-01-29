import 'package:flutter/material.dart';

class NewNote extends StatelessWidget {
  final String _noteTitle;
  // final String _noteBody;
  const NewNote(this._noteTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return ListTile(
      trailing: Icon(Icons.abc),
      title: Text(
        _noteTitle,
        style: TextStyle(color: colors.primary, fontSize: 20),
      ),
    );
  }
}
