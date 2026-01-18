import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';
import 'dart:typed_data';

void main() {
  const MethodChannel channel = MethodChannel('flutter_zstd_safe');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'compress') {
          return  Uint8List.fromList([1, 2, 3]); // Mock compressed data
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('compress', () async {
    final Uint8List input = Uint8List.fromList([0]);
    expect(await FlutterZstdSafe.compress(input), isA<Uint8List>());
  });
}
