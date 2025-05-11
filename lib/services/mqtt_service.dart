import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class MqttService {
  late mqtt.MqttClient _client;
  void Function(String)? onDataReceived;

  MqttService();

  Future<void> connect() async {
    _client = mqtt.MqttClient('broker.hivemq.com', '');
    _client.port = 1883;
    _client.keepAlivePeriod = 60;
    _client.onDisconnected = onDisconnected;

    try {
      await _client.connect();
      if (_client.connectionStatus!.state ==
          mqtt.MqttConnectionState.connected) {
        subscribeToTopic();
      }
    } catch (e) {
      debugPrint('Error connecting to MQTT broker: $e');
    }
  }

  void subscribeToTopic() {
    const topic = 'sensor/temperature';
    _client.subscribe(topic, mqtt.MqttQos.atMostOnce);
    _client.updates!
        .listen((List<mqtt.MqttReceivedMessage<mqtt.MqttMessage>> event) {
      final payload = event[0].payload as mqtt.MqttPublishMessage;
      final message = mqtt.MqttPublishPayload.bytesToStringAsString(
        payload.payload.message,
      );
      onDataReceived?.call(message);
    });
  }

  void onDisconnected() {
    debugPrint('Disconnected from MQTT broker');
  }

  void disconnect() {
    _client.disconnect();
  }
}
