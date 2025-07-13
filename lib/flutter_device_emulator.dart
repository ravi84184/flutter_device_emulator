/// A Flutter package that provides a device emulator widget for testing and previewing
/// applications across different device types, orientations, themes, and text directions.
///
/// This library exports the main [DeviceEmulator] widget which allows developers to:
/// - Preview their app on different device frames (iOS, Android, etc.)
/// - Toggle between light and dark themes
/// - Switch between portrait and landscape orientations
/// - Test right-to-left (RTL) text direction support
/// - Capture screenshots of the emulated device
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter_device_emulator/flutter_device_emulator.dart';
///
/// DeviceEmulator(
///   builder: (context) => MyApp(),
///   enableThemeToggle: true,
///   enableOrientationToggle: true,
///   enableLanguageToggle: true,
/// )
/// ```
library;

export 'src/device_emulator.dart';
