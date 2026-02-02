import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/services/auth_service.dart';
import '../core/services/user_cache_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserCacheService _userCache = UserCacheService();
  User? get user => _authService.currentUser;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Future<String?> signInWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();
      final user = await _authService.signInWithGoogle();
      _isLoading = false;
      notifyListeners();
      if (user == null) {
        return "تم إلغاء تسجيل الدخول";
      }
      return null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return "حدث خطأ غير متوقع: $e";
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = await _authService.signInWithEmail(email, password);

      if (user != null) {
        await _userCache.saveUserData(
          user.displayName ?? "مستخدم",
          user.email ?? email,
        );
      }

      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String?> signUp(String email, String password, String name) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _authService.signUpWithEmail(email, password, name);
      _isLoading = false;
      notifyListeners();
      await _userCache.saveUserData(name, email);

      return null;
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') return 'كلمة المرور ضعيفة';
      if (e.code == 'email-already-in-use') {
        return 'البريد الإلكتروني مسجل مسبقاً';
      }
      return 'حدث خطأ: ${e.message}';
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return 'حدث خطأ غير متوقع';
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
