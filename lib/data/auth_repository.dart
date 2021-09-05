import 'package:chirp/error/app_errors.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final Supabase _supabase;

  AuthRepository({required Supabase supabase}) : _supabase = supabase;

  Future<User?> getCurrentUser() async {
    return _supabase.client.auth.currentUser;
  }

  Future<Session?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await _supabase.client.auth.signIn(
      email: email,
      password: password,
      options: AuthOptions(
        redirectTo: "io.supabase.flutterquickstart://login-callback/",
      ),
    );

    if (response.error != null) {
      //  throw error when error occurred
      throw AuthError(response.error!.message);
    } else {
      //  sign in success
      return response.data;
    }
  }

  Future<Session?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await _supabase.client.auth.signUp(
      email,
      password,
      options: AuthOptions(
        redirectTo: "io.supabase.flutterquickstart://login-callback/",
      ),
    );

    if (response.error != null) {
      //  throw error when error occurred
      throw AuthError(response.error!.message);
    } else {
      //  sign in success
      return response.data;
    }
  }

  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
  }
}
