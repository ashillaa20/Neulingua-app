import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/colors.dart';
import '../state/app_state.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});
  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen>
    with SingleTickerProviderStateMixin {
  int _tabIdx = 0;
  int _cardIdx = 0;
  bool _flipped = false;
  late AnimationController _flipCtrl;
  late Animation<double> _flipAnim;

  static const _tabs = ['Daily', 'Food', 'Travel'];

  static const _vocab = {
    'Daily': [
      {'word': 'Apple', 'meaning': 'Apel'},
      {'word': 'House', 'meaning': 'Rumah'},
      {'word': 'Water', 'meaning': 'Air'},
      {'word': 'Book', 'meaning': 'Buku'},
      {'word': 'Table', 'meaning': 'Meja'},
      {'word': 'Chair', 'meaning': 'Kursi'},
      {'word': 'Sky', 'meaning': 'Langit'},
    ],
    'Food': [
      {'word': 'Rice', 'meaning': 'Nasi'},
      {'word': 'Chicken', 'meaning': 'Ayam'},
      {'word': 'Bread', 'meaning': 'Roti'},
      {'word': 'Milk', 'meaning': 'Susu'},
      {'word': 'Egg', 'meaning': 'Telur'},
      {'word': 'Salt', 'meaning': 'Garam'},
      {'word': 'Sugar', 'meaning': 'Gula'},
    ],
    'Travel': [
      {'word': 'Airport', 'meaning': 'Bandara'},
      {'word': 'Ticket', 'meaning': 'Tiket'},
      {'word': 'Hotel', 'meaning': 'Hotel'},
      {'word': 'Passport', 'meaning': 'Paspor'},
      {'word': 'Luggage', 'meaning': 'Koper'},
      {'word': 'Station', 'meaning': 'Stasiun'},
      {'word': 'Map', 'meaning': 'Peta'},
    ],
  };

  List<Map<String, String>> get _list =>
      (_vocab[_tabs[_tabIdx]]!).cast<Map<String, String>>();

  @override
  void initState() {
    super.initState();
    _flipCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _flipAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _flipCtrl.dispose();
    super.dispose();
  }

  void _switchTab(int i) {
    setState(() {
      _tabIdx = i;
      _cardIdx = 0;
      _flipped = false;
    });
    _flipCtrl.reset();
  }

  void _flip() {
    if (_flipped)
      _flipCtrl.reverse();
    else
      _flipCtrl.forward();
    setState(() => _flipped = !_flipped);
  }

  void _submit() {
    AppStateProvider.of(context).addXP(5);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('+5 XP! Marked as learned ✅'),
      backgroundColor: C.yellow,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    ));
    _goNext();
  }

  void _goNext() {
    if (_cardIdx < _list.length - 1) {
      _flipCtrl.reset();
      setState(() {
        _cardIdx++;
        _flipped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = _list[_cardIdx];
    final total = _list.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),

          // ── App bar ────────────────────────────────────────
          Row(children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: C.bgGray, borderRadius: BorderRadius.circular(8)),
              child:
                  const Icon(Icons.close_rounded, size: 18, color: C.textDark),
            ),
            const SizedBox(width: 12),
            const Text('Learn Vocabulary',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: C.textDark)),
          ]),

          const SizedBox(height: 20),

          // ── Tab chips ─────────────────────────────────────
          Row(
              children: List.generate(_tabs.length, (i) {
            final active = _tabIdx == i;
            return GestureDetector(
              onTap: () => _switchTab(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
                decoration: BoxDecoration(
                  color: active ? C.yellow : C.bgInput,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                      color: active ? C.yellowDeep : C.border, width: 1.2),
                  boxShadow: active
                      ? [
                          BoxShadow(
                              color: C.yellow.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3))
                        ]
                      : [],
                ),
                child: Text(_tabs[i],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: active ? C.textDark : C.textGray)),
              ),
            );
          })),

          const SizedBox(height: 20),

          // ── Progress dots ──────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                total,
                (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _cardIdx == i ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _cardIdx == i ? C.yellow : C.divider,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
          ),

          const SizedBox(height: 20),

          // ── Flip card ─────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: _flip,
              child: AnimatedBuilder(
                animation: _flipAnim,
                builder: (ctx, _) {
                  final angle = _flipAnim.value * math.pi;
                  final showFront = _flipAnim.value < 0.5;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: C.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: C.border, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 24,
                              offset: const Offset(0, 8))
                        ],
                      ),
                      child: showFront
                          ? _FrontFace(word: card['word']!, idx: _cardIdx)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _BackFace(
                                word: card['word']!,
                                meaning: card['meaning']!,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),
          Center(
            child: Text('Tap card to flip',
                style: TextStyle(fontSize: 11, color: C.textGray)),
          ),

          const SizedBox(height: 14),

          // ── Submit + Next ──────────────────────────────────
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: _submit,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: C.yellow,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: C.yellow.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                    child: Text('Submit',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: C.textDark)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _cardIdx < total - 1 ? _goNext : null,
              child: Container(
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: C.bgGray,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: C.border),
                ),
                child: Center(
                  child: Text('Next',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color:
                              _cardIdx < total - 1 ? C.textDark : C.textGray)),
                ),
              ),
            ),
          ]),

          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}

// ── Front face ────────────────────────────────────────────────────
class _FrontFace extends StatelessWidget {
  final String word;
  final int idx;
  const _FrontFace({required this.word, required this.idx});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(word,
          style: const TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: C.textDark,
              letterSpacing: -1)),
      const SizedBox(height: 28),
      // Speaker icon
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: C.yellowLight,
          shape: BoxShape.circle,
          border: Border.all(color: C.yellow.withOpacity(0.4), width: 1.5),
        ),
        child: const Center(
          child: Icon(Icons.volume_up_rounded, size: 28, color: C.yellow),
        ),
      ),
    ]);
  }
}

// ── Back face ─────────────────────────────────────────────────────
class _BackFace extends StatelessWidget {
  final String word, meaning;
  const _BackFace({required this.word, required this.meaning});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(word,
          style: const TextStyle(
              fontSize: 44, fontWeight: FontWeight.w800, color: C.textDark)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: C.yellowLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: C.yellow.withOpacity(0.4)),
        ),
        child: Text('Meaning : $meaning',
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: C.textDark)),
      ),
      const SizedBox(height: 24),
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: C.yellowLight,
          shape: BoxShape.circle,
          border: Border.all(color: C.yellow.withOpacity(0.4), width: 1.5),
        ),
        child: const Center(
          child: Icon(Icons.volume_up_rounded, size: 28, color: C.yellow),
        ),
      ),
    ]);
  }
}
