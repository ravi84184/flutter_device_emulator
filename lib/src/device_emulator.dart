import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:device_frame/device_frame.dart' hide DeviceType;
import 'dart:html' as html;

class DeviceEmulator extends StatefulWidget {
  final WidgetBuilder builder;
  final bool enableThemeToggle;
  final bool enableOrientationToggle;
  final bool enableLanguageToggle;

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
        if (kIsWeb) {
          // Web: trigger browser download
          final blob = html.Blob([pngBytes]);
          final url = html.Url.createObjectUrlFromBlob(blob);
          html.AnchorElement(href: url)
            ..setAttribute(
              'download',
              'screenshot_${DateTime.now().millisecondsSinceEpoch}.png',
            )
            ..click();
          html.Url.revokeObjectUrl(url);
        }
      }
    } catch (e) {
      // Handle error
    }
  }
}
