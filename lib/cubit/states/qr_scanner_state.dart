import 'package:equatable/equatable.dart';

abstract class QRScannerState extends Equatable {
  const QRScannerState();

  @override
  List<Object?> get props => [];
}

class QRScannerInitial extends QRScannerState {}

class QRScannerConnecting extends QRScannerState {}

class QRScannerConnected extends QRScannerState {}

class QRScannerNotConnected extends QRScannerState {}

class QRScannerSending extends QRScannerState {}

class QRScannerSent extends QRScannerState {
  final String scannedValue;

  const QRScannerSent(this.scannedValue);

  @override
  List<Object?> get props => [scannedValue];
}

class QRScannerError extends QRScannerState {
  final String message;

  const QRScannerError(this.message);

  @override
  List<Object?> get props => [message];
}
