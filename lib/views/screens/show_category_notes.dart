import 'package:flutter/material.dart';
import 'package:my_flutter_project/views/widget/app_drawer.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/models/note_model.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';

class ShowCategoryNotes extends StatelessWidget {
  final String categoryName;
  const ShowCategoryNotes({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    List<NoteModel> notes = noteProvider.categoryNotes(categoryName);
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      drawer: AppDrawer(),
      body: notes.isEmpty
          ? CenterIfNotesEmpty(
              icon: Icons.label_outline,
              message: AppLocalizations.of(context)!.noCategoryNotes,
            )
          : NotesGridView(notes: notes),
    );
  }
}
