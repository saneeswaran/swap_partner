import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? result;
  Future<String> scanBarcode() async {
    String? res = await SimpleBarcodeScanner.scanBarcode(context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Scan Bar Code',
          centerTitle: true,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 2000,
        cameraFace: CameraFace.back,
        scanType: ScanType.defaultMode);
    setState(() {
      result = res;
    });
    return res ?? '';
  }

  @override
  Widget build(BuildContext context) {
    scanBarcode();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
    );
  }
}
