import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

enum AppTheme {
  light,
  dark,
}

class _MyAppState extends State<MyApp> {
  AppTheme _currentTheme = AppTheme.light;

  ThemeData _getTheme() {
    switch (_currentTheme) {
      case AppTheme.light:
        return ThemeData.light();
      case AppTheme.dark:
        return ThemeData.dark();
      default:
        return ThemeData.light();
    }
  }

  void _changeTheme(AppTheme theme) {
    setState(() {
      _currentTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Themes Example',
      theme: _getTheme(),
      home: ThemeSelectionPage(
        currentTheme: _currentTheme,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}

class ThemeSelectionPage extends StatelessWidget {
  final AppTheme currentTheme;
  final Function(AppTheme) onThemeChanged;

  const ThemeSelectionPage({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => onThemeChanged(AppTheme.light),
              child: const Text('Light Theme'),
            ),
            TextButton(
              onPressed: () => onThemeChanged(AppTheme.dark),
              child: const Text('Dark Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
