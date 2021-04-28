import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      title: 'Expenses App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> transactions = [
    Transaction(id: '0', title: 'Tênis novos', amount: 299.99, date: DateTime.now()),
    Transaction(id: '1', title: 'Compras da semana', amount: 16.99, date: DateTime.now())
  ];
  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Gastos'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    // onChanged: (value) => titleInput = value,
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Titulo'),
                  ),
                  TextField(
                    // onChanged: (value) => amountInput = value,
                    controller: amountController,
                    decoration: InputDecoration(labelText: 'Total'),
                  ),
                  TextButton(
                    child: Text('Add Compra'),
                    onPressed: () => null,
                    style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.purple)),
                  )),
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Card(child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2,)),
                    child: Text(
                      'R\$ ${tx.amount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple
                      )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(tx.date),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ],
              ));
            }).toList(),
          )
        ],
      ),
    );
  }
}
