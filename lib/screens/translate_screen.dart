import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../services/gravity_service.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});
  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final _inputCtrl = TextEditingController();
  String _src = 'Indonesia';
  String _tgt = 'English';
  String _result = '';
  bool _loading = false;
  bool _hasResult = false;

  static const _langs = [
    'Indonesia',
    'English',
    'Japanese',
    'Korean',
    'French',
    'German',
    'Spanish',
    'Mandarin',
  ];

  Future<void> _translate() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _loading = true;
      _hasResult = false;
      _result = '';
    });
    try {
      final res = await GravityService.translate(
          text: text, sourceLang: _src, targetLang: _tgt);
      setState(() {
        _result = res['translated'] as String? ?? '';
        _hasResult = true;
      });
    } catch (_) {
      await Future.delayed(const Duration(milliseconds: 700));
      setState(() {
        _result = 'Hello, How are you?';
        _hasResult = true;
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _swap() {
    setState(() {
      final t = _src;
      _src = _tgt;
      _tgt = t;
    });
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgPage,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Translation'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_circle_rounded,
                size: 16, color: C.yellow),
            label: const Text('Done',
                style:
                    TextStyle(color: C.textDark, fontWeight: FontWeight.w600)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: C.divider),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // ── Language selector row ──────────────────────────
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: C.bgInput,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: C.border),
              ),
              child: Row(children: [
                Expanded(
                    child: _LangDrop(
                  value: _src,
                  flag: '🇮🇩',
                  items: _langs,
                  onChanged: (v) => setState(() => _src = v!),
                )),
                // Swap button
                GestureDetector(
                  onTap: _swap,
                  child: Container(
                    width: 38,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: const Icon(Icons.swap_horiz_rounded,
                        size: 22, color: C.textGray),
                  ),
                ),
                Expanded(
                    child: _LangDrop(
                  value: _tgt,
                  flag: '🇬🇧',
                  items: _langs,
                  onChanged: (v) => setState(() => _tgt = v!),
                )),
              ]),
            ),

            const SizedBox(height: 14),

            // ── Input box ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
              decoration: BoxDecoration(
                color: C.bgInput,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: C.border),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Masukan teks disini',
                        style: TextStyle(fontSize: 11, color: C.textGray)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _inputCtrl,
                      maxLines: 5,
                      minLines: 4,
                      style: const TextStyle(
                          fontSize: 14, color: C.textDark, height: 1.5),
                      decoration: const InputDecoration(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(color: C.textGray, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ]),
            ),

            const SizedBox(height: 14),

            // ── Translate button ──────────────────────────────
            GestureDetector(
              onTap: _loading ? null : _translate,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: C.yellow,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: C.yellow.withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Center(
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.5, color: Colors.white))
                      : const Text('Translate',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: C.textDark)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Result box ────────────────────────────────────
            if (_hasResult) ...[
              const Text('Translation Result',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: C.textDark)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: C.bgInput,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: C.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(_result,
                          style: const TextStyle(
                              fontSize: 15, color: C.textDark, height: 1.5)),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: _result));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Copied to clipboard!'),
                            backgroundColor: C.yellow,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: C.yellowLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.volume_up_rounded,
                            size: 20, color: C.yellow),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

class _LangDrop extends StatelessWidget {
  final String value, flag;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _LangDrop(
      {required this.value,
      required this.flag,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: [
        Text(flag, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16, color: C.textGray),
              style: const TextStyle(
                  fontSize: 12,
                  color: C.textDark,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito'),
              items: items
                  .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ]),
    );
  }
}
