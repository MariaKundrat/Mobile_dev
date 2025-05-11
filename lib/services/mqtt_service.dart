import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final _client = MqttServerClient('broker.hivemq.com', '');

  // ignore: inference_failure_on_function_return_type
  Future<void> connect(Function(String) onMessage) async {
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = () => debugPrint('MQTT disconnected');
    _client.onConnected = () => debugPrint('MQTT connected');

    final random = Random();
    final temperature = (20 + random.nextDouble() * 10).toStringAsFixed(2);
    final builder = MqttClientPayloadBuilder();
    builder.addString(temperature);

    _client.publishMessage(
      'sensor/temperature',
      MqttQos.atMostOnce,
      builder.payload!,
    );

    debugPrint('Published random temperature: $temperature');

    final connMess = MqttConnectMessage()
        .withClientIdentifier(
          'flutter_${DateTime.now().millisecondsSinceEpoch}',
        )
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    _client.connectionMessage = connMess;

    try {
      await _client.connect();
    } catch (e) {
      debugPrint('MQTT error: $e');
      _client.disconnect();
    }

    if (_client.connectionStatus?.state == MqttConnectionState.connected) {
      debugPrint('Connected to MQTT broker');

      _client.subscribe('sensor/temperature', MqttQos.atMostOnce);

      _client.updates?.listen((messages) {
        final recMess = messages[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        onMessage(payload);
      });
    }
  }

  void disconnect() {
    _client.disconnect();
  }
}
