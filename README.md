# flutter_zstd_safe

[![pub package](https://img.shields.io/pub/v/flutter_zstd_safe.svg)](https://pub.dev/packages/flutter_zstd_safe)

A minimal, production-ready Flutter plugin for Zstandard (zstd) compression on Android, built with **NDK r26** and **16 KB page size support**.

## Features

- 🚀 **Fast**: Uses Facebook's official `zstd` C library.
- 🛡️ **Safe**: Namespace-isolated JNI symbols to avoid collisions.
- ✅ **Google Play Ready**: Compliant with Android 15's 16 KB page size requirement.
- 📱 **Android Support**:
  - `arm64-v8a`, `armeabi-v7a`, `x86_64`
  - NDK r26.3.11579264

## Usage

```dart
import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';

// Compress data
final Uint8List input = ...;
final Uint8List? compressed = await FlutterZstdSafe.compress(input);

if (compressed != null) {
  print('Original: ${input.length}, Compressed: ${compressed.length}');
}
```

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_zstd_safe: ^1.0.1
```

## Android Configuration

This plugin automatically configures the necessary NDK version and ABI filters. No additional setup in your `android/build.gradle` is usually required.

However, ensure your app supports the ABIs provided:
- `arm64-v8a`
- `armeabi-v7a`
- `x86_64`

## License

MIT License. See [LICENSE](LICENSE) for details.
