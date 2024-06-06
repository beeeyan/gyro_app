import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../gen/assets.gen.dart';

class TiltMovePage extends StatefulWidget {
  const TiltMovePage({super.key});

  static const String name = 'tiltmove';
  static const String path = '/tiltmove';

  @override
  State<TiltMovePage> createState() => _TiltMovePageState();
}

class _TiltMovePageState extends State<TiltMovePage>
    with SingleTickerProviderStateMixin {
  UserAccelerometerEvent? _userAccelerometerEvent;
  AccelerometerEvent? _accelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  MagnetometerEvent? _magnetometerEvent;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  // widgetの位置
  double widgetX = 0;
  double widgetY = 0;
  final boxSize = 100.0;

  @override
  void initState() {
    super.initState();

    // デバイスサイズの取得
    final view = PlatformDispatcher.instance.views.first;
    final viewWidth = view.physicalSize.shortestSide / view.devicePixelRatio;
    final viewHeight = view.physicalSize.longestSide / view.devicePixelRatio -
        kBottomNavigationBarHeight -
        kToolbarHeight;
    // 初期値
    widgetX = viewWidth / 2;
    widgetY = 0;

    _streamSubscriptions
      ..add(
        userAccelerometerEventStream().listen(
          (UserAccelerometerEvent event) {
            setState(() {
              _userAccelerometerEvent = event;
            });
          },
          onError: (e) {
            showDialog<Widget>(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('センサーが見つかりません'),
                  content: Text(
                    '使用中のデバイスでは「ユーザー加速度センサー」が搭載されていない可能性があります',
                  ),
                );
              },
            );
          },
          cancelOnError: true,
        ),
      )
      ..add(
        accelerometerEventStream().listen(
          (AccelerometerEvent event) {
            setState(() {
              _accelerometerEvent = event;
              // 新しい位置を計算
              widgetX -= event.x * 20;
              widgetY += event.y * 20;
              // 画面外に出ないようにする
              if (widgetX < 0) {
                widgetX = 0;
              }
              if (widgetY < 0) {
                widgetY = 0;
              }
              if (widgetX > viewWidth - boxSize) {
                widgetX = viewWidth - boxSize;
              }
              if (widgetY > viewHeight - boxSize - kBottomNavigationBarHeight) {
                widgetY = viewHeight - boxSize - kBottomNavigationBarHeight;
              }
            });
          },
          onError: (e) {
            showDialog<Widget>(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('センサーが見つかりません'),
                  content: Text(
                    '使用中のデバイスでは「加速度センサー」が搭載されていない可能性があります',
                  ),
                );
              },
            );
          },
          cancelOnError: true,
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.expand(),
        Positioned(
          left: widgetX,
          top: widgetY,
          child: Container(
            height: boxSize,
            width: boxSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(Assets.images.icon.path),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
