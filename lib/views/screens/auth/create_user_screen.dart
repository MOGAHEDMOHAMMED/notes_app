import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart' show AuthProvider;

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController =
      TextEditingController(); // غيرناه لـ email
  final TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء حساب جديد"), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildTextField(
                fullNameController,
                "الاسم الكامل",
                Icons.person,
                theme,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                emailController,
                "البريد الإلكتروني",
                Icons.email,
                theme,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                passwordController,
                "كلمة المرور",
                isObscured ? Icons.visibility_off : Icons.visibility,
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

                    if (error != null && mounted) {
                      // ignore: use_build_context_synchronously
                      _showErrorDialog(context, error);
                    } else if (mounted) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "إنشاء",
                    style: TextStyle(
                      fontSize: 22,
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    ThemeData theme, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? isObscured : false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(icon, color: theme.colorScheme.primary),
          onPressed: isPassword
              ? () {
                  setState(() {
                    isObscured = !isObscured;
                  });
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
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
