import 'package:flutter/material.dart';

import '../feature/sample1.dart';
import '../feature/sample2.dart';
import '../feature/tilt_move/tilt_move.dart';

enum BottomNavigationBarPageType {
  home(
    '傾きで要素が動く',
    '傾きで要素が動く',
    Icons.home,
    TiltMovePage.path,
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
    if (path.startsWith(TiltMovePage.path)) {
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
