import 'package:charge_car/utils/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientLocal {
  late MqttServerClient client;
  late Function(List<MqttReceivedMessage<MqttMessage>>) onCalled;

  Future<MqttServerClient> init(
      Function(List<MqttReceivedMessage<MqttMessage>>) onCalled) async {
    client = MqttServerClient.withPort(LocalDB.getMqttServer,
        'Mobile_client_user${LocalDB.getUserID}', LocalDB.getMqttPort);

    // client.logging(on: true);
    // client.onConnected = onConnected;
    // client.onDisconnected = onDisconnected;
    // client.onUnsubscribed = onUnsubscribed;
    // client.onSubscribed = onSubscribed;
    // client.onSubscribeFail = onSubscribeFail;
    // client.pongCallback = pong;
    client.port = LocalDB.getMqttPort;
    final connMessage = MqttConnectMessage()
        .authenticateAs(LocalDB.getMqttUserName, LocalDB.getMqttPassword)
        .withClientIdentifier('user${LocalDB.getUserID}')
        .withWillQos(MqttQos.atMostOnce);
    this.onCalled = onCalled;

    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
    }
    client.subscribe("topic/test", MqttQos.atMostOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      // final MqttMessage message = c[0].payload;
      onCalled.call(c);
      // print('Received message:$message from topic: ${c[0].topic}>');
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
