import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../feature/home/home.dart';
import '../feature/root.dart';
import '../feature/sample1.dart';
import '../feature/sample2.dart';
import 'no_animation_transition.dart';

final rootNavigatorKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'root'),
);

final shellNavigatorKeyProvider = Provider(
  (ref) => GlobalKey<NavigatorState>(debugLabel: 'shell'),
);

final goRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = ref.watch(rootNavigatorKeyProvider);
  final shellNavigatorKey = ref.watch(shellNavigatorKeyProvider);
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: HomePage.path,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => RootPage(child: child),
        routes: [
          GoRoute(
            path: HomePage.path,
            name: HomePage.name,
            pageBuilder: (context, state) => buildNoAnimationTransition(
              const HomePage(),
            ),
          ),
          GoRoute(
            path: Sample1Page.path,
            name: Sample1Page.name,
            pageBuilder: (context, state) => buildNoAnimationTransition(
              const Sample1Page(),
            ),
          ),
          GoRoute(
            path: Sample2Page.path,
            name: Sample2Page.name,
            pageBuilder: (context, state) => buildNoAnimationTransition(
              const Sample2Page(),
            ),
          ),
        ],
      ),
    ],
  );
},);
