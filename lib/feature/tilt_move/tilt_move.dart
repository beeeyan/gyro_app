import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  late AnimationController _animationController;
  // ジェネリクスの中は「_animation.value」で取得できる値の型
  late Animation<double> _animation;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    // final height = MediaQuery.sizeOf(context).height * 0.8;
    // final width = MediaQuery.sizeOf(context).width * 0.8;

    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
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
            // _animationController.animateWith(
            //   GravitySimulation(
            //     event.y * 100,
            //     0,
            //     300,
            //     0,
            //   ),
            // );
            setState(() {
              _accelerometerEvent = event;
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
      )
      ..add(
        gyroscopeEventStream().listen(
          (GyroscopeEvent event) {
            setState(() {
              _gyroscopeEvent = event;
            });
          },
          onError: (e) {
            showDialog<Widget>(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('センサーが見つかりません'),
                  content: Text(
                    '使用中のデバイスでは「ジャイロスコープセンサー」が搭載されていない可能性があります',
                  ),
                );
              },
            );
          },
        ),
      )
      ..add(
        magnetometerEventStream().listen(
          (MagnetometerEvent event) {
            setState(() {
              _magnetometerEvent = event;
            });
          },
          onError: (e) {
            showDialog<Widget>(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('センサーが見つかりません'),
                  content: Text(
                    '使用中のデバイスでは「磁力センサー」が搭載されていない可能性があります',
                  ),
                );
              },
            );
          },
        ),
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // thisの参照はbuildの中でしかできない。
    const boxSize = 20.0;
    final height = MediaQuery.sizeOf(context).height * 0.8;
    final width = MediaQuery.sizeOf(context).width * 0.8;
    return Stack(
      children: [
        const SizedBox.expand(),
        Positioned(
          left: width/2 + (_userAccelerometerEvent?.x ?? 0) * 20,
          top: height/2 - (_userAccelerometerEvent?.y ?? 0) * 20,
          child: Container(
            height: boxSize,
            width: boxSize,
            color: Colors.red.withOpacity(0.54),
          ),
        ),
        // AnimatedBuilder(
        //   animation: _animationController,
        //   builder: (BuildContext context, Widget? child) {
        //     return Positioned(
        //       left: 0,
        //       top: _animation.value * (height - boxSize),
        //       child: Container(
        //         height: boxSize,
        //         width: boxSize,
        //         color: Colors.red.withOpacity(0.54),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
