import 'package:flutter/material.dart';
import 'package:my_flutter_project/core/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart' show AuthProvider;

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscured = true; // للتحكم في ظهور كلمة المرور

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // نستدعي البروفايدر للاستماع لحالة التحميل
    final authProvider = Provider.of<AuthProvider>(context); 

    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول"), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // حقل الإيميل
              _buildTextField(
                controller: emailController,
                label: "البريد الإلكتروني",
                icon: Icons.email,
                theme: theme,
              ),
              const SizedBox(height: 20),
              
              _buildTextField(
                controller: passwordController,
                label: "كلمة المرور",
                icon: isObscured ? Icons.visibility_off : Icons.visibility,
                isPassword: true,
                theme: theme,
                onIconPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              ),
              const SizedBox(height: 40),
              if (authProvider.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () async {
                    String? error = await authProvider.signIn(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                    
                    if (error != null && mounted) {
                      _showErrorDialog(context, error);
                    }
                  },
                  child: Text(
                    "دخول",
                    style: TextStyle(
                      fontSize: 20, 
                      color: theme.colorScheme.onPrimary, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

              const SizedBox(height: 20),
              
              // زر إنشاء حساب
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.createUser);
                },
                child: Text(
                  "ليس لديك حساب؟ إنشاء حساب",
                  style: TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const Divider(height: 40),

              // زر الدخول بجوجل
              OutlinedButton.icon(
                onPressed: () async {
                   await authProvider.signInWithGoogle();
                   // الـ AuthWrapper سيتولى عملية النقل
                },
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text("تسجيل الدخول باستخدام Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة لبناء الحقول (Refactoring)
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ThemeData theme,
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
        prefixIcon: Icon(Icons.person_outline, color: Colors.transparent), // لضبط المحاذاة فقط
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
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("حسناً"))
        ],
      ),
    );
  }
}