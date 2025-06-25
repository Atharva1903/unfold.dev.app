import 'package:flutter/material.dart';

class PairDevScreen extends StatefulWidget {
  const PairDevScreen({Key? key}) : super(key: key);

  @override
  State<PairDevScreen> createState() => _PairDevScreenState();
}

class _PairDevScreenState extends State<PairDevScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _techController = TextEditingController();
  bool _isPaid = true;
  double _amount = 5000;
  bool _invitesFeedback = true;
  bool _creditableWork = true;
  List<String> _techChips = [
    'flutter',
    'github',
    'ai',
    'dart',
    'chatbot',
    'QA',
  ];

  void _addTech(String tech) {
    final trimmed = tech.trim();
    if (trimmed.isNotEmpty && !_techChips.contains(trimmed)) {
      setState(() {
        _techChips.add(trimmed);
      });
    }
    _techController.clear();
  }

  void _removeTech(String tech) {
    setState(() {
      _techChips.remove(tech);
    });
  }

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
            colors: [Color(0xFFFFF6D6), Color(0xFFFFE0F7), Color(0xFFD6FFD8)],
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
                    width: 350,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFF6D6), Color(0xFFFFE0F7)],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.black26, width: 1.2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Developer Partner',
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
                                foregroundColor: Colors.purple,
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
                                    'POST',
                                    style: TextStyle(
                                      fontFamily: 'boldfont',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'describe the project:',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'boldfont',
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
                              fontFamily: 'boldfont',
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'tech stack:',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'boldfont',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _techController,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'boldfont',
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'search for technologies',
                                    prefixIcon: Icon(Icons.search, size: 20),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                  ),
                                  onSubmitted: _addTech,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              _techChips
                                  .map(
                                    (chip) => Chip(
                                      label: Text(
                                        chip,
                                        style: const TextStyle(
                                          fontFamily: 'boldfont',
                                          fontSize: 13,
                                        ),
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                          color: Colors.black12,
                                        ),
                                      ),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                      onDeleted: () => _removeTech(chip),
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Switch(
                              value: _isPaid,
                              onChanged: (val) => setState(() => _isPaid = val),
                              activeColor: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'this role is paid',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'boldfont',
                              ),
                            ),
                          ],
                        ),
                        if (_isPaid) ...[
                          Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                color: Colors.black,
                                size: 22,
                              ),
                              Expanded(
                                child: Slider(
                                  value: _amount,
                                  min: 0,
                                  max: 20000,
                                  divisions: 200,
                                  label: _amount.round().toString(),
                                  onChanged:
                                      (val) => setState(() => _amount = val),
                                ),
                              ),
                              Text(
                                _amount.round().toString(),
                                style: const TextStyle(
                                  fontFamily: 'boldfont',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                        Row(
                          children: [
                            Switch(
                              value: _invitesFeedback,
                              onChanged:
                                  (val) =>
                                      setState(() => _invitesFeedback = val),
                              activeColor: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'this idea invites feedback',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'boldfont',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Switch(
                              value: _creditableWork,
                              onChanged:
                                  (val) =>
                                      setState(() => _creditableWork = val),
                              activeColor: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'creditable work',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'boldfont',
                              ),
                            ),
                          ],
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
