import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text("No transactions yet",
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset("assets/images/waiting.png")),
              ],
            );
          })
        :
        ListView(
          children: [
            ...userTransactions.map((tx){
              return TransactionItem(tx: tx, deleteTx: deleteTx, key: ValueKey(tx.id));
            }).toList(),
          ],
        );
    // ListView.builder(
    //         itemBuilder: (cxt, index) {
    //           var tx = userTransactions[index];
    //           return TransactionItem(tx: tx, deleteTx: deleteTx);
    //         },
    //         itemCount: userTransactions.length,
    //       );
  }
}
