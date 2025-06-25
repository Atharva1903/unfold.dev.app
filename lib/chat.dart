import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:unfold_dev/chat_detail.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  final List<String> _randomMessages = [
    'Can you share the github repository for this...',
    'I have committed the changes to the project.',
    'The payment has been transferred as well.',
    'I am interested in working for the new project.',
    'I think the module needs to be changed as discussed.',
    'I am interested in working with Typescript code.',
    'I need a flutter developer for my project asap.',
    'Let me know if you need any help with the backend.',
    'Can we have a call to discuss the requirements?',
    'The UI looks great, just a few tweaks needed.',
  ];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = users;
      } else {
        filteredUsers =
            users
                .where((user) => user['username'].toLowerCase().contains(query))
                .toList();
      }
    });
  }

  Future<void> _loadUsers() async {
    final data = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/data/usernames.json');
    final loadedUsers = json.decode(data);
    // Assign random date and message
    for (var user in loadedUsers) {
      int day = 1 + _random.nextInt(30);
      user['date'] = day.toString().padLeft(2, '0') + '/06/25';
      user['lastMsg'] =
          _randomMessages[_random.nextInt(_randomMessages.length)];
    }
    setState(() {
      users = loadedUsers;
      filteredUsers = loadedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Talk Space',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'boldfont',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12, width: 1.2),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'search user',
                        prefixIcon: Icon(Icons.search, size: 22),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12, width: 1.2),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.people, size: 22),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child:
                filteredUsers.isEmpty
                    ? const Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.separated(
                      itemCount: filteredUsers.length,
                      separatorBuilder:
                          (context, index) => const Divider(
                            indent: 80,
                            endIndent: 18,
                            height: 0,
                          ),
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final lastMsg = user['lastMsg'];
                        final date = user['date'];
                        final isStarred = user['starred'] ?? false;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(user['avatarUrl']),
                            radius: 24,
                          ),
                          title: Text(
                            user['username'],
                            style: const TextStyle(
                              fontFamily: 'boldfont',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            lastMsg,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'regfont',
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Icon(
                                isStarred ? Icons.star : Icons.star_border,
                                color:
                                    isStarred ? Colors.amber : Colors.black26,
                                size: 20,
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ChatDetailScreen(
                                      username: user['username'],
                                      avatarUrl: user['avatarUrl'],
                                    ),
                              ),
                            );
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 6,
                          ),
                        );
                      },
                    ),
          ),
        ],
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
        currentIndex: 2,
        onTap: (index) {
          // TODO: Handle navigation
        },
      ),
    );
  }
}
