import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amoutController = TextEditingController();
  DateTime? hasDate;
  DateTime selectedDate = DateTime.now();

  void submitData(ctx) {
    if (titleController.text.length > 0 &&
        amoutController.text.length > 0 &&
        hasDate != null) {
      widget.addTransaction(
          titleController.text, amoutController.text, selectedDate);
      Navigator.of(ctx).pop();
    }
  }

  void _datePicker(ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        hasDate = pickedDate;
        selectedDate = pickedDate;
      });
    });
  }

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
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(context),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amoutController,
              onSubmitted: (_) => submitData(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hasDate != null
                      ? Text(
                          DateFormat('dd/MM/yyyy').format(selectedDate),
                        )
                      : Text('No Date Selected'),
                  TextButton(
                    onPressed: () {
                      _datePicker(context);
                    },
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => submitData(context),
              child: Text(
                'Add Transaction',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
