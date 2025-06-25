// AUTH GATE - This will continuously listen for auth state changes
//Unauthenticated -> Login page
//Authenticated -> Home page

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unfold_dev/navigation.dart';
import 'package:unfold_dev/login_page.dart';
import 'package:unfold_dev/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        //check if there is a valid session currently
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return Navigation();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
