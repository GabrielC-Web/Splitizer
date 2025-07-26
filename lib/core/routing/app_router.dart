import 'package:go_router/go_router.dart';
import 'package:splitizer/features/home/intro_screen.dart';

import '../../features/bill/bill_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/bill',
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
      path: '/intro',
      name: 'intro',
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(child: const IntroScreen()),
    ),
  ],
);
