import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import 'package:my_flutter_project/views/widget/app_drawer.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';


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
      drawer: AppDrawer(
        currentScreen: ModalRoute.of(context)?.settings.name ?? '',
      ),
      body: noNotes
          ? CenterIfNotesEmpty(icon: Icons.edit_note, message: tr.noActiveNotes)
          : NotesGridView(notesStatus: "active"),
      floatingActionButton: HelperMethods.addNoteButton(context),
    );
  }
}
