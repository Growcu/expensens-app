import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionsList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No transactions added yet',
                    style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                  height: constraints.maxHeight * 0.6,
                )
              ],
            );
          })
        : ListView(
            children: transactions.map((tx) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: Text('\$${tx.amount}'))),
                  ),
                  title: Text(
                    tx.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () => removeTransaction(tx.id),
                          label: Text('Delete'),
                          icon: Icon(
                            Icons.delete,
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.red,
                          ),
                          // textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          onPressed: () => removeTransaction(tx.id),
                          icon: Icon(
                            Icons.delete,
                          ),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            }).toList(),
          );
  }
}
