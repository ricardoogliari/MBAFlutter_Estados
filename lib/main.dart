import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/listPaymentsPage.dart';
import 'package:flutter_app_estados_push/provider/paymentControllerProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*home: ChangeNotifierProvider(
        create: (context) => PaymentControllerProvider(),
        child: ListPaymentPage(),
      ),*/ //com provider
      home: ListPaymentPage() //com mobx
    );
  }
}

