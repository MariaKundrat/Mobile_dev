import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:usb_serial/usb_serial.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  UsbPort? _port;
  bool _isSending = false;
  bool _scanned = false;

  Future<void> _connectToUSB() async {
    final devices = await UsbSerial.listDevices();
    if (devices.isNotEmpty) {
      _port = await devices[0].create();
      await _port?.open();
      await _port?.setDTR(true);
      await _port?.setRTS(true);
      await _port?.setPortParameters(
        9600,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );
    }
  }

  Future<void> _sendToMicrocontroller(String text) async {
    if (_port == null) {
      await _connectToUSB();
    }

    if (_port != null) {
      setState(() => _isSending = true);
      await _port?.write(Uint8List.fromList(text.codeUnits));
      setState(() {
        _isSending = false;
        _scanned = true;
      });
    }
  }

  @override
  void dispose() {
    _port?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR-code')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (BarcodeCapture barcodeCapture) {
                final barcode = barcodeCapture.barcodes.isNotEmpty
                    ? barcodeCapture.barcodes[0].rawValue
                    : null;
                if (barcode != null && !_scanned) {
                  _sendToMicrocontroller(barcode);
                  setState(() {
                    _scanned = true;
                  });
                }
              },
            ),
          ),
          if (_isSending)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          else if (_scanned)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('QR-code scanned and sent!'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _scanned = false;
                      });
                    },
                    child: const Text('Scan more'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
