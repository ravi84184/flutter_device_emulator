import 'package:flutter/material.dart';
import 'package:flutter_device_emulator/flutter_device_emulator.dart';
import 'package:flutter_device_emulator_example/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
      ),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Device Emulator')),
        body: DeviceEmulator(
          builder: (context) => SafeArea(child: HomePage()),
        ),
      ),
    );
  }
}
