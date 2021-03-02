import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/firebaseNotifications.dart';
import 'package:flutter_app_estados_push/model/payment.dart';

class ListPaymentPage extends StatefulWidget {

  @override
  _ListPaymentPageState createState() => _ListPaymentPageState();

}

class _ListPaymentPageState extends State<ListPaymentPage> {

  List<Payment> payments = [];

  @override
  void initState() {
    super.initState();
    new FirebaseNotifications(useMessage).setUpFirebase();
  }

  void useMessage(Payment payment){
    setState(() {
      payments.add(payment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: payments.length == 0 ? showEmptyPayment() : showWithPayments,
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
    mainAxisSize: MainAxisSize.max,
    children: [
      DataTable(
        columns: getColumns,
        rows: getRows(),
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
            onSelectChanged: (value) {
              setState(() {
                element.selected = value;
              });
            },
          )
      );
    });
    return rows;
  }

}
