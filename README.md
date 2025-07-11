# flutter_device_emulator
[![Pub Version](https://img.shields.io/pub/v/flutter_device_emulator)](https://pub.dev/packages/flutter_device_emulator)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Flutter package to emulate different device screens and layouts, making it easier to preview and test your app on various device types and resolutions directly within your Flutter app or development environment.

## Features
- Emulate multiple device screen sizes and resolutions
- Switch between device types (phone, tablet, etc.)
- Preview your app in different orientations
- Easy integration with your existing Flutter project
- Customizable device frames and backgrounds

## Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_device_emulator: latest_version
```

Then run:
```sh
flutter pub get
```

## Usage
Import the package and wrap your app or widget with the emulator:

```dart
import 'package:flutter_device_emulator/flutter_device_emulator.dart';

DeviceEmulator(
  builder: (context) => SafeArea(child: HomePage()),
)
```

### Example
See the [`example/`](example/) directory for a complete sample app demonstrating usage and available features.

## API Reference

### `DeviceEmulator`
The main widget to wrap your app for device emulation. Provides controls for device type, orientation, theme, and text direction.

**Constructor:**
```dart
DeviceEmulator({
  required WidgetBuilder builder,
  bool enableThemeToggle = true,
  bool enableOrientationToggle = true,
  bool enableLanguageToggle = true,
  Key? key,
})
```

**Parameters:**
- `builder` (**required**): A function that builds the widget tree to be emulated inside the device frame.
- `enableThemeToggle` (default: `true`): If true, shows a button to toggle between light and dark themes.
- `enableOrientationToggle` (default: `true`): If true, shows a button to toggle between portrait and landscape orientations.
- `enableLanguageToggle` (default: `true`): If true, shows a button to toggle between left-to-right and right-to-left text directions.
- `key`: Optional widget key.

**Features:**
- Device selector: Choose from a list of common devices to emulate.
- Theme toggle: Switch between light and dark modes.
- Orientation toggle: Switch between portrait and landscape.
- Text direction toggle: Switch between LTR and RTL layouts.
- Screenshot: Capture the current emulated screen (web only).

**Example:**
```dart
DeviceEmulator(
  builder: (context) => SafeArea(child: HomePage()),
)
```

For detailed API documentation, see the source code in [`lib/`](lib/).

## Contributing
Contributions are welcome! Please open issues or submit pull requests for bug fixes, features, or improvements.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a pull request

## License
This project is licensed under the [MIT License](LICENSE).
