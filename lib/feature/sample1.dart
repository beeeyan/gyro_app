import 'package:flutter/material.dart';

class Sample1Page extends StatelessWidget {
  const Sample1Page({super.key});

  static const String name = 'sample1';
  static const String path = '/sample1';

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Sample 1'),
      );
  }
}
