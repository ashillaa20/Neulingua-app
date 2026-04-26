import 'package:flutter/material.dart';
import 'home_screen.dart';

// ================= SCREEN =================

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'Indonesia';
  bool _open = false;

  final List<String> _langs = const [
    'Indonesia',
    'English',
    'Japanese',
    'Korean',
    'French',
    'German',
    'Spanish',
    'Mandarin',
    'Arabic',
    'Portuguese',
  ];

  void _goNext() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Center(child: _CharacterScene()),
                  const SizedBox(height: 30),

                  const Text(
                    'Your Native Language',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DROPDOWN
                  GestureDetector(
                    onTap: () => setState(() => _open = !_open),
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language),
                          const SizedBox(width: 10),
                          Expanded(child: Text(_selected)),
                          Icon(_open
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                  ),

                  if (_open)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _langs.length,
                        itemBuilder: (_, i) {
                          final lang = _langs[i];
                          final selected = lang == _selected;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selected = lang;
                                _open = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              color: selected
                                  ? Colors.yellow.shade100
                                  : Colors.transparent,
                              child: Text(
                                lang,
                                style: TextStyle(
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _goNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Go to Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= CHARACTER =================

class _CharacterScene extends StatelessWidget {
  const _CharacterScene();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 280,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WordBubble(text: 'ciao'),
                SizedBox(height: 6),
                _WordBubble(text: 'Halo'),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 40,
            child: _WordBubble(text: 'おい'),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: _WordBubble(text: 'Hi'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _WavingPerson(),
          ),
        ],
      ),
    );
  }
}

// ================= BUBBLE =================

class _WordBubble extends StatelessWidget {
  final String text;

  const _WordBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey),
      ),
      child: Text(text),
    );
  }
}

// ================= AVATAR =================

class _WavingPerson extends StatelessWidget {
  const _WavingPerson();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 28,
      backgroundColor: Color(0xFFFFD6A5),
      child: Text('😄', style: TextStyle(fontSize: 24)),
    );
  }
}
