// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/models/note_model.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';

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
            showSnackbarWithOutActions(context, tr.ignoreNotes);
          } else {
            noteProvider.addNote(title, content);
            showSnackbarWithOutActions(context, tr.save);
          }
        } else {
          if (widget.note!.title != title || widget.note!.content != content) {
            noteProvider.updateNote(widget.note!, title, content);
            showSnackbarWithOutActions(context, tr.save);
          }
        }
        if (context.mounted) Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNewNote ? tr.newNote : tr.editNote),
          actions: [
            IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed: () async {
                if (widget.note!.status == "archived") {
                  await context.read<NotesProvider>().moveNote(
                    widget.note!,
                    "active",
                  );
                  Navigator.pop(context);
                  showSnackbarWithOutActions(context, tr.unArchivedSuccess);
                } else {
                  await context.read<NotesProvider>().moveNote(
                    widget.note!,
                    "archived",
                  );
                  Navigator.pop(context);
                  showSnackbarWithOutActions(context, tr.archivedSuccess);
                }

                if (context.mounted) {
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
                if (widget.note!.status == "deleted") {
                  await context.read<NotesProvider>().deleteForever(
                    widget.note!.id,
                  );
                  Navigator.pop(context);
                  showSnackbarWithOutActions(context, tr.deleteForeverSuccess);
                } else {
                  await context.read<NotesProvider>().moveNote(
                    widget.note!,
                    'deleted',
                  );
                  Navigator.pop(context);
                  showSnackbarWithOutActions(context, tr.deletedSuccess);
                }

              },
            ),
            const SizedBox(width: 8),
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
                        onPressed: () => HelperMethods.showNoteOptions(
                          context,
                          widget.note!,
                        ),
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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSnackbarWithOutActions(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
