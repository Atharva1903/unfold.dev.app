import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  // Helper to load local asset data synchronously (for demo)
  Future<List<dynamic>> _loadJsonList(BuildContext context, String path) async {
    final data = await DefaultAssetBundle.of(context).loadString(path);
    return json.decode(data);
  }

  Color _getIdeaCardColor(int index) {
    // Soft pastel colors for idea cards
    final colors = [
      [Color(0xFFD6E4FF), Color(0xFFB7FFD8)],
      [Color(0xFFFFF6D6), Color(0xFFFFE0E0)],
      [Color(0xFFD6FFF6), Color(0xFFD6E4FF)],
      [Color(0xFFFFE0E0), Color(0xFFFFF6D6)],
    ];
    return colors[index % colors.length][0];
  }

  Color _getDevCardColor(int index) {
    // Soft pastel gradients for dev cards
    final colors = [
      [Color(0xFFFFE0F7), Color(0xFFD6E4FF)],
      [Color(0xFFD6FFD8), Color(0xFFFFF6D6)],
      [Color(0xFFD6E4FF), Color(0xFFFFE0E0)],
      [Color(0xFFFFF6D6), Color(0xFFD6FFD8)],
      [Color(0xFFD6FFF6), Color(0xFFFFE0F7)],
      [Color(0xFFFFE0E0), Color(0xFFD6E4FF)],
    ];
    return colors[index % colors.length][0];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _loadJsonList(context, 'assets/data/ideas.json'),
        _loadJsonList(context, 'assets/data/developer_requests.json'),
        _loadJsonList(context, 'assets/data/usernames.json'),
      ]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final ideas = snapshot.data![0] as List;
        final devRequests = snapshot.data![1] as List;
        final users = snapshot.data![2] as List;

        // Helper to get user info
        Map<String, String> getUser(int idx) {
          final user = users[idx % users.length];
          return {'username': user['username'], 'avatar': user['avatarUrl']};
        }

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              // Idea Pulse Section
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Idea Pulse',
                      style: TextStyle(
                        fontFamily: 'boldfont',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Ionicons.bulb, color: Colors.black, size: 22),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ideas.length,
                  separatorBuilder: (_, __) => SizedBox(width: 18),
                  itemBuilder: (context, i) {
                    final idea = ideas[i];
                    final user = getUser(i);
                    return Container(
                      width: 270,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _getIdeaCardColor(i),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage(user['avatar']!),
                              ),
                              SizedBox(width: 10),
                              Text(
                                user['username']!,
                                style: TextStyle(
                                  fontFamily: 'boldfont',
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            idea['title'],
                            style: TextStyle(
                              fontFamily: 'boldfont',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            (idea['description'] as String).length > 60
                                ? idea['description'].substring(0, 60) + '...'
                                : idea['description'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: 'regfont',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Dev Updates Section
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Dev Updates',
                      style: TextStyle(
                        fontFamily: 'boldfont',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Ionicons.logo_codepen,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: devRequests.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, i) {
                  final req = devRequests[i];
                  final user = getUser(i + 2); // Offset for variety
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    decoration: BoxDecoration(
                      color: _getDevCardColor(i),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(user['avatar']!),
                            ),
                            SizedBox(width: 8),
                            Text(
                              user['username']!,
                              style: TextStyle(
                                fontFamily: 'boldfont',
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          req['title'],
                          style: TextStyle(
                            fontFamily: 'boldfont',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          (req['description'] as String).length > 60
                              ? req['description'].substring(0, 60) + '...'
                              : req['description'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontFamily: 'regfont',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Ionicons.cash_outline,
                              size: 16,
                              color: Colors.green,
                            ),
                            SizedBox(width: 4),
                            Text(
                              req['amount'].toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'boldfont',
                                color: Colors.green,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Ionicons.people,
                              size: 14,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 3),
                            Text(
                              req['developersNeeded'].toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'boldfont',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
