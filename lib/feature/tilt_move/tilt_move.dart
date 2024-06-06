import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../gen/assets.gen.dart';

class TiltMovePage extends StatefulWidget {
  const TiltMovePage({super.key});

  static const String name = 'tiltmove';
  static const String path = '/tiltmove';

  @override
  State<TiltMovePage> createState() => _TiltMovePageState();
}

class _TiltMovePageState extends State<TiltMovePage>{
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  // widgetの位置
  double widgetX = 0;
  double widgetY = 0;
  // 今の加速度
  double accelX = 0;
  double accelY = 0;
  // 前回の加速度
  double preAccelX = 0;
  double preAccelY = 0;

  // 速度
  double velX = 0;
  double velY = 0;
  Timer? _timer;
  // 跳ね返り係数
  double bounceFactor = 0;
  bool isPhysics = false;
  bool isRotate = false;
  final timerMilliseconds = 10;
  final buttonArea = 100.0;
  final boxSize = 80.0;

  @override
  void initState() {
    super.initState();

    // デバイスサイズの取得
    final view = PlatformDispatcher.instance.views.first;
    final viewWidth = view.physicalSize.shortestSide / view.devicePixelRatio;
    final viewHeight = view.physicalSize.longestSide / view.devicePixelRatio -
        kBottomNavigationBarHeight -
        kToolbarHeight -
        buttonArea;
    // 初期値
    widgetX = viewWidth / 2;
    widgetY = 0;

    _streamSubscriptions.add(
      accelerometerEventStream().listen(
        (AccelerometerEvent event) {
          setState(() {
            accelX = event.x;
            accelY = event.y;
            if (!isPhysics) {
              // 新しい位置を計算
              widgetX -= accelX * 20;
              widgetY += accelY * 20;
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
            }
          });
          // 物理演算で計算するためにTimerで値を更新する。
          _timer = Timer.periodic(Duration(milliseconds: timerMilliseconds),
              (Timer timer) {
            if (isPhysics) {
              final seconds = timerMilliseconds / 1000;
              // 速度の更新
              velX -= accelX * seconds;
              velY += accelY * seconds;

              widgetX += velX * seconds + 1 / 2 * preAccelX * pow(seconds, 2);
              widgetY += velY * seconds + 1 / 2 * preAccelY * pow(seconds, 2);

              preAccelX = accelX;
              preAccelY = accelY;

              // // 画面外に出ないようにする
              if (widgetX < 0) {
                widgetX = 0;
                velX *= bounceFactor;
                preAccelX = 0;
              }
              if (widgetY < 0) {
                widgetY = 0;
                velY *= bounceFactor;
                preAccelY = 0;
              }
              if (widgetX > viewWidth - boxSize) {
                widgetX = viewWidth - boxSize;
                velX *= bounceFactor;
                preAccelX = 0;
              }
              if (widgetY > viewHeight - boxSize - kBottomNavigationBarHeight) {
                widgetY = viewHeight - boxSize - kBottomNavigationBarHeight;
                velY *= bounceFactor;
                preAccelY = 0;
              }
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
    _timer?.cancel();
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    //　傾き取得
    final rotationAngle = atan2(accelY, accelX);

    return Column(
      children: [
        SizedBox(
          height: buttonArea,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150.w, 30),
                    ),
                    onPressed: isPhysics
                        ? () {
                            setState(() {
                              isPhysics = false;
                              bounceFactor = 0.0;
                            });
                          }
                        : null,
                    child: const Text('定数を乗算'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150.w, 30),
                    ),
                    onPressed: !isPhysics
                        ? () {
                            setState(() {
                              isPhysics = !isPhysics;
                            });
                          }
                        : null,
                    child: const Text('等加速度運動'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150.w, 30),
                    ),
                    onPressed: isPhysics
                        ? () {
                            setState(() {
                              if (bounceFactor < 0) {
                                bounceFactor = 0;
                              } else {
                                bounceFactor = - 0.85;
                              }
                            });
                          }
                        : null,
                    child: Text(
                      bounceFactor < 0 ? '反発係数なし' : '反発係数あり',
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(150.w, 30),
                    ),
                    onPressed: () {
                      setState(() {
                        isRotate = !isRotate;
                      });
                    },
                    child: Text(isRotate ? '回転無効' : '回転有効'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                left: widgetX,
                top: widgetY,
                child: Transform.rotate(
                  angle: isRotate ? rotationAngle : 0,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
