// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:my_flutter_project/providers/language_provider.dart';
import 'package:my_flutter_project/views/widget/build_text_field.dart';
import 'package:my_flutter_project/views/widget/helper_methods.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:my_flutter_project/providers/ui_state_provider.dart';
import '../../../providers/auth_provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;
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
                        Icons.edit_note_outlined,
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

                  //Email Text Field:
                  BuildTextField(
                    controller: emailController,
                    label: tr.emailLabel,
                    icon: Icons.email,
                    theme: theme,
                  ),
                  const SizedBox(height: 20),

                  //Password Text Field:
                  Selector<UIStateProvider, bool>(
                    selector: (conjtext, isObscured) =>
                        isObscured.currentVisibility(),
                    builder: (context, isSecure, child) => BuildTextField(
                      controller: passwordController,
                      label: tr.passwordLabel,
                      icon: isSecure ? Icons.visibility_off : Icons.visibility,
                      theme: theme,
                      isObscured: isSecure,
                      isPassword: true,
                      onIconPressed: () =>
                          context.read<UIStateProvider>().toggleVisibility(),
                    ),
                  ),
                  const SizedBox(height: 40),

                  //LogIn Button With email and pass:
                  Selector<AuthProvider, bool>(
                    selector: (context, isLoading) => isLoading.isLoading,
                    builder: (context, value, child) => value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            onPressed: () async {
                              String? error = await context
                                  .read<AuthProvider>()
                                  .signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                              if (!context.mounted) return;
                              if (error != null) {
                                HelperMethods.showErrorDialog(context, error);
                                return;
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
                  ),
                  const SizedBox(height: 20),

                  //Don't have an account? Sign Up:
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.createUserScreen);
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

                  //Sing in With Google:
                  OutlinedButton.icon(
                    onPressed: () async {
                      var result = await context
                          .read<AuthProvider>()
                          .signInWithGoogle();
                      if (result != null) {
                        HelperMethods.showErrorDialog(context, result);
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
                    height: 60,
                    child: Consumer<LanguageProvider>(
                      builder: (context, languageProvider, child) =>
                          ElevatedButton(
                            onPressed: () {
                              Provider.of<LanguageProvider>(
                                context,
                                listen: false,
                              ).changeLanguage(
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
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Icon(Icons.language_sharp),
                              ],
                            ),
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
