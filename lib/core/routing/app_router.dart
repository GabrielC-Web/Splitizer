import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitizer/features/home/intro_screen.dart';

import '../../features/bill/bill_screen.dart';

const String _kHasSeenIntroKey = 'hasSeenIntro';

Future<bool> _checkIntroStatus() async {
  final prefs = await SharedPreferences.getInstance();
  // If _kHasSeenIntroKey exists and is true, then intro has been seen.
  // Otherwise, (if null or false), it hasn't been seen.
  return prefs.getBool(_kHasSeenIntroKey) ?? false;
}

final GoRouter appRouter = GoRouter(
  initialLocation: _checkIntroStatus == true ? '/bill' : '/intro',
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen(),
    // ),
    GoRoute(
      path: '/bill',
      name: 'bill',
      builder: (context, state) => const BillScreen(),
    ),
    GoRoute(
      path: '/intro',
      name: 'intro',
      builder: (context, state) => const IntroScreen(),
    ),
  ],
);
