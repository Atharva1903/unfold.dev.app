import 'dart:developer';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:unfold_dev/auth/auth_service.dart';
import 'package:unfold_dev/login_page.dart';
import 'package:ionicons/ionicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //get auth service
  final authService = AuthService();

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  // password visibility toggles
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  //sign up button is pressed
  void signUp() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final name = _nameController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Passwords don't match")));

      return;
    }

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your name")));

      return;
    }

    //attempt sign up
    try {
      final response = await authService.signUpWithEmailPassword(
        email,
        password,
        name,
      );
      //pop register page
      Navigator.pop(context);
    }
    //catch any errors..
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
        log("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 200),
              const SizedBox(height: 10),
              const Text(
                "unfold.dev",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'boldfont',
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sign Up To Experience Test Creation",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontFamily: 'Boldfont',
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Full Name",
                  labelStyle: const TextStyle(fontFamily: 'boldfont'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Email",
                  labelStyle: const TextStyle(fontFamily: 'boldfont'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Password",
                  labelStyle: const TextStyle(fontFamily: 'boldfont'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Ionicons.eye_off : Ionicons.eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Confirm Password",
                  labelStyle: const TextStyle(fontFamily: 'boldfont'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Ionicons.eye_off : Ionicons.eye,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(fontSize: 18, fontFamily: 'boldfont'),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                child: const Text(
                  "Already have an account? Sign In",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'boldfont',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
