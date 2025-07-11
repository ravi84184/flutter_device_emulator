import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

Future<void> saveScreenshot(
  Uint8List uInt8List, {
  String imageType = 'image/png',
  double imageQuality = 0.95,
  String name = 'screenshot',
}) async {
  final image = await decodeImageFromList(uInt8List);

  final web.HTMLCanvasElement canvas = web.HTMLCanvasElement();
  canvas.width = image.width;
  canvas.height = image.height;

  final ctx = canvas.context2D;

  final List<String> binaryString = [];

  for (final imageCharCode in uInt8List) {
    final charCodeString = String.fromCharCode(imageCharCode);
    binaryString.add(charCodeString);
  }
  final data = binaryString.join();

  final base64 = web.window.btoa(data);

  final img = web.HTMLImageElement();

  img.src = "data:$imageType;base64,$base64";

  final web.ElementStream<web.Event> loadStream = img.onLoad;

  loadStream.listen((event) {
    ctx.drawImage(img, 0, 0);
    final dataUrl = canvas.toDataUrl(imageType, imageQuality);
    final web.HTMLAnchorElement anchorElement = web.HTMLAnchorElement();
    anchorElement.href = dataUrl;
    anchorElement.download = name ?? dataUrl;
    anchorElement.click();
  });
}
