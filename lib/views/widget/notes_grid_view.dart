import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import 'package:my_flutter_project/views/screens/choose_note_Category.dart';
import 'package:provider/provider.dart';
import '../../models/note_model.dart';
import '../../providers/notes_provider.dart';
import '../../core/routes/app_routes.dart';
import '../../core/l10n/app_localizations.dart';

class NotesGridView extends StatelessWidget {
  final List<NoteModel> notes;
  const NotesGridView({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
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
            AppRoutes.noteDetails,
            arguments: {'note': note, 'isNewNote': false},
          );
        },
        onLongPress: () => _showOptionsBottomSheet(context, note),

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
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 207, 207),
                  borderRadius: BorderRadius.circular(2)
                ),
                child: Text(
                  note.categoryName != null ? note.categoryName.toString() : '',
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

  void _showOptionsBottomSheet(BuildContext context, NoteModel note) {
    final tr = AppLocalizations.of(context)!;
    final provider = context.read<NotesProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.archive_outlined, color: Colors.blue),
                title: Text(tr.moveToArchived),
                onTap: () {
                  provider.moveNote(note, 'archived');
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.copy, color: Colors.blue),
                title: Text(tr.duplicate),
                onTap: () {
                  provider.addNote(note.title, note.content);
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.label_outline, color: Colors.blue),
                title: Text(tr.category),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCategoryScreen(note: note),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(tr.moveToRecycleBin),
                onTap: () {
                  provider.moveNote(note, 'deleted'); //
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: Text(tr.shareNote),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
 void showNoteOptions(BuildContext context, NoteModel note) {
    final tr = AppLocalizations.of(context)!;
    final provider = context.read<NotesProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.archive_outlined, color: Colors.blue),
                title: Text(
                  note.status == 'archived'
                      ? tr.moveFromArchive
                      : tr.moveToArchived,
                ),
                onTap: () {
                  provider.moveNote(
                    note,
                    note.status == 'archived' ? 'active' : 'archived',
                  );
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.copy, color: Colors.blue),
                title: Text(tr.duplicate),
                onTap: () {
                  provider.addNote(note.title, note.content);
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.label_outline, color: Colors.blue),
                title: Text(tr.category),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCategoryScreen(note: note),
                    ),
                  );
                },
              ),
              !(note.status == 'deleted')
                  ? ListTile(
                      leading: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      title: Text(tr.moveToRecycleBin),
                      onTap: () {
                        provider.moveNote(note, 'deleted'); //
                        Navigator.pop(context);
                      },
                    )
                  : ListTile(
                      leading: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),

                      title: Text(tr.deleteForever),
                      onTap: () {
                        provider.deleteForever(note.id); //
                        Navigator.pop(context);
                      },
                    ),

              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: Text(tr.shareNote),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(tr.devlopment)));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


}
