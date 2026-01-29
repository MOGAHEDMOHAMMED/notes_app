// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مذكراتي';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get editNote => 'تعديل الملاحظة';

  @override
  String get delete => 'حذف';

  @override
  String get save => 'حفظ';

  @override
  String get titleHint => 'العنوان';

  @override
  String get contentHint => 'اكتب ملاحظتك هنا...';

  @override
  String get loginGoogle => 'تسجيل الدخول بجوجل';

  @override
  String get loginFailed => 'فشل تسجيل الدخول';

  @override
  String get requiredField => 'هذا الحقل مطلوب';
}
