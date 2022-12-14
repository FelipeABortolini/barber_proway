import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'presenter/edit_profile/edit_profile_body.dart';
import 'presenter/splash/splashscreen.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}
// void main() {
//   runApp(
//     const MyApp(),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting();
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Barber app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
