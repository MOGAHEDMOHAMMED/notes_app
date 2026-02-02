import 'package:flutter/material.dart';
import 'package:my_flutter_project/auth_wrapper.dart';
import 'package:my_flutter_project/views/screens/active_notes_screen.dart';
import 'package:my_flutter_project/views/screens/archived_notes_screen.dart';
import 'package:my_flutter_project/views/screens/auth/create_user_screen.dart';
import 'package:my_flutter_project/views/screens/auth/login_screen.dart';
import 'package:my_flutter_project/views/screens/deleted_notes_secreen.dart';
import 'package:my_flutter_project/views/screens/edit_categories_screen.dart';
import 'package:my_flutter_project/views/screens/note_details.dart';
import 'package:my_flutter_project/views/screens/settings_screen.dart';
import '../../views/screens/about_app_screen.dart';
import '../../views/screens/waiting_screen.dart';
import 'app_routes.dart';
// استورد شاشاتك هنا

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.archivedNotes:
        return MaterialPageRoute(builder: (_) => ArchivedNotesScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.deletedNotesScreen:
        return MaterialPageRoute(builder: (_) => DeletedNotesScreen());

      case AppRoutes.activeNotesScreen:
        return MaterialPageRoute(builder: (_) => ActiveNoteScreen());

      case AppRoutes.createUser:
        return MaterialPageRoute(builder: (_) => CreateUserScreen());

      case AppRoutes.loginUser:
        return MaterialPageRoute(builder: (_) => UserLoginScreen());

      case AppRoutes.waitingScreen:
        return MaterialPageRoute(builder: (_) => WaitingScreen());

      case AppRoutes.authWrapper:
        return MaterialPageRoute(builder: (_) => AuthWrapper());

      case AppRoutes.editCategoriesScreen:
        return MaterialPageRoute(builder: (_) => EditCategoriesScreen());

      case AppRoutes.aboutAppScreen:
        return MaterialPageRoute(builder: (_) => AboutAppScreen());

      case AppRoutes.noteDetails:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) =>
                NoteDetails(note: args['note'], isNewNote: args['isNewNote']),
          );
        }
        return _errorRoute();

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
