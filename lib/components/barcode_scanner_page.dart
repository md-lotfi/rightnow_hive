import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:easy_localization/easy_localization.dart';

class BarcodeScannerPage extends StatefulWidget {
  final Function(String value) onResult;
  const BarcodeScannerPage({
    Key? key,
    required this.onResult,
  }) : super(key: key);

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  bool hasBarcode = false;

  void _handleBarcode(BarcodeCapture barcodes) {
    Barcode? barcode = barcodes.barcodes.firstOrNull;
    if (barcode?.displayValue != null && !hasBarcode) {
      hasBarcode = true;
      widget.onResult(barcode!.displayValue!);
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
    /*if (mounted) {
      /*setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });*/
      
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanner un qr code'.tr())),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            onDetect: _handleBarcode,
          ),
          /*Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
