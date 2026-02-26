import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:provider/provider.dart';
import '../../models/note_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/l10n/app_localizations.dart';

// ignore: must_be_immutable
class NotesGridView extends StatelessWidget {
  final String notesStatus;
  List<NoteModel>? categroyNotes;
  NotesGridView({super.key, required this.notesStatus, this.categroyNotes});

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final List<NoteModel> notes;
    if (categroyNotes == null) {
      notes = notesStatus == "active"
          ? notesProvider.activeNotes
          : notesStatus == "deleted"
          ? notesProvider.deletedNotes
          : notesProvider.archivedNotes;
    } else {
      notes = categroyNotes!;
    }
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.watch<ManagmentSomeState>().isGrid ? 2 : 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: context.watch<ManagmentSomeState>().isGrid
            ? 0.8
            : 1.3,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return _buildNoteCard(context, note);
      },
    );
  }

  Widget _buildNoteCard(BuildContext context, NoteModel note) {
    final tr = AppLocalizations.of(context)!;
    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.noteDetailsScreen,
            arguments: {'note': note, 'isNewNote': false},
          );
        },
        onLongPress: () => HelperMethods.showNoteOptions(context, note),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Divider(thickness: 0.5),
              Expanded(
                child: Text(
                  note.content,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ),

              const SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 207, 207),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  note.categoryName ?? '',
                  style: TextStyle(
                    // backgroundColor: const Color.fromARGB(255, 215, 207, 207),
                    fontSize: 12,
                    color: const Color.fromARGB(255, 38, 24, 24),
                  ),
                ),
              ),
              Text(
                "${tr.lastUpdate} :${note.lastUpdate!.year}/${note.lastUpdate!.month}/${note.lastUpdate!.day}",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
