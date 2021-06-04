import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null || _amountController.text.isEmpty) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Form(
                child: Column(
                  children: [
                    TextField(
                      // onChanged: (value) => titleInput = value,
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                      decoration: InputDecoration(labelText: 'Titulo'),
                    ),
                    TextField(
                      // onChanged: (value) => amountInput = value,
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) =>
                          _submitData(), //esse metodo passa um argumento _
                      decoration: InputDecoration(labelText: 'Total'),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Data: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date!'),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text(
                  'Add Compra',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _submitData, //esse metodo não tenta passar nada
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.purple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
