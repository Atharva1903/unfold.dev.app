import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

class IdeaDevScreen extends StatelessWidget {
  const IdeaDevScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'What are you\nlooking for?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'boldfont',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdeaSwipeScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black12, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/idea.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Idea',
                        style: TextStyle(
                          fontFamily: 'boldfont',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 32),
                Text(
                  'OR',
                  style: TextStyle(
                    fontFamily: 'boldfont',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 32),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DevSwipeScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black12, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/dev.png',
                          width: 48,
                          height: 48,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Dev',
                        style: TextStyle(
                          fontFamily: 'boldfont',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class IdeaSwipeScreen extends StatefulWidget {
  @override
  _IdeaSwipeScreenState createState() => _IdeaSwipeScreenState();
}

class _IdeaSwipeScreenState extends State<IdeaSwipeScreen> {
  List<dynamic> ideas = [];
  List<dynamic> users = [];
  int currentPage = 0;
  List<bool> saved = [];
  List<bool> liked = [];
  List<int> likeCounts = [];
  final random = Random();
  PageController? _pageController;

  // Pastel card colors (like HomeScreen)
  final List<Color> cardColors = [
    Color(0xFFD6E4FF),
    Color(0xFFFFF6D6),
    Color(0xFFD6FFF6),
    Color(0xFFFFE0E0),
    Color(0xFFD6FFD8),
    Color(0xFFFFE0F7),
  ];

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  Future<void> _loadIdeas() async {
    final data = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/ideas.json');
    final userData = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/usernames.json');
    final List<dynamic> loadedIdeas = json.decode(data);
    final List<dynamic> loadedUsers = json.decode(userData);
    setState(() {
      ideas = loadedIdeas;
      users = loadedUsers;
      saved = List.generate(ideas.length, (_) => false);
      liked = List.generate(ideas.length, (_) => false);
      likeCounts = List.generate(
        ideas.length,
        (i) => 900 + random.nextInt(200),
      );
      _pageController = PageController(initialPage: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ideas.isEmpty || _pageController == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD6E4FF),
                  Color(0xFFD6FFD8),
                  Color(0xFFFFF6D6),
                  Color(0xFFFFE0E0),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: ideas.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final idea = ideas[index];
                      final user =
                          users.isNotEmpty ? users[index % users.length] : null;
                      final likes = likeCounts[index];
                      final comments = 30 + random.nextInt(20);
                      final shares = 100 + random.nextInt(50);
                      final cardColor = cardColors[index % cardColors.length];
                      return Center(
                        child: Container(
                          width: 320,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (user != null) ...[
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                        user['avatarUrl'],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      user['username'],
                                      style: TextStyle(
                                        fontFamily: 'boldfont',
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Idea',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 26,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                idea['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'boldfont',
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                idea['description'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontFamily: 'regfont',
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.cash,
                                    color: Colors.green,
                                    size: 26,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    idea['isProfitable']
                                        ? 'Profitable'
                                        : 'Non-profit',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Icon(
                                    Ionicons.people,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${idea['developersNeeded']}+ devs',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),
                              Wrap(
                                spacing: 8,
                                runSpacing: -8,
                                children: [
                                  ...List.generate(
                                    (idea['tags'] as List).length,
                                    (j) => Chip(
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.arrow_drop_up,
                                            size: 18,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            idea['tags'][j],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'boldfont',
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        liked[index] = !liked[index];
                                        likeCounts[index] +=
                                            liked[index] ? 1 : -1;
                                      });
                                    },
                                    child: Icon(
                                      liked[index]
                                          ? Ionicons.heart
                                          : Ionicons.heart_outline,
                                      color:
                                          liked[index]
                                              ? Colors.red
                                              : Colors.black,
                                      size: 26,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$likes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Icon(
                                    Ionicons.chatbubble_outline,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$comments',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  GestureDetector(
                                    onTap: () {
                                      final shareText =
                                          idea['title'] +
                                          '\n\n' +
                                          idea['description'] +
                                          '\n\nTags: ' +
                                          (idea['tags'] as List).join(', ');
                                      Share.share(shareText);
                                    },
                                    child: Icon(
                                      Ionicons.send,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$shares',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        saved[index] = !saved[index];
                                      });
                                    },
                                    child: Icon(
                                      saved[index]
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DevSwipeScreen extends StatefulWidget {
  @override
  _DevSwipeScreenState createState() => _DevSwipeScreenState();
}

class _DevSwipeScreenState extends State<DevSwipeScreen> {
  List<dynamic> devRequests = [];
  List<dynamic> users = [];
  int currentPage = 0;
  List<bool> saved = [];
  List<bool> liked = [];
  List<int> likeCounts = [];
  final random = Random();
  PageController? _pageController;

  // Pastel card colors (like HomeScreen)
  final List<Color> cardColors = [
    Color(0xFFFFE0F7),
    Color(0xFFD6FFD8),
    Color(0xFFD6E4FF),
    Color(0xFFFFE0E0),
    Color(0xFFFFF6D6),
    Color(0xFFD6FFF6),
  ];

  @override
  void initState() {
    super.initState();
    _loadDevRequests();
  }

  Future<void> _loadDevRequests() async {
    final data = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/developer_requests.json');
    final userData = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/usernames.json');
    final List<dynamic> loaded = json.decode(data);
    final List<dynamic> loadedUsers = json.decode(userData);
    setState(() {
      devRequests = loaded;
      users = loadedUsers;
      saved = List.generate(devRequests.length, (_) => false);
      liked = List.generate(devRequests.length, (_) => false);
      likeCounts = List.generate(
        devRequests.length,
        (i) => 500 + random.nextInt(300),
      );
      _pageController = PageController(initialPage: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (devRequests.isEmpty || _pageController == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD6FFD8),
                  Color(0xFFFFE0F7),
                  Color(0xFFFFE0E0),
                  Color(0xFFD6E4FF),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: devRequests.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final req = devRequests[index];
                      final user =
                          users.isNotEmpty ? users[index % users.length] : null;
                      final cardColor = cardColors[index % cardColors.length];
                      final likes = likeCounts[index];
                      final comments = 10 + random.nextInt(20);
                      final shares = 50 + random.nextInt(50);
                      return Center(
                        child: Container(
                          width: 320,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (user != null) ...[
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: AssetImage(
                                        user['avatarUrl'],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      user['username'],
                                      style: TextStyle(
                                        fontFamily: 'boldfont',
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.engineering,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Dev',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 26,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                req['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'boldfont',
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                req['description'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontFamily: 'regfont',
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.cash,
                                    color: Colors.green,
                                    size: 26,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    req['amount'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(width: 24),
                                  Icon(
                                    Icons.groups,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${req['developersNeeded']}+ devs',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14),
                              Wrap(
                                spacing: 8,
                                runSpacing: -8,
                                children: [
                                  ...List.generate(
                                    (req['tags'] as List).length,
                                    (j) => Chip(
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.arrow_drop_up,
                                            size: 18,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            req['tags'][j],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'boldfont',
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        liked[index] = !liked[index];
                                        likeCounts[index] +=
                                            liked[index] ? 1 : -1;
                                      });
                                    },
                                    child: Icon(
                                      liked[index]
                                          ? Ionicons.heart
                                          : Ionicons.heart_outline,
                                      color:
                                          liked[index]
                                              ? Colors.red
                                              : Colors.black,
                                      size: 26,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$likes',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  Icon(
                                    Ionicons.chatbubble_outline,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$comments',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  SizedBox(width: 18),
                                  GestureDetector(
                                    onTap: () {
                                      final shareText =
                                          req['title'] +
                                          '\n\n' +
                                          req['description'] +
                                          '\n\nTags: ' +
                                          (req['tags'] as List).join(', ');
                                      Share.share(shareText);
                                    },
                                    child: Icon(
                                      Ionicons.send,
                                      color: Colors.black,
                                      size: 26,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '$shares',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'regfont',
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black,
                                    size: 26,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
