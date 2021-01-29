import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    void _submitData() {
      final entredTitle = _titleController.text;
      final entredAmount = double.parse(_amountController.text);
      if (entredTitle.isEmpty || entredAmount <= 0 || _selectedDate == null) {
        return;
      }
      widget.addNewTx(entredTitle, entredAmount, _selectedDate);
      Navigator.of(context).pop();
    }

    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
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

    return SingleChildScrollView(child: Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded (
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen !'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                  ),
                  Platform.isIOS ? CupertinoButton(child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ), onPressed: _presentDatePicker,) : FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    ));
  }
}
