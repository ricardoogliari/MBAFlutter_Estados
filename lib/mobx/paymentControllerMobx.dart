import 'package:flutter_app_estados_push/model/payment.dart';
import 'package:mobx/mobx.dart';

part 'paymentControllerMobx.g.dart';

class PaymentController = PaymentControllerBase with _$PaymentController;

abstract class PaymentControllerBase with Store {
  @observable
  var payments = ObservableList();

  @action
  void add(Payment payment) {
    payments.add(payment);
  }

  @action
  void update(int index, Payment payment){
    payments.removeAt(index);
    payments.insert(index, payment);
  }

}
