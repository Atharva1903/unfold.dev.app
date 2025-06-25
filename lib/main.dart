import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unfold_dev/splash.dart';
import 'navigation.dart';

//global object for accessing device screen size
late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ipslhivjleaokximdzup.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlwc2xoaXZqbGVhb2t4aW1kenVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0ODg0MzUsImV4cCI6MjA2NjA2NDQzNX0.eUYe8yODt_-UO-uFurvnyaPlpAKKBNYCW0gW4JaP0g8',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: Splash(),
    );
  }
}
