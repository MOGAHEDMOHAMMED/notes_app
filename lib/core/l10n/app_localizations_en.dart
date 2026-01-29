// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Notes';

  @override
  String get addNote => 'Add Note';

  @override
  String get editNote => 'Edit Note';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get titleHint => 'Title';

  @override
  String get contentHint => 'Write your note here...';

  @override
  String get loginGoogle => 'Sign in with Google';

  @override
  String get loginFailed => 'Login Failed';

  @override
  String get requiredField => 'This field is required';
}
