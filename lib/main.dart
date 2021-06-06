import 'dart:io';
import 'package:expenses_app/widgets/new_transactions.dart';
import 'package:flutter/cupertino.dart';
import './models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ))),
      title: 'Expenses App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(id: '0', title: 'Tênis novos', amount: 299.99, date: DateTime.now()),
    // Transaction(id: '1', title: 'Compras da semana', amount: 16.99, date: DateTime.now())
  ];

  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isAndroid
        ? AppBar(
            title: Text('App de Gastos'),
            actions: [
              IconButton(
                icon: Icon(CupertinoIcons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          )
        : CupertinoNavigationBar(
            middle: Text('App de Gastos'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    print('My HomePage Build');
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final mediaQuery = MediaQuery.of(context);
    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
        ],
      ),
    ));
    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    foregroundColor: Colors.white,
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          )
        : CupertinoPageScaffold(child: pageBody);
  }
}
