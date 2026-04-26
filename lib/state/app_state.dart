import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // ── User ────────────────────────────────────────────────────
  String userName    = 'Andi';
  String userCountry = 'Indonesia';
  String userBio     = 'Speak English at beginner level';
  String userLearning= 'Learning English and Japan';
  String token       = '';
  String nativeLang  = 'Indonesia';

  // ── Stats ────────────────────────────────────────────────────
  int streakDays    = 7;
  int totalXP       = 1250;
  int lessonsCount  = 23;

  // ── Language progress ────────────────────────────────────────
  double englishPct  = 0.42;
  int    englishXP   = 113;
  double japanesePct = 0.07;
  int    japaneseXP  = 5;

  // ── Quiz ────────────────────────────────────────────────────
  int quizCorrect = 0;
  int quizTotal   = 0;

  // ── Week activity  (0=Mon … 6=Sun) ──────────────────────────
  final List<bool> weekActivity = [false, true, true, true, false, false, true];

  // ── Treat banner ─────────────────────────────────────────────
  bool treatVisible = true;

  // ── Mobile view toggle ───────────────────────────────────────
  bool isMobileView = false;

  // ── Bookmarks ────────────────────────────────────────────────
  final Set<int> bookmarks = {};

  // ── Methods ──────────────────────────────────────────────────
  void addQuizResult(int correct, int total) {
    quizCorrect  += correct;
    quizTotal    += total;
    totalXP      += correct * 10;
    lessonsCount += 1;
    if (correct == total) streakDays++;
    notifyListeners();
  }

  void toggleBookmark(int id) {
    bookmarks.contains(id) ? bookmarks.remove(id) : bookmarks.add(id);
    notifyListeners();
  }

  void dismissTreat() {
    treatVisible = false;
    notifyListeners();
  }

  void toggleMobileView() {
    isMobileView = !isMobileView;
    notifyListeners();
  }

  void markDay(int i) {
    weekActivity[i] = true;
    notifyListeners();
  }

  void addXP(int amount) {
    totalXP += amount;
    notifyListeners();
  }

  void saveProfile({required String name, required String bio}) {
    userName = name;
    userBio  = bio;
    notifyListeners();
  }
}

// ── InheritedNotifier wrapper ─────────────────────────────────────
class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext ctx) {
    final p = ctx.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(p != null, 'No AppStateProvider');
    return p!.notifier!;
  }
}
