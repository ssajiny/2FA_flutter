import 'package:flutter/material.dart';

class QRFormPage extends StatelessWidget {
  const QRFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New QR Code'),
        centerTitle: true,
      ),
      body:
          const Padding(padding: EdgeInsets.all(12.0), child: Text('QR Code')),
    );
  }
}
