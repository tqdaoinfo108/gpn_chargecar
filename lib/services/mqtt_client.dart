import 'package:charge_car/utils/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientLocal {
  late MqttServerClient client;
  static Future<MqttServerClient> init() async {
    MqttServerClient client =
        MqttServerClient.withPort('gpn-advance-tech.com', 'user${LocalDB.getUserID}', 1883);
    
    // client.logging(on: true);
    // client.onConnected = onConnected;
    // client.onDisconnected = onDisconnected;
    // client.onUnsubscribed = onUnsubscribed;
    // client.onSubscribed = onSubscribed;
    // client.onSubscribeFail = onSubscribeFail;
    // client.pongCallback = pong;
    client.port = 1883;
    final connMessage = MqttConnectMessage()
        .authenticateAs('gdev', 'gdev12345')
        .withClientIdentifier('user${LocalDB.getUserID}')
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch ( e) {
      print('Exception: $e');
      client.disconnect();
    }
    client.subscribe("topic/test", MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttMessage message = c[0].payload;

      print('Received message:$message from topic: ${c[0].topic}>');
    });

    return client;
  }

  // connection succeeded
  static void onConnected() {
    print('Connected');
  }

// unconnected
  static void onDisconnected() {
    print('Disconnected');
  }

// subscribe to topic succeeded
  static void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// subscribe to topic failed
  static void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  static void onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

// PING response received
  static void pong() {
    print('Ping response client callback invoked');
  }
}
