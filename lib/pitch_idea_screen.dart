import 'package:flutter/material.dart';

class PitchIdeaScreen extends StatefulWidget {
  const PitchIdeaScreen({Key? key}) : super(key: key);

  @override
  State<PitchIdeaScreen> createState() => _PitchIdeaScreenState();
}

class _PitchIdeaScreenState extends State<PitchIdeaScreen> {
  final TextEditingController _descController = TextEditingController();
  bool _openToValidation = true;
  bool _protectWithNDA = true;
  bool _revenueReady = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F0FF), Color(0xFFD0E6FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 340,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFB8D8FF),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Unfold Your Idea',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'boldfont',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'SHARE',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  //Icon(Icons.send, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'describe in short:',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'RegularFont',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: _descController,
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'RegularFont',
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SwitchListTile(
                          value: _openToValidation,
                          onChanged:
                              (val) => setState(() => _openToValidation = val),
                          title: const Text(
                            'open to validation',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'boldfont',
                            ),
                          ),
                          activeColor: Colors.green,
                          contentPadding: EdgeInsets.zero,
                        ),
                        SwitchListTile(
                          value: _protectWithNDA,
                          onChanged:
                              (val) => setState(() => _protectWithNDA = val),
                          title: const Text(
                            'protect with NDA',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'boldfont',
                            ),
                          ),
                          activeColor: Colors.green,
                          contentPadding: EdgeInsets.zero,
                        ),
                        SwitchListTile(
                          value: _revenueReady,
                          onChanged:
                              (val) => setState(() => _revenueReady = val),
                          title: const Text(
                            'revenue-ready idea',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'boldfont',
                            ),
                          ),
                          activeColor: Colors.green,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
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
