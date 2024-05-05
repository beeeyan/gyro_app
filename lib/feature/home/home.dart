import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String name = 'home';
  static const String path = '/home';

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Home'),
      );
  }
}
