import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared.dart';
import '../services/gravity_service.dart';
import 'language_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  void _proceed() => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const LanguageScreen()));

  Future<void> _createAccount() async {
    setState(() => _loading = true);
    try {
      await GravityService.register(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );
    } catch (_) {/* demo mode */}
    if (mounted) {
      setState(() => _loading = false);
      _proceed();
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(children: [
            const SizedBox(height: 40),

            // ── Title ─────────────────────────────────────────
            const Text('Welcome to Neulingua!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: C.textDark)),

            const SizedBox(height: 32),

            // ── Google ────────────────────────────────────────
            SocialBtn(
              leading: _GoogleIcon(),
              label: 'Sign up with Google',
              onTap: _proceed,
            ),
            const SizedBox(height: 12),

            // ── SMS ───────────────────────────────────────────
            SocialBtn(
              leading:
                  const Icon(Icons.sms_outlined, size: 20, color: C.textMid),
              label: 'Sign up with SMS',
              onTap: _proceed,
            ),

            const SizedBox(height: 28),

            // ── Divider ───────────────────────────────────────
            const OrDiv(),

            const SizedBox(height: 28),

            // ── Full name ─────────────────────────────────────
            AppInput(
              ctrl: _nameCtrl,
              hint: 'Full name',
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 14),

            // ── Password ──────────────────────────────────────
            AppInput(
              ctrl: _passCtrl,
              hint: 'Password',
              icon: Icons.lock_outline_rounded,
              obscure: _obscure,
              trailing: GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: C.textGray,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // ── Email ─────────────────────────────────────────
            AppInput(
              ctrl: _emailCtrl,
              hint: 'Email',
              icon: Icons.email_outlined,
              type: TextInputType.emailAddress,
            ),

            const SizedBox(height: 34),

            // ── Create account button ─────────────────────────
            YellowBtn(
              label: 'Create an account',
              loading: _loading,
              onTap: _createAccount,
            ),

            const SizedBox(height: 20),

            // ── Login link ────────────────────────────────────
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already got an account? ",
                  style: TextStyle(fontSize: 13, color: C.textMid)),
              GestureDetector(
                onTap: _proceed,
                child: const Text('LOGIN',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: C.yellow)),
              ),
            ]),

            const SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: C.border, width: 1.2)),
      child: const Center(
        child: Text('G',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Color(0xFF4285F4))),
      ),
    );
  }
}
