import 'package:flutter/material.dart' as material;
import 'package:rive/rive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:unfold_dev/chat.dart';
import 'package:unfold_dev/ideadev.dart';
import 'package:unfold_dev/pitchpair.dart';
import 'package:unfold_dev/profile.dart';
import 'package:unfold_dev/settings.dart';
import 'home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unfold_dev/login_page.dart';

class Navigation extends material.StatefulWidget {
  const Navigation({super.key});

  @override
  material.State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends material.State<Navigation> {
  int _selectedIndex = 0;

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(
        title: material.Row(
          mainAxisSize: material.MainAxisSize.min,
          children: [
            material.Image.asset('assets/images/logo.png', height: 36),
            const material.SizedBox(width: 10),
            material.Text(
              "unfold.dev",
              style: material.TextStyle(
                fontFamily: 'boldfont',
                color: material.Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: material.Colors.white,
        actions: [
          material.Padding(
            padding: material.EdgeInsets.only(right: 20),
            child: material.PopupMenuButton<int>(
              offset: const material.Offset(0, 50),
              shape: material.RoundedRectangleBorder(
                borderRadius: material.BorderRadius.circular(12),
              ),
              color: material.Colors.white,
              icon: material.CircleAvatar(
                radius: 20,
                backgroundImage: material.AssetImage(
                  'assets/images/profile.jpg',
                ),
                backgroundColor: material.Colors.transparent,
              ),
              itemBuilder:
                  (context) => [
                    material.PopupMenuItem<int>(
                      value: 0,
                      child: material.SizedBox(
                        width: 200,
                        child: material.Row(
                          children: [
                            const material.Icon(Ionicons.settings, size: 20),
                            const material.SizedBox(width: 10),
                            const material.Text(
                              'Settings',
                              style: material.TextStyle(fontFamily: 'boldfont'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    material.PopupMenuItem<int>(
                      value: 1,
                      child: material.SizedBox(
                        width: 200,
                        child: material.Row(
                          children: [
                            const material.Icon(Ionicons.log_out, size: 20),
                            const material.SizedBox(width: 10),
                            const material.Text(
                              'Log Out',
                              style: material.TextStyle(fontFamily: 'boldfont'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
              onSelected: (value) async {
                if (value == 0) {
                  material.Navigator.of(context).push(
                    material.MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                } else if (value == 1) {
                  // Supabase log out and redirect to sign in
                  await Supabase.instance.client.auth.signOut();
                  material.Navigator.of(context).pushAndRemoveUntil(
                    material.MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),

      extendBody: true, // Important for floating nav bar
      bottomNavigationBar: material.Container(
        padding: const material.EdgeInsets.all(10),
        margin: const material.EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        decoration: material.BoxDecoration(
          color: const material.Color.fromARGB(255, 255, 255, 255),
          borderRadius: material.BorderRadius.circular(24),
          boxShadow: [
            material.BoxShadow(
              color: material.Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const material.Offset(0, 5),
            ),
          ],
        ),
        child: material.Row(
          mainAxisAlignment: material.MainAxisAlignment.spaceAround,
          children: List.generate(
            5, // Fixed number of navigation items
            (index) => material.GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: material.AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const material.EdgeInsets.all(12),
                decoration: material.BoxDecoration(
                  color:
                      _selectedIndex == index
                          ? material.Colors.white.withOpacity(0.2)
                          : material.Colors.transparent,
                  borderRadius: material.BorderRadius.circular(12),
                ),
                child: material.Icon(
                  _getIconData(index),
                  color:
                      _selectedIndex == index
                          ? material.Colors.black
                          : material.Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: screens[_selectedIndex],
    );
  }

  material.IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Ionicons.home;
      case 1:
        return Ionicons.copy;
      case 2:
        return Ionicons.add_circle;
      case 3:
        return Ionicons.chatbox_ellipses;
      case 4:
        return Ionicons.person;
      default:
        return material.Icons.chat_bubble_outline;
    }
  }

  final screens = [
    HomeScreen(),
    IdeaDevScreen(),
    PitchPairScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
}
