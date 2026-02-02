import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/models/note_model.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';

import 'choose_note_Category.dart';

class NoteDetails extends StatefulWidget {
  final NoteModel? note;
  final bool isNewNote;

  const NoteDetails({super.key, this.note, this.isNewNote = false});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? "");
    contentController = TextEditingController(text: widget.note?.content ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    final tr = AppLocalizations.of(context)!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final title = titleController.text.trim();
        final content = contentController.text.trim();

        if (widget.isNewNote) {
          if (title.isEmpty && content.isEmpty) {
            showSnackBar(context, tr.ignoreNotes);
          } else {
            noteProvider.addNote(title, content);
            showSnackBar(context, tr.save);
          }
        } else {
          if (widget.note!.title != title || widget.note!.content != content) {
            noteProvider.updateNote(widget.note!, title, content);
            showSnackBar(context, tr.save);
          }
        }
        if (context.mounted) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewNote ? tr.newNote : tr.editNote),
          actions: [
            if (!widget.isNewNote) ...[
              IconButton(
                icon: const Icon(Icons.archive_outlined),
                onPressed: () async {
                  await context.read<NotesProvider>().moveNote(
                    widget.note!,
                    'archived',
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(tr.archivedSuccess)));
                  }
                },
              ),

              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.redAccent.shade100,
                onPressed: () async {
                  await context.read<NotesProvider>().moveNote(
                    widget.note!,
                    'deleted',
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(tr.deletedSuccess)));
                  }
                },
              ),

              const SizedBox(width: 8),
            ],
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: tr.titleHint,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              const Divider(),
              Expanded(
                child: TextField(
                  controller: contentController,
                  style: const TextStyle(fontSize: 18),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: tr.contentHint,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: BottomNavigationBar(
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.color_lens_outlined),
                      label: "m ",
                    ),
                    BottomNavigationBarItem(
                      icon: IconButton(
                        onPressed: () => showNoteOptions(context, widget.note!),
                        icon: const Icon(Icons.more_vert),
                      ),
                      label: "m ",
                    ),
                  ],
                  onTap: (index) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
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
