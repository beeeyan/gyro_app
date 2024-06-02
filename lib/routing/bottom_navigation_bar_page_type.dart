import 'package:flutter/material.dart';

import '../feature/data_view/data_view.dart';
import '../feature/tilt_move/tilt_move.dart';
import '../feature/tilt_move2.dart';

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
  trialtiltmove(
    '検討',
    '検討',
    Icons.bookmark_border_outlined,
    TrialTiltMovePage.path,
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
    if (path.startsWith(TrialTiltMovePage.path)) {
      return BottomNavigationBarPageType.trialtiltmove;
    }
    return BottomNavigationBarPageType.tiltmove;
  }
}
