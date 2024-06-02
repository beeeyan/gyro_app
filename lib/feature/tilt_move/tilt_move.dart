import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('ユーザー加速度センサー'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x : ${_userAccelerometerEvent?.x.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('y : ${_userAccelerometerEvent?.y.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('z : ${_userAccelerometerEvent?.z.toStringAsFixed(1) ?? '?'}'),
          ],
        ),
        Gap(5.h),
        const Text('加速度センサー'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x : ${_accelerometerEvent?.x.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('y : ${_accelerometerEvent?.y.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('z : ${_accelerometerEvent?.z.toStringAsFixed(1) ?? '?'}'),
          ],
        ),
        Gap(5.h),
        const Text('ジャイロスコープセンサー'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x : ${_gyroscopeEvent?.x.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('y : ${_gyroscopeEvent?.y.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('z : ${_gyroscopeEvent?.z.toStringAsFixed(1) ?? '?'}'),
          ],
        ),
        Gap(5.h),
        const Text('磁力センサー'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('x : ${_magnetometerEvent?.x.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('y : ${_magnetometerEvent?.y.toStringAsFixed(1) ?? '?'}'),
            Gap(5.w),
            Text('z : ${_magnetometerEvent?.z.toStringAsFixed(1) ?? '?'}'),
          ],
        ),
      ],
    );
  }
}
