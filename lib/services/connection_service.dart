import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get onConnectionChange =>
      _connectivity.onConnectivityChanged;
}
