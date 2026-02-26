import 'package:flutter/material.dart';
import 'package:my_flutter_project/providers/auth_provider.dart';
import 'package:my_flutter_project/views/screens/active_notes_screen.dart';
import 'package:provider/provider.dart';
import 'views/screens/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return authProvider.isLoggedIn ? ActiveNoteScreen() : UserLoginScreen();
      },
    );
  }
}
