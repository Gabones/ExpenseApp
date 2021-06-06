import '../models/transactions.dart';
import 'package:flutter/material.dart';
import '../widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('Build for transaction List()');
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No transactions !?',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
            : ListView(
                children: transactions
                    .map((tx) => TransactionItem(
                          key: ValueKey(tx.id),
                          transaction: tx,
                          deleteTx: deleteTx,
                        ))
                    .toList(),
              ));
  }
}
