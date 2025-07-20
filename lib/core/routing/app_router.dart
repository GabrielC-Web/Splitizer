import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
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
      builder: (context, state) => const BillScreen(),
    ),
  ],
);
