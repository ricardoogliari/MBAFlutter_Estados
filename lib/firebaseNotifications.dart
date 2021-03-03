import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/model/payment.dart';
import 'package:flutter_app_estados_push/provider/paymentControllerProvider.dart';
import 'package:provider/provider.dart';

class FirebaseNotifications {

  FirebaseMessaging _firebaseMessaging;

  final BuildContext context;
  PaymentControllerProvider controller;

  FirebaseNotifications(this.context){
    controller = Provider.of<PaymentControllerProvider>(context, listen: false);
  }

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
        controller.add(payment);
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
