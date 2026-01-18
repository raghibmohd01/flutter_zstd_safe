import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_zstd_safe/flutter_zstd_safe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _compressedResult = 'Not compressed';

  @override
  void initState() {
    super.initState();
    testCompression();
  }

  Future<void> testCompression() async {
    String message;
    try {
      final input = Uint8List.fromList('Hello from Zstd Safe plugin!'.codeUnits);
      final result = await FlutterZstdSafe.compress(input);
      if (result != null) {
        message = 'Compressed: ${input.length} -> ${result.length} bytes';
      } else {
        message = 'Compression returned null';
      }
    } catch (e) {
      message = 'Error: $e';
    }

    if (!mounted) return;

    setState(() {
      _compressedResult = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zstd Safe App'),
        ),
        body: Center(
          child: Text('Result: $_compressedResult'),
        ),
      ),
    );
  }
}
