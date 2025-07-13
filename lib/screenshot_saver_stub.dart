import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<void> saveScreenshotPlatform(
  Uint8List uInt8List, {
  String imageType = 'image/png',
  double imageQuality = 0.95,
  String name = 'screenshot',
}) async {
  try {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/appName';
    // Create the directory if it doesn't exist
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/$name.jpg';
    await File(filePath).writeAsBytes(uInt8List);
  } catch (e) {
    // debugPrint(e.toString());
  }
}
