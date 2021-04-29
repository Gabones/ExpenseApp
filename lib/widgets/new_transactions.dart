import 'dart:convert';

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  // String titleInput;
  // String amountInput;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              // onChanged: (value) => titleInput = value,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              // onChanged: (value) => amountInput = value,
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Total'),
            ),
            TextButton(
              child: Text('Add Compra'),
              onPressed: () => addTx(_titleController.text, double.parse(_amountController.text)),
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.purple)),
            ),
          ],
        ),
      ),
    );
  }
}
