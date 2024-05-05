import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> buildNoAnimationTransition(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    // 'Duration.zeroとすることでアニメーションなしを実装
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
