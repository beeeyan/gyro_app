import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../feature/data_view/data_view.dart';
import '../feature/root.dart';
import '../feature/sample2.dart';
import '../feature/tilt_move/tilt_move.dart';
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
    initialLocation: TiltMovePage.path,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => RootPage(child: child),
        routes: [
          GoRoute(
            path: TiltMovePage.path,
            name: TiltMovePage.name,
            pageBuilder: (context, state) => buildNoAnimationTransition(
              const TiltMovePage(),
            ),
          ),
          GoRoute(
            path: DataViewPage.path,
            name: DataViewPage.name,
            pageBuilder: (context, state) => buildNoAnimationTransition(
              const DataViewPage(),
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
