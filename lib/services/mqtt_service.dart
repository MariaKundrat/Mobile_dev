import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient _client;
  Function(String)? onDataReceived;

  Future<void> connect() async {
    _client = MqttServerClient('test.mosquitto.org', 'flutter_client');
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = onDisconnected;
    _client.onConnected = onConnected;
    _client.logging(on: false);

    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    try {
      print('🔌 Connecting to broker...');
      await _client.connect();
      if (_client.connectionStatus!.state == MqttConnectionState.connected) {
        print('✅ Connected to MQTT broker');
        _client.subscribe('sensor/temperature', MqttQos.atMostOnce);
      } else {
        print('❌ Connection failed - status: ${_client.connectionStatus}');
        _client.disconnect();
      }
    } catch (e) {
      print('❌ Exception: $e');
      _client.disconnect();
    }
  }

  void requestTemperature() {
    const pubTopic = 'sensor/temperature/request';
    final builder = MqttClientPayloadBuilder();
    builder.addString('get_temperature');
    _client.publishMessage(pubTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  void disconnect() {
    _client.disconnect();
  }

  void onConnected() {
    print('✅ Connected to MQTT broker');
  }

  void onDisconnected() {
    print('❗Disconnected from MQTT broker');
  }
}
