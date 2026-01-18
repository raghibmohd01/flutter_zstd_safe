import 'dart:convert';
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
  static Future<Uint8List?> compress(Uint8List data) async {
    final result = await _channel.invokeMethod('compress', data);
    return result;
  }

  /// Decompresses the given [data] using Zstandard.
  ///
  /// Returns a [Uint8List] containing the decompressed data, or `null` if decompression failed.
  static Future<Uint8List?> decompress(Uint8List data) async {
    final result = await _channel.invokeMethod('decompress', data);
    return result;
  }
}

/// A [Codec] that compresses and decompresses data using Zstandard.
class ZstdCodec extends Codec<List<int>, List<int>> {
  /// Constant constructor.
  const ZstdCodec();

  @override
  Converter<List<int>, List<int>> get decoder => const ZstdDecoder();

  @override
  Converter<List<int>, List<int>> get encoder => const ZstdEncoder();
}

/// A [Converter] that compresses data using Zstandard.
class ZstdEncoder extends Converter<List<int>, List<int>> {
  /// Constant constructor.
  const ZstdEncoder();

  @override
  List<int> convert(List<int> input) {
    // Synchronous conversion is not supported by the async platform channel.
    // Throws an error to indicate this limitation.
    throw UnsupportedError(
        'ZstdEncoder.convert is not recommended because '
        'FlutterZstdSafe relies on asynchronous platform channels. '
        'Use FlutterZstdSafe.compress() directly or implement an async flow.');
  }

  /// startChunkedConversion is technically valid but since underlying
  /// implementation is a oneshot buffer compressor, it's not truly streaming.
  /// However, for Codec compliance we might need it.
  /// For now, keeping it simple.
}

/// A [Converter] that decompresses data using Zstandard.
class ZstdDecoder extends Converter<List<int>, List<int>> {
  /// Constant constructor.
  const ZstdDecoder();

  @override
  List<int> convert(List<int> input) {
    throw UnsupportedError(
        'ZstdDecoder.convert is not recommended because '
        'FlutterZstdSafe relies on asynchronous platform channels. '
        'Use FlutterZstdSafe.decompress() directly or implement an async flow.');
  }
}
