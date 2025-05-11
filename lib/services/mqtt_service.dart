import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient _client;
  void Function(String)? onDataReceived;

  Future<void> connect() async {
    _client = MqttServerClient('test.mosquitto.org', 'flutter_client');
    _client
      ..port = 1883
      ..keepAlivePeriod = 20
      ..logging(on: false)
      ..onConnected = _handleConnected
      ..onDisconnected = _handleDisconnected
      ..connectionMessage = MqttConnectMessage()
          .withClientIdentifier('flutter_client')
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);

    try {
      await _client.connect();
      if (_client.connectionStatus?.state == MqttConnectionState.connected) {
        const dataTopic = 'sensor/temperature';
        _client.subscribe(dataTopic, MqttQos.atMostOnce);

        _client.updates?.listen((messages) {
          final recMess = messages[0].payload as MqttPublishMessage;
          final payload = MqttPublishPayload.bytesToStringAsString(
            recMess.payload.message,
          );
          onDataReceived?.call(payload);
        });
      } else {
        _client.disconnect();
      }
    } catch (_) {
      _client.disconnect();
    }
  }

  void requestTemperature() {
    const reqTopic = 'sensor/temperature/request';
    final builder = MqttClientPayloadBuilder()..addString('get_temperature');
    _client.publishMessage(reqTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  void disconnect() => _client.disconnect();

  void _handleConnected() {
    if (kDebugMode) {
      debugPrint('MQTT connected');
    }
  }

  void _handleDisconnected() {
    if (kDebugMode) {
      debugPrint('MQTT disconnected');
    }
  }
}
