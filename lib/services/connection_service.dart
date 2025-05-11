import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectionStatus { online, offline }

class ConnectivityService {
  final _connectivity = Connectivity();
  final _controller = StreamController<ConnectionStatus>.broadcast();

  ConnectivityService() {
    _init();
  }

  void _init() async {
    final initialResults = await _connectivity.checkConnectivity();
    _controller.add(_mapResultList(initialResults));

    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final status = _mapResultList(results);
      _controller.add(status);
    });
  }

  Stream<ConnectionStatus> get statusStream => _controller.stream;

  Future<ConnectionStatus> getCurrentStatus() async {
    final results = await _connectivity.checkConnectivity();
    return _mapResultList(results);
  }

  ConnectionStatus _mapResultList(List<ConnectivityResult> results) {
    if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
      return ConnectionStatus.offline;
    }
    return ConnectionStatus.online;
  }

  void dispose() {
    _controller.close();
  }
}
