import 'package:flutter/material.dart';
import 'package:my_flutter_project/main.dart';
import 'package:my_flutter_project/views/screens/active_notes_screen.dart';
import 'package:my_flutter_project/views/screens/archived_notes_screen.dart';
import 'package:my_flutter_project/views/screens/auth/create_user_screen.dart';
import 'package:my_flutter_project/views/screens/auth/login_screen.dart';
import 'package:my_flutter_project/views/screens/settings_screen.dart';
import 'app_routes.dart';
// استورد شاشاتك هنا

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => MyHomePage());

      case AppRoutes.archivedNotes:
        return MaterialPageRoute(builder: (_) => ArchivedNotesScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.activeNotesScreen:
        return MaterialPageRoute(builder: (_) => ActiveNoteScreen());

      case AppRoutes.createUser:
        return MaterialPageRoute(builder: (_) => CreateUserScreen());

      case AppRoutes.loginUser:
        return MaterialPageRoute(builder: (_) => UserLoginScreen());
      //  case AppRoutes.noteDetails:
      //     if (args is int) {
      //       return MaterialPageRoute(
      //         builder: (_) => NoteDetails(args==null?),
      //       );
      //     }
      // مثال: إذا أردت فتح ملاحظة للتعديل وتمرير بيانات الملاحظة
      /*
      case AppRoutes.noteDetails:
        if (args is NoteModel) {
           return MaterialPageRoute(builder: (_) => NoteDetailScreen(note: args));
        }
        return _errorRoute();
      */
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('ERROR: Route not found!')),
        );
      },
    );
  }
}
