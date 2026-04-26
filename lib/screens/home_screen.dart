import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared.dart';
import 'translate_screen.dart';
import 'quiz_screen.dart';
import 'vocabulary_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  final int startIdx;
  const HomeScreen({super.key, this.startIdx = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _idx;

  @override
  void initState() {
    super.initState();
    _idx = widget.startIdx;
  }

  void _nav(int i) => setState(() => _idx = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgPage,
      body: IndexedStack(
        index: _idx,
        children: [
          _HomeBody(onNav: _nav),
          const QuizScreen(),
          const VocabularyScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(idx: _idx, onTap: _nav),
    );
  }
}

class _HomeBody extends StatelessWidget {
  final void Function(int) onNav;
  const _HomeBody({required this.onNav});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 28),

          // ── Header ────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Text('Hi, Andi',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: C.textDark)),
                      const SizedBox(width: 6),
                      const Text('👋', style: TextStyle(fontSize: 24)),
                    ]),
                    const SizedBox(height: 4),
                    const Text("Let's start learning!",
                        style: TextStyle(fontSize: 13, color: C.textMid)),
                  ]),
            ),
            GestureDetector(
              onTap: () => onNav(3),
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: C.yellowLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: C.yellow, width: 2),
                ),
                child: const Center(
                    child: Text('🧒', style: TextStyle(fontSize: 24))),
              ),
            ),
          ]),

          const SizedBox(height: 36),

          // ── Menu cards ────────────────────────────────────────
          Expanded(
            child: ListView(children: [
              _HomeCard(
                icon: Icons.translate_rounded,
                label: 'Translate',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TranslateScreen())),
              ),
              const SizedBox(height: 16),
              _HomeCard(
                icon: Icons.menu_book_rounded,
                label: 'Learn Vocabulary',
                onTap: () => onNav(2),
              ),
              const SizedBox(height: 16),
              _HomeCard(
                icon: Icons.quiz_rounded,
                label: 'Take a Quiz',
                onTap: () => onNav(1),
              ),
              const SizedBox(height: 16),
              _HomeCard(
                icon: Icons.bar_chart_rounded,
                label: 'Progress',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProgressScreen())),
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ── Home menu card ────────────────────────────────────────────────
class _HomeCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _HomeCard(
      {required this.icon, required this.label, required this.onTap});

  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        transform: _pressed
            ? Matrix4.diagonal3Values(0.97, 0.97, 1.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: C.border, width: 1.3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _pressed ? 0.02 : 0.05),
              blurRadius: _pressed ? 4 : 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(children: [
          // Icon box
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: C.yellowLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(widget.icon, size: 24, color: C.yellow),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(widget.label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: C.textDark)),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: C.bgGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_forward_ios_rounded,
                size: 13, color: C.textMid),
          ),
        ]),
      ),
    );
  }
}
