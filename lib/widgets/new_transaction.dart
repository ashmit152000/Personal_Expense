import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function addNewTx;

  NewTransaction(this.addNewTx);
  
   @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
    final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     void submitData() {
      final entredTitle = titleController.text;
      final entredAmount = double.parse(amountController.text);
      if (entredTitle.isEmpty || entredAmount <= 0) {
        return;
      }
      widget.addNewTx(entredTitle, entredAmount);
      Navigator.of(context).pop();
    }

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }

}