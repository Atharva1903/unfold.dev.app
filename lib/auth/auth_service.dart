import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': name},
    );
  }

  //Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  //Get current user's name from metadata
  String? getCurrentUserName() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?['display_name'] as String?;
  }

  //Get current user's name from Supabase
  Future<String?> getUserName() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final response =
        await _supabase
            .from('profiles')
            .select('name')
            .eq('id', user.id)
            .single();

    return response['name'] as String?;
  }

  //Update user's name in Supabase
  Future<void> updateUserName(String name) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _supabase.from('profiles').upsert({
      'id': user.id,
      'name': name,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
