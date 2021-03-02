import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/model/payment.dart';

class PaymentControllerProvider extends ChangeNotifier {
  final List<Payment> _payments = [];

  UnmodifiableListView<Payment> get items => UnmodifiableListView(_payments);

  void add(Payment payment) {
    _payments.add(payment);
    notifyListeners();
  }

  void update(){
    notifyListeners();
  }
}
