import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onFormSubmit;

  NewTransaction(this.onFormSubmit){
    // print("constructor newTransaction");
  }

  @override
  _NewTransactionState createState() {
    // print("creates state");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState(){
    super.initState();
    // print("init state");
  }


  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    // print("did update");
    super.didUpdateWidget(oldWidget);
  }


  @override
  void dispose() {
    // print("disposed");
    super.dispose();
  }

  void _submitData() {
    var enteredText = _titleController.text;
    var enteredAmount = double.parse(_amountController.text);

    if (enteredText.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.onFormSubmit(enteredText, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
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
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No date chosen"
                          : DateFormat.yMMMMd().format(_selectedDate)),
                    ),
                    FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColorDark,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text("Add Transaction"),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColorDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
