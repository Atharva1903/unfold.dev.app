import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'),
            radius: 56,
          ),
          const SizedBox(height: 12),
          const Text(
            '@chirag27',
            style: TextStyle(
              fontFamily: 'boldfont',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Chirag Ferwani',
            style: TextStyle(
              fontFamily: 'boldfont',
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Software Developer',
            style: TextStyle(
              fontFamily: 'regfont',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(FontAwesomeIcons.github, size: 25),
              SizedBox(width: 18),
              Icon(FontAwesomeIcons.instagram, size: 25),
              SizedBox(width: 18),
              Icon(FontAwesomeIcons.linkedin, size: 25),
              SizedBox(width: 18),
              Icon(Icons.language, size: 25),
              SizedBox(width: 18),
              Icon(FontAwesomeIcons.twitter, size: 25),
            ],
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD6E4FF), Color(0xFFB8D8FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '27',
                          style: TextStyle(
                            fontFamily: 'boldfont',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'IDEAS',
                          style: TextStyle(
                            fontFamily: 'boldfont',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFE0F7), Color(0xFFFFF6D6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '08',
                          style: TextStyle(
                            fontFamily: 'boldfont',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'DEVS',
                          style: TextStyle(
                            fontFamily: 'boldfont',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tech Stack',
                style: TextStyle(
                  fontFamily: 'boldfont',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: _TechStackWrap(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechStackWrap extends StatelessWidget {
  static const List<Map<String, dynamic>> techs = [
    {'icon': FontAwesomeIcons.code, 'label': 'Flutter'},
    {'icon': FontAwesomeIcons.github, 'label': 'GitHub'},
    {'icon': FontAwesomeIcons.python, 'label': 'Python'},
    {'icon': FontAwesomeIcons.js, 'label': 'JavaScript'},
    {'icon': FontAwesomeIcons.database, 'label': 'SQL'},
    {'icon': FontAwesomeIcons.react, 'label': 'React'},
    {'icon': FontAwesomeIcons.nodeJs, 'label': 'Node.js'},
    {'icon': FontAwesomeIcons.gitAlt, 'label': 'Git'},
    {'icon': FontAwesomeIcons.html5, 'label': 'HTML5'},
    {'icon': FontAwesomeIcons.css3Alt, 'label': 'CSS3'},
    {'icon': FontAwesomeIcons.swift, 'label': 'Swift'},
    {'icon': FontAwesomeIcons.java, 'label': 'Java'},
    {'icon': FontAwesomeIcons.php, 'label': 'PHP'},
    {'icon': FontAwesomeIcons.angular, 'label': 'Angular'},
    {'icon': FontAwesomeIcons.laravel, 'label': 'Laravel'},
    {'icon': FontAwesomeIcons.docker, 'label': 'Docker'},
    {'icon': FontAwesomeIcons.aws, 'label': 'AWS'},
    {'icon': FontAwesomeIcons.android, 'label': 'Android'},
    {'icon': FontAwesomeIcons.apple, 'label': 'iOS'},
    {'icon': FontAwesomeIcons.cuttlefish, 'label': 'C++'},
  ];

  static const List<Color> pastelColors = [
    Color(0xFFD6E4FF), // blue
    Color(0xFFFFF6D6), // yellow
    Color(0xFFD6FFF6), // mint
    Color(0xFFFFE0E0), // pink
    Color(0xFFD6FFD8), // green
    Color(0xFFFFE0F7), // purple
    Color(0xFFE0E7FF), // light blue
    Color(0xFFFFF0D6), // light yellow
    Color(0xFFE0FFF6), // light mint
    Color(0xFFFFE0F0), // light pink
    Color(0xFFE0FFD8), // light green
    Color(0xFFF0E0FF), // lavender
    Color(0xFFD6F0FF), // sky blue
    Color(0xFFFFEAD6), // peach
    Color(0xFFD6FFE7), // seafoam
    Color(0xFFFFD6F6), // rose
    Color(0xFFE0F7FF), // ice blue
    Color(0xFFFFF6E0), // cream
    Color(0xFFE0FFD6), // pale green
    Color(0xFFFFD6D6), // blush
  ];

  const _TechStackWrap();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: List.generate(
        techs.length,
        (i) => _TechTag(
          icon: techs[i]['icon'],
          label: techs[i]['label'],
          color: pastelColors[i % pastelColors.length],
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TechTag({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 1.2),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'boldfont',
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
