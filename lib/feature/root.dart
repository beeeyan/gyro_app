import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/bottom_navigation_bar_page_type.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pageType = _calculatePageType(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageType.title),
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageType.index,
        onTap: (index) {
          final pageType = BottomNavigationBarPageType.values[index];
          GoRouter.of(context).go(pageType.path);
        },
        items: [
          for (final pageType in BottomNavigationBarPageType.values) ...[
            BottomNavigationBarItem(
              icon: Icon(pageType.icon),
              label: pageType.title,
            ),
          ],
        ],
      ),
    );
  }

  static BottomNavigationBarPageType _calculatePageType(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    return BottomNavigationBarPageType.pageTypeByPath(location);
  }
}
