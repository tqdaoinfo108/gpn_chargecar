import 'package:charge_car/utils/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientLocal {
  late MqttServerClient client;
  late Function(List<MqttReceivedMessage<MqttMessage>>) onCalled;

  Future<MqttServerClient> init(
      Function(List<MqttReceivedMessage<MqttMessage>>) onCalled,Function() onConnected) async {
    client = MqttServerClient.withPort(
        LocalDB.getMqttServer,
        'Mobile_client_mobile_${DateTime.now().microsecond}',
        LocalDB.getMqttPort);

    // client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    // client.pongCallback = pong;
    client.port = LocalDB.getMqttPort;
    final connMessage = MqttConnectMessage()
        .authenticateAs(LocalDB.getMqttUserName, LocalDB.getMqttPassword)
        .withClientIdentifier(
            'Mobile_client_mobile_${DateTime.now().microsecond}')
        .withWillQos(MqttQos.atLeastOnce);
    this.onCalled = onCalled;

    client.connectionMessage = connMessage;
    client.autoReconnect = true;
    client.resubscribeOnAutoReconnect = true;

    try {
      await client.connect();
    } catch (e) {
      client.disconnect();
    }
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      // final MqttMessage message = c[0].payload;
      onCalled.call(c);
      // print('Received message:$message from topic: ${c[0].topic}>');
    });

    return client;
  }

  // connection succeeded
  // static void onConnected() {
  //   if (LocalDB.isDebug) {
  //     EasyLoading.showInfo("Đã kết nối");
  //   }
  // }

// unconnected
  static void onDisconnected() {
    if (LocalDB.isDebug) {
      EasyLoading.showInfo("Đã mất kết nối");
    }
  }

// subscribe to topic succeeded
  static void onSubscribed(String topic) {
    if (LocalDB.isDebug) {
      EasyLoading.showInfo("Đã theo dõi: $topic");
    }
  }

// subscribe to topic failed
  static void onSubscribeFail(String topic) {
    if (LocalDB.isDebug) {
      EasyLoading.showInfo("Đã theo dõi thất bại: $topic");
    }
  }

// unsubscribe succeeded
  static void onUnsubscribed(String? topic) {
    if (LocalDB.isDebug) {
      EasyLoading.showInfo("Đã ngừng theo dõi: $topic");
    }
  }

// PING response received
  static void pong() {
    print('Ping response client callback invoked');
  }
}
