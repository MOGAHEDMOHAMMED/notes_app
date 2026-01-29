import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/language_provider.dart';
// import 'package:get/get.dart';
import 'package:my_flutter_project/providers/notes_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ActiveNoteScreen extends StatelessWidget {
  ActiveNoteScreen({super.key});
  TextEditingController textField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.notes;
    return notes.isEmpty
        ? (notesProvider.notes.isEmpty)
              ? Center(child: Text("لا توجد ملاحظات"))
              : Center(
                  child: Text(
                    "لا توجد ملاحظات غير مؤرشفة, لقد قمت بارشفة كل الملاحظات من قبل ",
                  ),
                )
        : Consumer<LanguageProvider>(
            builder: (BuildContext context, LanguageProvider value, Widget? child) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  var currntNote = notes[index];

                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context) => NoteDetails(index)),
                        // );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currntNote.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                currntNote.content,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // context
                                    //   .read<NotesProvider>()
                                    //   .deleteNote(index);
                                  },
                                  icon: Icon(Icons.delete_forever_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // context.read<NotesProvider>().toggleArchive(
                                    //     context
                                    //         .read<NotesProvider>()
                                    //         .getNoteAsModel(index),
                                    //   );
                                  },
                                  icon: Icon(Icons.archive_outlined),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share_outlined),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // child: ListTile(
                    //   // leading: IconButton(
                    //   //   onPressed: () => context.read<NotesController>().deleteNote(index),
                    //   //   icon: Icon(Icons.delete_forever_outlined),
                    //   // ),
                    //   title: Text('${notes[index]['title']}'),
                    //   subtitle: Text(
                    //     (notes[index]['body']).toString().length > 150
                    //         ? '${(notes[index]['body']).toString().substring(0, 150)}...'
                    //         : '${notes[index]['body']}',
                    //   ),
                    //   titleAlignment: ListTileTitleAlignment.titleHeight,
                    // ),
                  );
                },
              );
            },
          );
  }
}
