import 'package:flutter/material.dart';
import '../theme/colors.dart';

// ── Yellow button ─────────────────────────────────────────────────
class YellowBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool loading;
  final double height;
  final double radius;

  const YellowBtn({
    super.key,
    required this.label,
    this.onTap,
    this.loading = false,
    this.height = 52,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: onTap != null ? C.yellow : C.yellowLight,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if (onTap != null)
              BoxShadow(
                color: C.yellow.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22, height: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.5, color: Colors.white))
              : Text(label,
                  style: TextStyle(
                    color: onTap != null ? C.textDark : C.textGray,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.3,
                  )),
        ),
      ),
    );
  }
}

// ── Input field ───────────────────────────────────────────────────
class AppInput extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? type;
  final Widget? trailing;

  const AppInput({
    super.key,
    required this.ctrl,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.type,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: C.bgInput,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: C.border),
      ),
      child: Row(children: [
        const SizedBox(width: 14),
        Icon(icon, size: 20, color: C.textGray),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            obscureText: obscure,
            keyboardType: type,
            style: const TextStyle(fontSize: 14, color: C.textDark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: C.textGray, fontSize: 14),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        if (trailing != null) ...[trailing!, const SizedBox(width: 12)],
      ]),
    );
  }
}

// ── Social outlined button ────────────────────────────────────────
class SocialBtn extends StatelessWidget {
  final Widget leading;
  final String label;
  final VoidCallback? onTap;

  const SocialBtn({super.key, required this.leading, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: C.bgInput,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: C.border, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [leading, const SizedBox(width: 10),
            Text(label, style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: C.textDark))],
        ),
      ),
    );
  }
}

// ── Bottom nav bar  (Home | Quiz | Vocabulary | Me) ───────────────
class AppBottomNav extends StatelessWidget {
  final int idx;
  final ValueChanged<int> onTap;
  const AppBottomNav({super.key, required this.idx, required this.onTap});

  static const _items = [
    _NI(Icons.home_outlined,     Icons.home_rounded,      'Home'),
    _NI(Icons.quiz_outlined,     Icons.quiz_rounded,      'Quiz'),
    _NI(Icons.menu_book_outlined,Icons.menu_book_rounded, 'Vocabulary'),
    _NI(Icons.person_outline,    Icons.person_rounded,    'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: C.white,
        border: Border(top: BorderSide(color: C.divider, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(_items.length, (i) {
              final active = idx == i;
              final item   = _items[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(active ? item.ai : item.i,
                          size: 24,
                          color: active ? C.navActive : C.navInactive),
                      const SizedBox(height: 3),
                      Text(item.l,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                              color: active ? C.navActive : C.navInactive)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NI {
  final IconData i, ai;
  final String l;
  const _NI(this.i, this.ai, this.l);
}

// ── "or" divider ──────────────────────────────────────────────────
class OrDiv extends StatelessWidget {
  const OrDiv({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider(color: C.border)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text('or', style: const TextStyle(color: C.textGray, fontSize: 13)),
      ),
      const Expanded(child: Divider(color: C.border)),
    ]);
  }
}
