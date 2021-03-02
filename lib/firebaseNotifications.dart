import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_estados_push/model/payment.dart';

class FirebaseNotifications {

  FirebaseMessaging _firebaseMessaging;

  final void Function(Payment) callback;
  FirebaseNotifications(this.callback);

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessagingListeners();
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("token: $token");
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");
        Payment payment = Payment.fromJson(message);
        callback(payment);
      },
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
