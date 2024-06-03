import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DataViewPage extends StatefulWidget {
  const DataViewPage({super.key});

  static const String name = 'dataview';
  static const String path = '/dataview';

  @override
  State<DataViewPage> createState() => _DataViewState();
}

class _DataViewState extends State<DataViewPage> {
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
    return Column(
      children: [
        Gap(10.h),
        Text(
          'ユーザー加速度センサー',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'x : ${_userAccelerometerEvent?.x.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'y : ${_userAccelerometerEvent?.y.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'z : ${_userAccelerometerEvent?.z.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Gap(10.h),
        Text(
          '加速度センサー',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'x : ${_accelerometerEvent?.x.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'y : ${_accelerometerEvent?.y.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'z : ${_accelerometerEvent?.z.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Gap(10.h),
        Text(
          'ジャイロスコープセンサー',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'x : ${_gyroscopeEvent?.x.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'y : ${_gyroscopeEvent?.y.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'z : ${_gyroscopeEvent?.z.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Gap(10.h),
        Text(
          '磁力センサー',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'x : ${_magnetometerEvent?.x.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'y : ${_magnetometerEvent?.y.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Gap(5.w),
            Text(
              'z : ${_magnetometerEvent?.z.toStringAsFixed(1) ?? '?'}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
