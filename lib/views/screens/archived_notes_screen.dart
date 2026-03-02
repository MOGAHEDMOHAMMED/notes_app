import 'package:flutter/material.dart';
import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
// import 'package:get/get.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_state_provider.dart';
import '../widget/app_drawer.dart';

// ignore: must_be_immutable
class ArchivedNotesScreen extends StatelessWidget {
  const ArchivedNotesScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.archivedNotesAppBar),
        actions: [
          Selector<UIStateProvider, bool>(
            selector: (context, UIStateProvider state) => state.isGrid,
            builder: (context, isGrid, child) => IconButton(
              onPressed: () {
                if (isGrid) {
                  context.read<UIStateProvider>().toggleGrid();
                } else {
                  context.read<UIStateProvider>().toggleGrid();
                }
              },
              icon: Icon(isGrid ? Icons.view_agenda_outlined : Icons.grid_view),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),

      drawer: AppDrawer(currentScreen: AppRoutes.archivedNotesScreen),

      body: Consumer<NotesProvider>(
        builder: (context, notesProv, child) => notesProv.archivedNotes.isEmpty
            ? CenterIfNotesEmpty(
                icon: Icons.note_add_outlined,
                message: AppLocalizations.of(context)!.noArchivedNotes,
              )
            : NotesGridView(notes: notesProv.archivedNotes),
      ),
      floatingActionButton: HelperMethods.addNoteButton(
        context,
        status: "archived",
      ),
    );
  }
}
