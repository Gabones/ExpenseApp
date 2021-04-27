import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Gastos'),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              child: Card(
                color: Colors.purple,
                child: Text(
                  'Chart',
                  textAlign: TextAlign.center,
                ),
              )),
          Card(
            child: Text('List of TX'),
          ),
        ],
      ),
    );
  }
}
