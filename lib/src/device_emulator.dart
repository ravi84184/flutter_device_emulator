import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:device_frame/device_frame.dart' hide DeviceType;
import 'dart:typed_data';

import '../screenshot_saver_stub.dart'
    if (dart.library.html) '../screenshot_saver_web.dart';

/// A widget that provides a device emulator for testing and previewing Flutter applications.
///
/// The [DeviceEmulator] widget wraps your application in a device frame and provides
/// interactive controls to test different device configurations, themes, orientations,
/// and text directions. This is particularly useful for:
///
/// - **Device Testing**: Preview your app on different device types (iPhone, Android, etc.)
/// - **Theme Testing**: Toggle between light and dark themes to ensure proper theming
/// - **Orientation Testing**: Test both portrait and landscape orientations
/// - **RTL Support**: Test right-to-left text direction for internationalization
/// - **Screenshot Capture**: Take high-quality screenshots of your app in different states
///
/// ## Features
///
/// - **Device Frame**: Realistic device frames with proper screen dimensions
/// - **Interactive Controls**: Floating control panel with device selector and toggles
/// - **Theme Switching**: Instant switching between light and dark themes
/// - **Orientation Toggle**: Switch between portrait and landscape modes
/// - **Text Direction**: Test RTL (right-to-left) text direction support
/// - **Screenshot Capture**: Save high-resolution screenshots of the emulated device
///
/// ## Example
///
/// ```dart
/// import 'package:flutter_device_emulator/flutter_device_emulator.dart';
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: DeviceEmulator(
///         builder: (context) => MyHomePage(),
///         enableThemeToggle: true,
///         enableOrientationToggle: true,
///         enableLanguageToggle: true,
///       ),
///     );
///   }
/// }
/// ```
class DeviceEmulator extends StatefulWidget {
  /// A builder function that creates the widget tree to be displayed inside the device frame.
  ///
  /// This is typically your main application widget or a specific screen you want to test.
  /// The builder receives a [BuildContext] and should return the widget to be rendered
  /// within the device emulator.
  ///
  /// ## Example
  ///
  /// ```dart
  /// DeviceEmulator(
  ///   builder: (context) => MyHomePage(),
  /// )
  /// ```
  final WidgetBuilder builder;

  /// Whether to enable the theme toggle control in the device emulator.
  ///
  /// When `true` (default), users can toggle between light and dark themes
  /// using the theme button in the control panel. When `false`, the theme
  /// toggle button is hidden and the app uses the default theme.
  final bool enableThemeToggle;

  /// Whether to enable the orientation toggle control in the device emulator.
  ///
  /// When `true` (default), users can toggle between portrait and landscape
  /// orientations using the orientation button in the control panel. When `false`,
  /// the orientation toggle button is hidden and the app uses the default orientation.
  final bool enableOrientationToggle;

  /// Whether to enable the language/text direction toggle control in the device emulator.
  ///
  /// When `true` (default), users can toggle between left-to-right (LTR) and
  /// right-to-left (RTL) text directions using the text direction button in the
  /// control panel. This is useful for testing internationalization support.
  /// When `false`, the text direction toggle button is hidden.
  final bool enableLanguageToggle;

  /// Creates a device emulator widget.
  ///
  /// The [builder] parameter is required and should provide the widget tree
  /// to be displayed inside the device frame. All other parameters are optional
  /// and control which interactive features are available in the emulator.
  ///
  /// ## Parameters
  ///
  /// - [key] - The widget key for this widget
  /// - [builder] - A builder function that creates the widget to display in the device frame
  /// - [enableThemeToggle] - Whether to show the theme toggle control (default: true)
  /// - [enableOrientationToggle] - Whether to show the orientation toggle control (default: true)
  /// - [enableLanguageToggle] - Whether to show the text direction toggle control (default: true)
  ///
  /// ## Example
  ///
  /// ```dart
  /// DeviceEmulator(
  ///   key: Key('my-device-emulator'),
  ///   builder: (context) => MyApp(),
  ///   enableThemeToggle: true,
  ///   enableOrientationToggle: false, // Disable orientation toggle
  ///   enableLanguageToggle: true,
  /// )
  /// ```
  const DeviceEmulator({
    super.key,
    required this.builder,
    this.enableThemeToggle = true,
    this.enableOrientationToggle = true,
    this.enableLanguageToggle = true,
  });

  @override
  State<DeviceEmulator> createState() => _DeviceEmulatorState();
}

class _DeviceEmulatorState extends State<DeviceEmulator> {
  ThemeMode _themeMode = ThemeMode.light;
  TextDirection _textDirection = TextDirection.ltr;
  Orientation _orientation = Orientation.portrait;
  late DeviceInfo _selectedDevice = Devices.ios.iPhone16ProMax;
  final GlobalKey _screenshotKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Device area
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Center(
              child: RepaintBoundary(
                key: _screenshotKey,
                child: _buildDevice(_selectedDevice),
              ),
            ),
          ),
        ),
        // Floating controls card at left bottom
        Positioned(
          left: 24,
          bottom: 24,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 380),
            child: _buildControls(),
          ),
        ),
      ],
    );
  }

  Widget _buildDevice(DeviceInfo device) {
    return DeviceFrame(
      device: device,
      orientation: _orientation,
      isFrameVisible: true,
      screen: Theme(
        data: _themeMode == ThemeMode.light
            ? ThemeData.light()
            : ThemeData.dark(),
        child: Directionality(
          textDirection: _textDirection,
          child: Builder(builder: widget.builder),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withAlpha(30), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              // Device selector
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_android, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  DropdownButton<DeviceInfo>(
                    value: _selectedDevice,
                    onChanged: (DeviceInfo? newDevice) {
                      if (newDevice != null) {
                        setState(() {
                          _selectedDevice = newDevice;
                        });
                      }
                    },
                    items: Devices.all.map((device) {
                      return DropdownMenuItem<DeviceInfo>(
                        value: device,
                        child: Text(device.name),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Controls row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.enableThemeToggle)
                    Tooltip(
                      message: 'Toggle Theme',
                      child: IconButton(
                        icon: Icon(
                          _themeMode == ThemeMode.dark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setState(() {
                            _themeMode = _themeMode == ThemeMode.dark
                                ? ThemeMode.light
                                : ThemeMode.dark;
                          });
                        },
                      ),
                    ),
                  if (widget.enableOrientationToggle)
                    Tooltip(
                      message: 'Toggle Orientation',
                      child: IconButton(
                        icon: Icon(
                          _orientation == Orientation.portrait
                              ? Icons.stay_current_portrait
                              : Icons.stay_current_landscape,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            _orientation = _orientation == Orientation.portrait
                                ? Orientation.landscape
                                : Orientation.portrait;
                          });
                        },
                      ),
                    ),
                  if (widget.enableLanguageToggle)
                    Tooltip(
                      message: 'Toggle Text Direction',
                      child: IconButton(
                        icon: Icon(
                          _textDirection == TextDirection.ltr
                              ? Icons.format_textdirection_l_to_r
                              : Icons.format_textdirection_r_to_l,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          setState(() {
                            _textDirection = _textDirection == TextDirection.ltr
                                ? TextDirection.rtl
                                : TextDirection.ltr;
                          });
                        },
                      ),
                    ),
                  Tooltip(
                    message: 'Capture Screenshot',
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: _captureScreenshot,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureScreenshot() async {
    try {
      RenderRepaintBoundary boundary =
          _screenshotKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        saveScreenshotPlatform(pngBytes);
      }
    } catch (e) {
      // Handle error
    }
  }
}
