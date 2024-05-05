import 'package:flutter/material.dart';

import '../feature/home/home.dart';
import '../feature/sample1.dart';
import '../feature/sample2.dart';

enum BottomNavigationBarPageType {
  home(
    'ホーム',
    'ホーム',
    Icons.home,
    HomePage.path,
  ),
  sample1(
    'サンプル1',
    'サンプル1',
    Icons.bookmark_border_outlined,
    Sample1Page.path,
  ),
  sample2(
    'サンプル2',
    'サンプル2',
    Icons.bookmark_border_outlined,
    Sample2Page.path,
  );

  const BottomNavigationBarPageType(
    this.title,
    this.bottomNavBarlabel,
    this.icon,
    this.path,
  );

  final String title;
  final String bottomNavBarlabel;
  final IconData icon;
  final String path;

  static BottomNavigationBarPageType pageTypeByPath(String path) {
    // 詳細画面に遷移してもボトムナビゲーションを表示させる場合を考慮して
    // startsWithで処理する。
    if (path.startsWith(HomePage.path)) {
      return BottomNavigationBarPageType.home;
    }
    if (path.startsWith(Sample1Page.path)) {
      return BottomNavigationBarPageType.sample1;
    }
    if (path.startsWith(Sample2Page.path)) {
      return BottomNavigationBarPageType.sample2;
    }
    return BottomNavigationBarPageType.home;
  }
}
