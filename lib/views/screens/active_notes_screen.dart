import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import 'package:my_flutter_project/views/widget/app_drawer.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';

import '../../models/note_model.dart';

class ActiveNoteScreen extends StatelessWidget {
  const ActiveNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.activeNotes;
    final tr = AppLocalizations.of(context)!;
    bool noNotes = notes.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.appTitle),
        actions: [
          IconButton(
            onPressed: () {
              if (context.read<ManagmentSomeState>().isGrid) {
                context.read<ManagmentSomeState>().toggleGrid();
              } else {
                context.read<ManagmentSomeState>().toggleGrid();
              }
            },
            icon: Icon(
              context.watch<ManagmentSomeState>().isGrid
                  ? Icons.view_agenda_outlined
                  : Icons.grid_view,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: AppDrawer(),
      body: noNotes
          ? CenterIfNotesEmpty(icon: Icons.edit_note, message: tr.noActiveNotes)
          : NotesGridView(notes: notes),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          NoteModel? emptyNote = notesProvider.emptyNote();
          Navigator.pushNamed(
            context,
            AppRoutes.noteDetails,
            arguments: {'note': emptyNote, 'isNewNote': true},
          );
        },
      ),
    );
  }
}
