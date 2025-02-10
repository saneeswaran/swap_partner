import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedData;
  bool isLoading = false;
  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR Code")),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          if (isLoading)
            Container(
              color: Colors.black54,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            scannedData = scanData.code;
            isLoading = false;
          });

          _showScanResultDialog(scannedData);
        });
      }
    });
  }

  void _showScanResultDialog(String? result) {
    if (result != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("QR Code Scanned"),
          content: Text("Result: $result"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("OK")),
          ],
        ),
      );
    }
  }
}
