import 'package:flutter/material.dart';
import 'package:my_flutter_project/auth_wrapper.dart';
import 'package:my_flutter_project/core/l10n/app_localizations.dart';
import 'package:my_flutter_project/providers/managment_some_state.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart' show AuthProvider;
import '../../../providers/language_provider.dart';

class CreateUserScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                tr!.createAcountTitle,
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
                        Icons.person_add_alt_1_rounded,
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
                  const SizedBox(height: 20),
                  _buildTextField(
                    emailController,
                    tr.emailLabel,
                    Icons.email,
                    context,
                    theme,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    passwordController,
                    tr.passwordLabel,
                    Provider.of<ManagmentSomeState>(
                          context,
                          listen: true,
                        ).currentVisibility()
                        ? Icons.visibility_off
                        : Icons.visibility,
                    context,
                    theme,
                    isPassword: true,
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
                        String? error = await authProvider.signUp(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          fullNameController.text.trim(),
                        );
                        if (error != null) {
                          // ignore: use_build_context_synchronously
                          _showErrorDialog(context, error);
                        } else {
                          AuthManager.login();
                        }
                      },
                      child: Text(
                        tr.createButton,
                        style: TextStyle(
                          fontSize: 22,
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const Divider(height: 40),
                  SizedBox(
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
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    BuildContext context,
    ThemeData theme, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword
          ? Provider.of<ManagmentSomeState>(
              context,
              listen: true,
            ).currentVisibility()
          : false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(icon, color: theme.colorScheme.primary),
          onPressed: isPassword
              ? () {
                  Provider.of<ManagmentSomeState>(
                    context,
                  ).toggleVisibility();
                }
              : null,
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
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
