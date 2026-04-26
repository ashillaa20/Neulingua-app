import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // ✅ tambah ini
import 'theme/colors.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ FIX warning web (tanpa ubah behavior mobile)
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const NeuLinguaApp());
}

class NeuLinguaApp extends StatelessWidget {
  const NeuLinguaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState();

    return AppStateProvider(
      state: state,
      child: MaterialApp(
        title: 'NeuLingua',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),

        // 🔥 GLOBAL RESPONSIVE (TIDAK DIUBAH TAMPILAN)
        builder: (context, child) {
          final appState =
              AppStateProvider.of(context); // ✅ rename (hindari warning)
          final screenWidth = MediaQuery.of(context).size.width;

          final isMobile = appState.isMobileView || screenWidth <= 600;

          // ✅ FIX null safety TANPA UBAH UI
          final safeChild = child ?? const SizedBox();

          if (isMobile) {
            return safeChild;
          }

          return Container(
            color: const Color(0xFFE5E7EB),
            child: Center(
              child: Container(
                width: 700,
                height: double.infinity,
                color: Colors.white,
                child: safeChild, // ✅ pakai ini
              ),
            ),
          );
        },

        home: const SplashScreen(),
      ),
    );
  }
}
