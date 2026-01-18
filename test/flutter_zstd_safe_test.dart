import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_zstd_safe');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'compress') {
          return Uint8List.fromList([1, 2, 3]); // Mock compressed data
        } else if (methodCall.method == 'decompress') {
          return Uint8List.fromList([4, 5, 6]); // Mock decompressed data
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger .setMockMethodCallHandler(channel, null);
  });

  test('compress', () async {
    final result = await FlutterZstdSafe.compress(Uint8List(0));
    expect(result, isNotNull);
    expect(result!.length, 3);
  });

  test('decompress', () async {
    final result = await FlutterZstdSafe.decompress(Uint8List(0));
    expect(result, isNotNull);
    expect(result!.length, 3);
  });

  test('ZstdCodec structure', () {
    const codec = ZstdCodec();
    expect(codec.encoder, isA<ZstdEncoder>());
    expect(codec.decoder, isA<ZstdDecoder>());
  });
}
