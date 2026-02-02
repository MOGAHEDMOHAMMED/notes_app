import 'package:flutter/material.dart';
import 'package:my_flutter_project/auth_wrapper.dart';
import 'package:my_flutter_project/providers/language_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import '../../../providers/auth_provider.dart';

class UserLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final tr = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final passwordVisibilityProvider = Provider.of<ManagmentSomeState>(
      context,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                tr.loginTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_note_rounded,
                        size: 80,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: emailController,
                    label: tr.emailLabel,
                    icon: Icons.email,
                    theme: theme,
                    isObscured: passwordVisibilityProvider.currentVisibility(),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordController,
                    label: tr.passwordLabel,
                    icon: passwordVisibilityProvider.currentVisibility()
                        ? Icons.visibility_off
                        : Icons.visibility,
                    isPassword: true,
                    theme: theme,
                    onIconPressed: () {
                      passwordVisibilityProvider.toggleVisibility();
                    },
                    isObscured: passwordVisibilityProvider.currentVisibility(),
                  ),
                  const SizedBox(height: 40),
                  if (authProvider.isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        String? error = await authProvider.signIn(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (error != null) {
                          // ignore: use_build_context_synchronously
                          _showErrorDialog(context, error);
                        } else {
                          AuthManager.login();
                        }
                      },
                      child: Text(
                        tr.loginButton,
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.createUser);
                    },
                    child: Text(
                      tr.noAccount,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const Divider(height: 40),
                  OutlinedButton.icon(
                    onPressed: () async {
                      var result = await authProvider.signInWithGoogle();
                      if (result == null) {
                        AuthManager.login();
                      } else {
                        // ignore: use_build_context_synchronously
                        _showErrorDialog(context, result);
                      }
                    },
                    icon: const Icon(Icons.g_mobiledata, size: 30),
                    label: Text(tr.googleButton),
                  ),
                  const SizedBox(height: 20),
                  //change Language Button:
                  Container(
                    alignment: Alignment.bottomRight,
                    width: 170,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        languageProvider.changeLanguage(
                          languageProvider.isArabic
                              ? Locale("en", "US")
                              : Locale("ar", "SA"),
                        );
                      },
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            tr.language,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Tahoma",
                            ),
                          ),
                          Icon(Icons.language_sharp),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ThemeData theme,
    required isObscured,
    bool isPassword = false,
    VoidCallback? onIconPressed,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? isObscured : false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(Icons.person_outline, color: Colors.transparent),
        suffixIcon: IconButton(
          icon: Icon(icon, color: theme.colorScheme.primary),
          onPressed: onIconPressed,
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Icon(Icons.error, color: Colors.red, size: 40),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.okButton),
          ),
        ],
      ),
    );
  }
}
