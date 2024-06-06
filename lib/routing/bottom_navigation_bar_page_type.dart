import 'package:flutter/material.dart';

import '../feature/data_view/data_view.dart';
import '../feature/forge2d/forge2d_sample.dart';
import '../feature/tilt_move/tilt_move.dart';

enum BottomNavigationBarPageType {
  tiltmove(
    '傾きで要素が動く',
    '傾きで要素が動く',
    Icons.home,
    TiltMovePage.path,
  ),
  dataview(
    'センサーから取得したデータの確認',
    'センサーから取得したデータの確認',
    Icons.bookmark_border_outlined,
    DataViewPage.path,
  ),
  forge2d(
    '検討',
    '検討',
    Icons.bookmark_border_outlined,
    Forge2dPage.path,
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
      return BottomNavigationBarPageType.tiltmove;
    }
    if (path.startsWith(DataViewPage.path)) {
      return BottomNavigationBarPageType.dataview;
    }
    if (path.startsWith(Forge2dPage.path)) {
      return BottomNavigationBarPageType.forge2d;
    }
    return BottomNavigationBarPageType.tiltmove;
  }
}
