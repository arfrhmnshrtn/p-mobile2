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
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>(
  (ref) => AuthNotifier(),
);
