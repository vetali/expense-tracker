import 'dart:math';

import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  var availableColors = [Colors.purple, Colors.blue, Colors.orange, Colors.green];
  var avatarColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            backgroundColor: avatarColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text("\$${widget.tx.amount.toStringAsFixed(2)}"),
              ),
            )),
        title: Text(widget.tx.title),
        subtitle: Text(DateFormat.yMMMd().format(widget.tx.date)),
        trailing: MediaQuery.of(context).size.width > 360 ?
        FlatButton.icon(
            onPressed: () {
              widget.deleteTx(widget.tx.id);
            },
            icon: const Icon(Icons.delete),
            textColor: Theme.of(context).errorColor,
            label: const Text("Delete")
        )
            : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            widget.deleteTx(widget.tx.id);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    avatarColor = availableColors[Random().nextInt(4)];
  }
}