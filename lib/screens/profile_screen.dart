import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../state/app_state.dart';
import 'splash_screen.dart';

/// Frame (Profile) — Andi's full profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    return AnimatedBuilder(
      animation: state,
      builder: (ctx, _) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 14),

            // ── Settings icon ────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => _showSettings(context, state),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: C.bgGray,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: C.border),
                  ),
                  child: const Icon(Icons.settings_outlined,
                      size: 20, color: C.textMid),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── Avatar + info ─────────────────────────────────
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Avatar with check badge
              Stack(children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFF5A623)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: C.yellow, width: 3),
                  ),
                  child: const Center(
                    child: Text('🧒', style: TextStyle(fontSize: 40)),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: C.yellow,
                      shape: BoxShape.circle,
                      border: Border.all(color: C.white, width: 2),
                    ),
                    child: const Center(
                      child: Icon(Icons.check_rounded,
                          size: 13, color: Colors.white),
                    ),
                  ),
                ),
              ]),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(state.userName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: C.textDark)),
                    const SizedBox(height: 6),
                    // Location
                    _InfoLine(
                        icon: Icons.location_on_outlined,
                        text: state.userCountry),
                    const SizedBox(height: 4),
                    _InfoLine(
                        icon: Icons.chat_bubble_outline_rounded,
                        text: state.userBio),
                    const SizedBox(height: 4),
                    _InfoLine(
                        icon: Icons.school_outlined, text: state.userLearning),
                  ],
                ),
              ),
            ]),

            const SizedBox(height: 20),

            // ── Treat friends banner (dismissible) ────────────
            if (state.treatVisible)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
                  decoration: BoxDecoration(
                    color: C.yellow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Treat your friends',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: C.textDark)),
                            SizedBox(height: 3),
                            RichText(
                              text: TextSpan(
                                style:
                                    TextStyle(fontSize: 12, color: C.textDark),
                                children: [
                                  TextSpan(text: 'Give them a '),
                                  TextSpan(
                                    text: '30-day',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(text: ' guest pass'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: state.dismissTreat,
                        child: const Icon(Icons.close_rounded,
                            size: 18, color: C.textDark),
                      ),
                    ],
                  ),
                ),
              ),

            // ── Learning section ──────────────────────────────
            const Text('Learning',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: C.textDark)),
            const SizedBox(height: 14),

            Row(children: [
              _LangCard(
                flag: '🇬🇧',
                label: 'English',
                pct: state.englishPct,
                xp: state.englishXP,
                color: const Color(0xFFEFF6FF),
              ),
              const SizedBox(width: 12),
              _LangCard(
                flag: '🇯🇵',
                label: 'Japan',
                pct: state.japanesePct,
                xp: state.japaneseXP,
                color: const Color(0xFFFFF1F2),
                hasBorder: false,
              ),
              const SizedBox(width: 12),
              // Add card
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 88,
                  height: 100,
                  decoration: BoxDecoration(
                    color: C.bgGray,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: C.border, width: 1.5),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded, size: 26, color: C.textGray),
                      SizedBox(height: 4),
                      Text('Add',
                          style: TextStyle(
                              fontSize: 11,
                              color: C.textGray,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 28),

            // ── Days learned ─────────────────────────────────
            const Text('Days learned',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: C.textDark)),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                final active = state.weekActivity[i];
                // Thu (3) and Sun (6) are filled in Figma
                final isSpecial = i == 3 || i == 6;
                return GestureDetector(
                  onTap: () => state.markDay(i),
                  child: Column(children: [
                    Text(_days[i],
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isSpecial ? FontWeight.w700 : FontWeight.w400,
                            color: isSpecial ? C.yellow : C.textGray)),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: isSpecial ? 38 : 32,
                      height: isSpecial ? 38 : 32,
                      decoration: BoxDecoration(
                        color: active
                            ? C.yellow
                            : (isSpecial ? C.yellowLight : C.divider),
                        shape: BoxShape.circle,
                        border: isSpecial && !active
                            ? Border.all(color: C.yellow, width: 1.5)
                            : null,
                        boxShadow: active
                            ? [
                                BoxShadow(
                                    color: C.yellow.withOpacity(0.3),
                                    blurRadius: 8)
                              ]
                            : [],
                      ),
                      child: active
                          ? const Center(
                              child: Icon(Icons.check_rounded,
                                  size: 16, color: Colors.white))
                          : null,
                    ),
                  ]),
                );
              }),
            ),

            const SizedBox(height: 28),

            // ── Stats row ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: C.yellowLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: C.yellow.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatCol('🔥', '${state.streakDays}', 'Streak'),
                  Container(
                      width: 1, height: 44, color: C.yellow.withOpacity(0.3)),
                  _StatCol('⭐', '${state.totalXP}', 'Total XP'),
                  Container(
                      width: 1, height: 44, color: C.yellow.withOpacity(0.3)),
                  _StatCol('📚', '${state.lessonsCount}', 'Lessons'),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: C.bgGray,
                  foregroundColor: C.textDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Quit',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),

            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }

  void _showSettings(BuildContext context, AppState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: C.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _SettingsSheet(state: state),
    );
  }
}

