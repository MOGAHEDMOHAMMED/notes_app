import 'package:flutter/material.dart';
import 'package:my_flutter_project/views/screens/active_notes_screen.dart';
import 'views/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLogin') ?? false;
  }

  static Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    isLoggedIn.value = true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthManager.isLoggedIn,
      builder: (context, isUserLoggedIn, child) {
        return isUserLoggedIn ? const ActiveNoteScreen() : UserLoginScreen();
      },
    );
  }
}
