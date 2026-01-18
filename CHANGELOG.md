## 1.1.0

* Upgraded NDK to r28 for official 16 KB page support.
* Added explicit linker flags to ensure 16 KB segment alignment (`-Wl,-z,max-page-size=16384`).
* Verified 16 KB alignment using `objdump`.

## 1.0.3

* Implemented `ZstdCodec`, `ZstdEncoder`, and `ZstdDecoder`.
* Added `FlutterZstdSafe.decompress` method.
* Added native decompression support.

## 1.0.2

* Fixed repository link in `pubspec.yaml`.

## 1.0.1

* Added documentation and usage examples.

## 1.0.0

* Initial release with Zstandard support, NDK r26, and 16 KB page size support.