// ── Info line ─────────────────────────────────────────────────────
class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(children: [
        Icon(icon, size: 13, color: C.textGray),
        const SizedBox(width: 5),
        Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 12, color: C.textMid),
                maxLines: 1,
                overflow: TextOverflow.ellipsis)),
      ]);
}

// ── Language card ─────────────────────────────────────────────────
class _LangCard extends StatelessWidget {
  final String flag, label;
  final double pct;
  final int xp;
  final Color color;
  final bool hasBorder;
  const _LangCard(
      {required this.flag,
      required this.label,
      required this.pct,
      required this.xp,
      required this.color,
      this.hasBorder = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: hasBorder ? Border.all(color: C.border) : null,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(flag, style: const TextStyle(fontSize: 22)),
        const Spacer(),
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: C.textDark)),
        Text('${(pct * 100).toInt()}%',
            style: const TextStyle(fontSize: 11, color: C.textGray)),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: LinearProgressIndicator(
            value: pct,
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(C.yellow),
            minHeight: 4,
          ),
        ),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.trending_up_rounded, size: 10, color: C.yellow),
          const SizedBox(width: 2),
          Text('$xp',
              style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w700, color: C.yellow)),
        ]),
      ]),
    );
  }
}

// ── Stat column ───────────────────────────────────────────────────
class _StatCol extends StatelessWidget {
  final String emoji, value, label;
  const _StatCol(this.emoji, this.value, this.label);

  @override
  Widget build(BuildContext context) => Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 16, color: C.textDark)),
        Text(label, style: const TextStyle(fontSize: 11, color: C.textMid)),
      ]);
}

// ── Settings bottom sheet ─────────────────────────────────────────
class _SettingsSheet extends StatefulWidget {
  final AppState state;
  const _SettingsSheet({required this.state});

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late TextEditingController _name;
  late TextEditingController _bio;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.state.userName);
    _bio = TextEditingController(text: widget.state.userBio);
  }

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _save() {
    widget.state.saveProfile(name: _name.text.trim(), bio: _bio.text.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Handle
        Center(
            child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
              color: C.border, borderRadius: BorderRadius.circular(2)),
        )),
        const SizedBox(height: 20),
        Row(children: [
          const Text('Edit Profile',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: C.textDark)),
          const Spacer(),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close_rounded, color: C.textGray)),
        ]),
        const SizedBox(height: 20),
        _buildField('Display Name', _name, 'Your name'),
        const SizedBox(height: 14),
        _buildField('Bio', _bio, 'About you'),
        const SizedBox(height: 24),

        // ── Mobile View Toggle ──────────────────────────────
        Row(children: [
          const Text('Mobile View',
              style: TextStyle(
                  fontSize: 14,
                  color: C.textDark,
                  fontWeight: FontWeight.w600)),
          const Spacer(),
          Switch(
            value: widget.state.isMobileView,
            onChanged: (value) => widget.state.toggleMobileView(),
            activeThumbColor: C.yellow,
            activeTrackColor: C.yellow.withValues(alpha: 0.3),
          ),
        ]),
        const SizedBox(height: 8),
        const Text('Enable mobile layout on web/desktop',
            style: TextStyle(fontSize: 12, color: C.textGray)),

        const SizedBox(height: 24),
        GestureDetector(
          onTap: _save,
          child: Container(
            width: double.infinity,
            height: 52,
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
              child: Text('Save Changes',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: C.textDark)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, String hint) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12, color: C.textGray, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextField(
        controller: ctrl,
        style: const TextStyle(fontSize: 14, color: C.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: C.textGray),
          filled: true,
          fillColor: C.bgInput,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: C.border)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: C.border)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: C.yellow, width: 1.5)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    ]);
  }
}
