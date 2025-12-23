import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthNotifier() : super(null) {
    _auth.authStateChanges().listen((User? user) {
      state = user;
    });
  }

  Stream<User?> get streamStatus => _auth.authStateChanges();

  Future<String?> login(String email, String pass) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Email tidak ditemukan.";
      } else if (e.code == 'wrong-password') {
        return "Password salah.";
      } else {
        return e.message;
      }
    }
  }

  Future<String?> register(String email, String pass) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password terlalu lemah.";
      } else if (e.code == 'email-already-in-use') {
        return "Email sudah terdaftar.";
      } else {
        return e.message;
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String?> ResetPassword(String email) async {
    if (email.isEmpty) {
      return "Email tidak boleh kosong.";
    }

    if (!email.contains('@')) {
      return "Format email tidak valid.";
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      return "Terjadi kesalahan saat mengirim email reset password.";
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);
