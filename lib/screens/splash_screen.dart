import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _ac, curve: Curves.easeIn);
    _scale = Tween(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _ac, curve: Curves.elasticOut));
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  void _start() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = constraints.maxWidth > 600;
        final logoSize = isWeb ? 280.0 : 220.0;
        final buttonHeight = isWeb ? 60.0 : 54.0;
        final fontSize = isWeb ? 18.0 : 16.0;
        final horizontalPadding = isWeb ? 64.0 : 32.0;
        final bottomSpacing = isWeb ? 64.0 : 48.0;

        return Scaffold(
          backgroundColor: C.yellowBg,
          body: FadeTransition(
            opacity: _fade,
            child: SafeArea(
              child: isWeb
                  ? Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ── Logo ──────────────────────────────────────────
                            ScaleTransition(
                              scale: _scale,
                              child: _SplashLogo(size: logoSize),
                            ),

                            SizedBox(height: bottomSpacing),

                            // ── Start Learning button ──────────────────────────
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: InkWell(
                                onTap: _start,
                                hoverColor: C.white.withValues(alpha: 0.8),
                                splashColor: C.yellow.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: double.infinity,
                                  height: buttonHeight,
                                  decoration: BoxDecoration(
                                    color: C.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.12),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('Start Learning',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: fontSize,
                                            color: C.textDark,
                                            letterSpacing: 0.3)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(children: [
                      const Spacer(flex: 2),

                      // ── Logo ──────────────────────────────────────────
                      ScaleTransition(
                        scale: _scale,
                        child: _SplashLogo(size: logoSize),
                      ),

                      const Spacer(flex: 3),

                      // ── Start Learning button ──────────────────────────
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: InkWell(
                          onTap: _start,
                          hoverColor: C.white.withValues(alpha: 0.8),
                          splashColor: C.yellow.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text('Start Learning',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSize,
                                      color: C.textDark,
                                      letterSpacing: 0.3)),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: bottomSpacing),
                    ]),
            ),
          ),
        );
      },
    );
  }
}

// ── Logo widget ───────────────────────────────────────────────────
class _SplashLogo extends StatelessWidget {
  final double size;
  const _SplashLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    final globeSize = size * 0.9; // 200/220 ≈ 0.9
    final bubbleSize = size * 0.318; // 70/220 ≈ 0.318
    final bookWidth = size * 0.727; // 160/220 ≈ 0.727
    final bookHeight = size * 0.136; // 30/220 ≈ 0.136

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Globe background ────────────────────────────────
          Container(
            width: globeSize,
            height: globeSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.15),
            ),
            child: const Center(
              child: Icon(Icons.public_rounded, size: 120, color: Colors.white),
            ),
          ),

          // ── Chat bubble 文 (left) ───────────────────────────
          Positioned(
            left: size * 0.045, // 10/220
            bottom: size * 0.182, // 40/220
            child: _ChatBubble(
              text: '文',
              bg: const Color(0xFF374151),
              textColor: Colors.white,
              size: bubbleSize,
              fontSize: 32,
            ),
          ),

          // ── Book pages at bottom ────────────────────────────
          Positioned(
            bottom: 0,
            child: Container(
              width: bookWidth,
              height: bookHeight,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book_rounded, size: 20, color: C.yellowBg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final Color bg, textColor;
  final double size, fontSize;
  const _ChatBubble({
    required this.text,
    required this.bg,
    required this.textColor,
    required this.size,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: textColor)),
      ),
    );
  }
}
