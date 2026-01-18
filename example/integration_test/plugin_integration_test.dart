import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';
import 'dart:typed_data';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('compress test', (WidgetTester tester) async {
    // This test runs on the device and calls native code.
    // Verify it returns non-null data.
    final input = Uint8List.fromList('Hello World'.codeUnits);
    final result = await FlutterZstdSafe.compress(input);
    expect(result, isNotNull);
    expect(result!.isNotEmpty, true);
  });
}
