import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('compress and decompress round trip', (WidgetTester tester) async {
    final Random random = Random();
    final List<int> originalData = List<int>.generate(1024 * 1024, (i) => random.nextInt(256));
    final Uint8List originalBytes = Uint8List.fromList(originalData);

    // Compress
    final Uint8List? compressed = await FlutterZstdSafe.compress(originalBytes);
    expect(compressed, isNotNull);
    expect(compressed!.isNotEmpty, true);
    expect(compressed.length, lessThan(originalBytes.length)); // Assuming random data compresses slightly or at least result exists

    // Decompress
    final Uint8List? decompressed = await FlutterZstdSafe.decompress(compressed);
    expect(decompressed, isNotNull);
    expect(decompressed, originalBytes);
  });
}
