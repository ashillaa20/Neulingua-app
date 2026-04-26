import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../state/app_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    return Scaffold(
      backgroundColor: C.bgPage,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Progress'),
      ),
      body: AnimatedBuilder(
        animation: state,
        builder: (ctx, _) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              _Card(emoji: '🔥', value: '${state.streakDays}', label: 'Streak Days'),
              const SizedBox(width: 12),
              _Card(emoji: '⭐', value: '${state.totalXP}', label: 'Total XP'),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              _Card(emoji: '📚', value: '${state.lessonsCount}', label: 'Lessons'),
              const SizedBox(width: 12),
              _Card(
                emoji: '🎯',
                value: state.quizTotal > 0
                    ? '${(state.quizCorrect / state.quizTotal * 100).round()}%'
                    : '—',
                label: 'Quiz Accuracy',
              ),
            ]),
            const SizedBox(height: 28),
            const Text('Language Progress',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: C.textDark)),
            const SizedBox(height: 14),
            _ProgBar('🇬🇧', 'English',  state.englishPct),
            const SizedBox(height: 12),
            _ProgBar('🇯🇵', 'Japanese', state.japanesePct),
          ]),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String emoji, value, label;
  const _Card({required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: C.yellowLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.yellow.withOpacity(0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 26)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.w800, color: C.textDark)),
        Text(label, style: const TextStyle(fontSize: 12, color: C.textMid)),
      ]),
    ),
  );
}

class _ProgBar extends StatelessWidget {
  final String flag, lang;
  final double pct;
  const _ProgBar(this.flag, this.lang, this.pct);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: C.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: C.border),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03),
          blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: Column(children: [
      Row(children: [
        Text(flag, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Text(lang, style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 15, color: C.textDark)),
        const Spacer(),
        Text('${(pct * 100).toInt()}%', style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 14, color: C.yellow)),
      ]),
      const SizedBox(height: 10),
      ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: LinearProgressIndicator(
          value: pct,
          backgroundColor: C.divider,
          valueColor: const AlwaysStoppedAnimation<Color>(C.yellow),
          minHeight: 9,
        ),
      ),
    ]),
  );
}
