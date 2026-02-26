import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';
import '../../providers/managment_some_state.dart';
import '../widget/app_drawer.dart';

// ignore: must_be_immutable
class DeletedNotesScreen extends StatelessWidget {
  DeletedNotesScreen({super.key});
  TextEditingController textField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notesController = context.watch<NotesProvider>();
    final notes = notesController.deletedNotes;
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.deletedNoteAppBar),
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

      drawer: AppDrawer(currentScreen: AppRoutes.deletedNotesScreen),

      body: notes.isEmpty
          ? CenterIfNotesEmpty(
              icon: Icons.note_add_outlined,
              message: AppLocalizations.of(context)!.noDeletedNote,
            )
          : NotesGridView(notesStatus: "deleted"),
      floatingActionButton: HelperMethods.addNoteButton(
        context,
        status: "deleted",
      ),
    );
  }
}
