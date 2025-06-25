import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatDetailScreen extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey, I saw your project idea!',
      'isMe': false,
      'time': '10:00 AM',
    },
    {
      'text': 'Thanks! Are you interested in collaborating?',
      'isMe': true,
      'time': '10:02 AM',
    },
    {
      'text': 'Yes, I have experience with Flutter and Node.js',
      'isMe': false,
      'time': '10:05 AM',
    },
    {
      'text': 'Perfect! When can we discuss the details?',
      'isMe': true,
      'time': '10:07 AM',
    },
    {'text': 'How about tomorrow at 3 PM?', 'isMe': false, 'time': '10:10 AM'},
  ];

  ChatDetailScreen({Key? key, required this.username, required this.avatarUrl})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(avatarUrl), radius: 20),
            const SizedBox(width: 12),
            Text(
              username,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'boldfont',
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment:
                      message['isMe']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                          message['isMe']
                              ? const Color(0xFFD6E4FF)
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message['text'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'regfont',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: 'regfont',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontFamily: 'regfont'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
