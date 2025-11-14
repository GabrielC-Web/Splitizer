import 'package:go_router/go_router.dart';
import 'package:splitizer/features/home/intro_screen.dart';

import '../../features/bill/bill_form_screen.dart';
import '../../features/bill/bill_screen.dart';
import '../../features/bill/bill_screen_2.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/bill2',
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: 'home',
    //   builder: (context, state) => const HomeScreen(),
    // ),
    GoRoute(
      path: '/bill',
      name: 'bill',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: const BillScreen()),
    ),
    GoRoute(
      path: '/bill2',
      name: 'bill2',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: const BillScreen2()),
    ),
    GoRoute(
      path: '/form',
      name: 'form',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: const BillFormScreen()),
    ),
    GoRoute(
      path: '/intro',
      name: 'intro',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: const IntroScreen()),
    ),
  ],
);
