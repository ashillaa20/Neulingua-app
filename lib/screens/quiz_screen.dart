import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../state/app_state.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _cur = 0;
  int? _sel;
  bool _submitted = false;
  int _correct = 0;
  bool _done = false;

  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;

  static const _qs = [
    {
      'q': 'What Is "Apel" In English?',
      'opts': ['Apple', 'Orange', 'Banana', 'Mango'],
      'ans': 0
    },
    {
      'q': 'What Is "Mobil" In English?',
      'opts': ['Bicycle', 'Truck', 'Car', 'Bus'],
      'ans': 2
    },
    {
      'q': 'What Is "Rumah" In English?',
      'opts': ['School', 'House', 'Office', 'Hotel'],
      'ans': 1
    },
    {
      'q': 'What Is "Kucing" In English?',
      'opts': ['Dog', 'Bird', 'Fish', 'Cat'],
      'ans': 3
    },
    {
      'q': 'What Is "Air" In English?',
      'opts': ['Fire', 'Earth', 'Water', 'Wind'],
      'ans': 2
    },
    {
      'q': 'What Is "Buku" In English?',
      'opts': ['Pen', 'Book', 'Table', 'Chair'],
      'ans': 1
    },
    {
      'q': 'What Is "Meja" In English?',
      'opts': ['Chair', 'Bed', 'Table', 'Lamp'],
      'ans': 2
    },
    {
      'q': 'What Is "Pintu" In English?',
      'opts': ['Window', 'Door', 'Wall', 'Floor'],
      'ans': 1
    },
    {
      'q': 'What Is "Bunga" In English?',
      'opts': ['Tree', 'Leaf', 'Flower', 'Grass'],
      'ans': 2
    },
    {
      'q': 'What Is "Langit" In English?',
      'opts': ['Sea', 'Mountain', 'River', 'Sky'],
      'ans': 3
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnim = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOut));
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  void _select(int i) {
    if (_submitted) return;
    setState(() => _sel = i);
  }

  void _submit() {
    if (_sel == null) return;
    final isCorrect = _sel == _qs[_cur]['ans'] as int;
    if (isCorrect) _correct++;
    setState(() => _submitted = true);
  }

  void _next() {
    if (_cur < _qs.length - 1) {
      _slideCtrl.reset();
      setState(() {
        _cur++;
        _sel = null;
        _submitted = false;
      });
      _slideCtrl.forward();
    } else {
      AppStateProvider.of(context).addQuizResult(_correct, _qs.length);
      setState(() => _done = true);
    }
  }

  void _reset() {
    _slideCtrl.reset();
    setState(() {
      _cur = 0;
      _sel = null;
      _submitted = false;
      _correct = 0;
      _done = false;
    });
    _slideCtrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _buildResult();

    final q = _qs[_cur];
    final opts = q['opts'] as List<String>;
    final ans = q['ans'] as int;
    final total = _qs.length;

    return SafeArea(
      child: Column(children: [
        // ── App bar ───────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(children: [
            GestureDetector(
              onTap: _reset,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: C.bgGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.close_rounded,
                    size: 18, color: C.textDark),
              ),
            ),
            const SizedBox(width: 12),
            const Text('Language Quiz',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: C.textDark)),
          ]),
        ),

        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Counter + Quit ──────────────────────────────
            Row(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: C.yellowLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: C.yellow.withOpacity(0.4)),
                ),
                child: Text('Question ${_cur + 1}/$total',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: C.textDark)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _reset,
                child: const Text('Quit',
                    style: TextStyle(
                        fontSize: 13,
                        color: C.yellow,
                        fontWeight: FontWeight.w700)),
              ),
            ]),

            const SizedBox(height: 12),

            // ── Progress bar ────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (_cur + 1) / total,
                backgroundColor: C.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(C.yellow),
                minHeight: 7,
              ),
            ),

            const SizedBox(height: 22),
          ]),
        ),

        // ── Question + Options (slide in) ─────────────────────
        Expanded(
          child: SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(q['q'] as String,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: C.textDark,
                            height: 1.4)),

                    const SizedBox(height: 22),

                    // Options
                    ...List.generate(opts.length, (i) {
                      final isSelected = _sel == i;
                      final isCorrect = i == ans;

                      Color bg = C.white;
                      Color border = C.border;
                      Color txt = C.textDark;

                      if (_submitted) {
                        if (isCorrect) {
                          bg = const Color(0xFFDCFCE7);
                          border = C.green;
                          txt = const Color(0xFF15803D);
                        } else if (isSelected) {
                          bg = const Color(0xFFFEE2E2);
                          border = C.red;
                          txt = const Color(0xFFDC2626);
                        }
                      } else if (isSelected) {
                        bg = C.yellow;
                        border = C.yellow;
                        txt = C.textDark;
                      }

                      return GestureDetector(
                        onTap: () => _select(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: border, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2))
                            ],
                          ),
                          child: Row(children: [
                            Expanded(
                              child: Text(opts[i],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: txt)),
                            ),
                            if (_submitted && isCorrect)
                              const Icon(Icons.check_circle_rounded,
                                  color: C.green, size: 20),
                            if (_submitted && isSelected && !isCorrect)
                              const Icon(Icons.cancel_rounded,
                                  color: C.red, size: 20),
                          ]),
                        ),
                      );
                    }),
                  ]),
            ),
          ),
        ),

        // ── Feedback ─────────────────────────────────────────
        if (_submitted)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: _sel == (_qs[_cur]['ans'] as int)
                    ? const Color(0xFFDCFCE7)
                    : const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Text(
                  _sel == (_qs[_cur]['ans'] as int)
                      ? '✅  Correct!'
                      : '❌  Incorrect!',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _sel == (_qs[_cur]['ans'] as int)
                          ? const Color(0xFF15803D)
                          : const Color(0xFFDC2626)),
                ),
                if (_sel != (_qs[_cur]['ans'] as int)) ...[
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(
                          'Answer: ${(_qs[_cur]['opts'] as List)[_qs[_cur]['ans'] as int]}',
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFFDC2626)))),
                ],
              ]),
            ),
          ),

        // ── Submit / Next ─────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: GestureDetector(
            onTap: _submitted ? _next : (_sel != null ? _submit : null),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 54,
              decoration: BoxDecoration(
                color: _sel != null ? C.yellow : C.divider,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  if (_sel != null)
                    BoxShadow(
                        color: C.yellow.withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4)),
                ],
              ),
              child: Center(
                child: Text(
                  _submitted
                      ? (_cur < _qs.length - 1 ? 'Next →' : 'See Result')
                      : 'Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: _sel != null ? C.textDark : C.textGray),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  // ── Result screen ───────────────────────────────────────────────
  Widget _buildResult() {
    final pct = (_correct / _qs.length * 100).round();
    final state = AppStateProvider.of(context);

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Emoji result
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: pct >= 60 ? C.yellowLight : const Color(0xFFFEE2E2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(pct >= 60 ? '🏆' : '💪',
                    style: const TextStyle(fontSize: 60)),
              ),
            ),
            const SizedBox(height: 24),
            Text(pct >= 60 ? 'Excellent!' : 'Keep Practicing!',
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: C.textDark)),
            const SizedBox(height: 8),
            Text('$_correct / ${_qs.length} correct  ($pct%)',
                style: const TextStyle(color: C.textMid, fontSize: 14)),
            const SizedBox(height: 8),
            Text('+${_correct * 10} XP  ·  Total: ${state.totalXP} XP',
                style: const TextStyle(
                    color: C.yellow,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            const SizedBox(height: 40),
            // Retry
            GestureDetector(
              onTap: _reset,
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: C.yellow,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: C.yellow.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: const Center(
                  child: Text('Try Again',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: C.textDark)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
