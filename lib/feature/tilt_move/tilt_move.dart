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

class _TiltMovePageState extends State<TiltMovePage> {
  UserAccelerometerEvent? _userAccelerometerEvent;
  AccelerometerEvent? _accelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  MagnetometerEvent? _magnetometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
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
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('オブジェクト'),
      ],
    );
  }
}
