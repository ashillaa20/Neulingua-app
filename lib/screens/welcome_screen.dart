import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgPage,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ── Illustration ─────────────────────────────────
              Expanded(
                flex: 6,
                child: Center(child: _StudentIllustration()),
              ),

              // ── Title ────────────────────────────────────────
              const Text('Welcome to Neulingua',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: C.textDark,
                      height: 1.2)),

              const SizedBox(height: 14),

              // ── Subtitle ─────────────────────────────────────
              const Text(
                "The smart competitive ones, or those who look for the fun "
                "side of everything, will have a great learning experience here. "
                "Every step you take, any progress you make, SpeakUp has a reward "
                "to encourage your achievement.",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 12.5, color: C.textMid, height: 1.65),
              ),

              const SizedBox(height: 36),

              // ── Let's go button ───────────────────────────────
              YellowBtn(
                label: "Let's go!",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen())),
              ),

              const SizedBox(height: 16),

              // ── Already got account ───────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already got an account? ",
                    style: TextStyle(fontSize: 13, color: C.textMid)),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('LOGIN',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: C.yellow)),
                ),
              ]),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Student illustration ──────────────────────────────────────────
class _StudentIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 280,
      child: Stack(clipBehavior: Clip.none, children: [
        // ── Background circle ────────────────────────────────
        Positioned(
          left: 30,
          right: 30,
          bottom: 30,
          child: Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4FF),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // ── Desk ─────────────────────────────────────────────
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E0D8),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),

        // ── Laptop on desk ───────────────────────────────────
        Positioned(
          bottom: 30,
          left: 60,
          child: _Laptop(),
        ),

        // ── Globe ────────────────────────────────────────────
        Positioned(
          bottom: 28,
          right: 55,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7CFF).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.public_rounded,
                  size: 28, color: Color(0xFF6B7CFF)),
            ),
          ),
        ),

        // ── Person ───────────────────────────────────────────
        Positioned(
          bottom: 28,
          left: 100,
          child: _StudyPerson(),
        ),

        // ── Floating graduation cap ───────────────────────────
        Positioned(
          top: 20,
          left: 30,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)
              ],
            ),
            child: const Text('🎓', style: TextStyle(fontSize: 20)),
          ),
        ),

        // ── Floating bulb ────────────────────────────────────
        Positioned(
          top: 10,
          right: 30,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: C.yellowLight,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: C.yellow.withOpacity(0.2), blurRadius: 12)
              ],
            ),
            child:
                const Icon(Icons.lightbulb_rounded, size: 20, color: C.yellow),
          ),
        ),

        // ── Paper airplane ────────────────────────────────────
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.send_rounded,
                size: 16, color: Color(0xFF0EA5E9)),
          ),
        ),
      ]),
    );
  }
}

class _Laptop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // Screen
      Container(
        width: 100,
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF2D3748),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _Bar(w: 60, c: C.yellow),
            const SizedBox(height: 4),
            _Bar(w: 44, c: Colors.white.withOpacity(0.3)),
            const SizedBox(height: 4),
            _Bar(w: 52, c: Colors.white.withOpacity(0.3)),
          ]),
        ),
      ),
      // Base
      Container(
        width: 110,
        height: 6,
        decoration: BoxDecoration(
          color: const Color(0xFF4A5568),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
        ),
      ),
    ]);
  }
}

class _Bar extends StatelessWidget {
  final double w;
  final Color c;
  const _Bar({required this.w, required this.c});
  @override
  Widget build(BuildContext context) => Container(
      width: w,
      height: 5,
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(2)));
}

class _StudyPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // Head
      Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
            color: Color(0xFFFFD6A5), shape: BoxShape.circle),
        child: const Center(child: Text('😊', style: TextStyle(fontSize: 18))),
      ),
      const SizedBox(height: 2),
      // Body (blue top)
      Container(
        width: 44,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF6B7CFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
            child: Icon(Icons.person_rounded, color: Colors.white, size: 28)),
      ),
    ]);
  }
}
