import 'package:flutter/material.dart';
import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
// import 'package:get/get.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';
import 'package:provider/provider.dart';

import '../../providers/managment_some_state.dart';
import '../widget/app_drawer.dart';

// ignore: must_be_immutable
class ArchivedNotesScreen extends StatelessWidget {
  ArchivedNotesScreen({super.key});
  TextEditingController textField = TextEditingController();
  int grid = 2;
  @override
  Widget build(BuildContext context) {
    final notesprovider = context.watch<NotesProvider>();
    final notes = notesprovider.archivedNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.archivedNotesAppBar),
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

      drawer: AppDrawer(currentScreen: AppRoutes.archivedNotesScreen),

      body: notes.isEmpty
          ? CenterIfNotesEmpty(
              icon: Icons.note_add_outlined,
              message: AppLocalizations.of(context)!.noArchivedNotes,
            )
          : NotesGridView(notesStatus: "archived"),
      floatingActionButton: HelperMethods.addNoteButton(context,status: "archived"),
    );
  }
}
