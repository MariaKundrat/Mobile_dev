import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/qr_scanner_cubit.dart';
import 'package:lab1/cubit/states/qr_scanner_state.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QRScannerCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan QR-code')),
        body: BlocBuilder<QRScannerCubit, QRScannerState>(
          builder: (context, state) {
            if (state is QRScannerConnecting || state is QRScannerInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QRScannerNotConnected) {
              return const Center(child: Text('ESP32 not connected via USB'));
            } else if (state is QRScannerConnected ||
                state is QRScannerSending) {
              return Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: MobileScanner(
                      onDetect: (BarcodeCapture barcodeCapture) {
                        final barcode = barcodeCapture.barcodes.isNotEmpty
                            ? barcodeCapture.barcodes[0].rawValue
                            : null;
                        if (barcode != null && state is QRScannerConnected) {
                          context
                              .read<QRScannerCubit>()
                              .sendToMicrocontroller(barcode);
                        }
                      },
                    ),
                  ),
                  if (state is QRScannerSending)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            } else if (state is QRScannerSent) {
              return Column(
                children: [
                  const Spacer(),
                  Text('QR-code scanned: ${state.scannedValue}'),
                  ElevatedButton(
                    onPressed: () => context.read<QRScannerCubit>().reset(),
                    child: const Text('Scan more'),
                  ),
                  const Spacer(),
                ],
              );
            } else if (state is QRScannerError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
