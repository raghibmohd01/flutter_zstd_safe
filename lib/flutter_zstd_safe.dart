import 'dart:typed_data';
import 'package:flutter/services.dart';

/// A class that provides Zstandard compression capabilities.
///
/// This plugin uses the official Zstd C library via JNI on Android.
class FlutterZstdSafe {
  static const _channel = MethodChannel('flutter_zstd_safe');

  /// Compresses the given [data] using Zstandard.
  ///
  /// Returns a [Uint8List] containing the compressed data, or `null` if compression failed.
  ///
  /// Example:
  /// ```dart
  /// final compressed = await FlutterZstdSafe.compress(originalData);
  /// ```
  static Future<Uint8List?> compress(Uint8List data) async {
    final result = await _channel.invokeMethod('compress', data);
    return result;
  }
}
