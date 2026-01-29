// import 'package:flutter/material.dart';
// import 'package:my_flutter_project/main.dart';
// import 'package:my_flutter_project/providers/notes_provider.dart';
// import 'package:my_flutter_project/views/widget/app_drawer.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class NoteDetails extends StatelessWidget {
//   final int i;
//   NoteDetails(this.i, {super.key});
//   TextEditingController mycontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChangeNotifierProvider(
//         create: (context) => NotesProvider(),
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               Provider.of<NotesProvider>(context).getNote(i)['title']!,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true,
//           ),
//           drawer: AppDrawer(),
//           body: Container(
//             margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
//             width: double.infinity,
//             height: double.infinity,
//             color: colors.surface,
//             child: SingleChildScrollView(
//               child: TextField(
//                 style: TextStyle(color: colors.primary, fontSize: 18),
//                 controller: mycontroller = TextEditingController(
//                   text: context.read<NotesProvider>().getNote(i)['body']!,
//                 ),
//                 maxLines: null,
//                 textDirection: TextDirection.rtl,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: colors.surface,
//                   // border: OutlineInputBorder(
//                   //   borderSide: BorderSide(width: 10, color: MyAppColors.blueBase),
//                   //   borderRadius: BorderRadius.circular(10),
//                   // ),
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               Provider.of<NotesProvider>(
//                 context,
//                 listen: false,
//               ).updateNoteBodyAndTitle(
//                 i,
//                 context.read<NotesProvider>().getNote(i)['title']!,
//                 mycontroller.text,
//               );
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => MyHomePage()),
//               );
//             },
//             child: Icon(Icons.save_alt_outlined, color: Colors.white),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: [
//               BottomNavigationBarItem(
//                 icon: IconButton(
//                   focusColor: Colors.amber,
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           "wellcome to my flutter project",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: colors.onSurface,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.front_hand_outlined,
//                     color: colors.primary,
//                     size: 30,
//                   ),
//                 ),
//                 label: "Wellcome",
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.menu_book_outlined,
//                   color: colors.primary,
//                   size: 30,
//                 ),
//                 label: "Books",
//               ),
//               BottomNavigationBarItem(
//                 icon: IconButton(
//                   onPressed: () {
//                     Provider.of<NotesProvider>(
//                       context,
//                       listen: false,
//                     ).updateNoteBodyAndTitle(
//                       i,
//                       context.read<NotesProvider>().getNote(i)['title']!,
//                       mycontroller.text,
//                     );
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => MyHomePage()),
//                     );
//                   },
//                   icon: Icon(Icons.home, color: colors.primary, size: 30),
//                 ),
//                 label: "Home",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
