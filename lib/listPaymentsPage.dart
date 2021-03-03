import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/firebaseNotifications.dart';
import 'package:flutter_app_estados_push/model/payment.dart';
import 'package:flutter_app_estados_push/provider/paymentControllerProvider.dart';
import 'package:provider/provider.dart';

class ListPaymentPage extends StatelessWidget {

  List<Payment> payments;

  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications(context).setUpFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: Consumer<PaymentControllerProvider>(
        builder: (context, controller, child) {
          payments = controller.items;
          return controller.items.length == 0 ? showEmptyPayment() : showWithPayments();
        },
      ),
    );
  }

  Widget showEmptyPayment() => Container(
      padding: EdgeInsets.all(20),
      child: Text(
        "Nenhuma conta recebida neste momento...",
        style: TextStyle(
            fontSize: 25
        ),
      )
  );

  Widget showWithPayments() => Row(
    children: [
      Expanded(
        child: DataTable(
          columns: getColumns,
          rows: getRows(),
        ),
      ),
    ],
  );

  List<DataColumn> getColumns = [
    DataColumn(
      label: Text(
        'Tipo',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    DataColumn(
      label: Text(
        'Local',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    DataColumn(
      label: Text(
        'Valor',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
  ];

  List<DataRow> getRows(){
    List<DataRow> rows = [];

    payments.forEach((element) {
      rows.add(
          DataRow(
            selected: element.selected,
            cells: <DataCell>[
              DataCell(Text(element.type)),
              DataCell(Text(element.place)),
              DataCell(Text("${element.value}")),
            ],
          )
      );
    });
    return rows;
  }

}
