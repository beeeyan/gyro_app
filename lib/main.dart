import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/flavor.dart';
import 'routing/go_router.dart';
import 'util/logger.dart';

void main() {
  logger.i('FLAVOR : ${flavor.name}');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'GyroApp',
        theme: ThemeData(
          fontFamily: 'NotoSansJP',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: ref.watch(goRouterProvider),
      ),
    );
  }
}
