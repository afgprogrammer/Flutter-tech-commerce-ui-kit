import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'all_screens_demo.dart';

void main() {
  runApp(const ComoApp());
}

class ComoApp extends StatelessWidget {
  const ComoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Como - E-commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AllScreensDemo(),
    );
  }
}
