import 'package:flutter/material.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/models/category_model.dart';
import 'package:my_flutter_project/views/widget/app_drawer.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/models/note_model.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/center_if_notes_empty.dart';
import 'package:my_flutter_project/views/widget/notes_grid_view.dart';

class ShowCategoryNotes extends StatelessWidget {
  final CategoryModel categoryModel;
  const ShowCategoryNotes({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context, listen: true);
    List<NoteModel> notes = noteProvider.categoryNotes(categoryModel.name);
    return Scaffold(
      appBar: AppBar(title: Text(categoryModel.name)),
      drawer: AppDrawer(currentScreen: AppRoutes.showCategoryNotes),
      body: notes.isEmpty
          ? CenterIfNotesEmpty(
              icon: Icons.label_outline,
              message: AppLocalizations.of(context)!.noCategoryNotes,
            )
          : NotesGridView(notesStatus: '', categroyNotes: notes),
      floatingActionButton: HelperMethods.addNoteButton(
        context,
        categoryModel: categoryModel,
      ),
    );
  }
}
