import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return result != ConnectivityResult.none;
  }

  Stream<List<ConnectivityResult>> get onConnectionChange =>
      _connectivity.onConnectivityChanged;
}
