import 'package:flutter/material.dart';
import 'pitch_idea_screen.dart';
import 'pair_dev_screen.dart';

class PitchPairScreen extends StatelessWidget {
  const PitchPairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PitchIdeaScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/idea.png',
                      width: 56,
                      height: 56,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pitch',
                    style: TextStyle(fontSize: 16, fontFamily: 'boldfont'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            const Text(
              'OR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PairDevScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/dev.png',
                      width: 56,
                      height: 56,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pair',
                    style: TextStyle(fontSize: 16, fontFamily: 'boldfont'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {
          // TODO: Handle navigation
        },
      ),
    );
  }
}
