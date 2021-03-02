import 'package:flutter/material.dart';
import 'package:flutter_app_estados_push/firebaseNotifications.dart';
import 'package:flutter_app_estados_push/model/payment.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
      body: payments.length == 0 ? Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Nenhuma conta recebida neste momento...",
            style: TextStyle(
                fontSize: 25
            ),
          )
      ): DataTable(
        columns: <DataColumn>[
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
        ],
        rows: getRows(),
      ),
    );
  }

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
