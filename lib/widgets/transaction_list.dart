import 'package:flutter/material.dart';

import './customCard.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final deleteTransaction;
  TransactionList(this.transaction, this.deleteTransaction);
  @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: transaction.length,
  //     itemBuilder: (ctx, index) {
  //       return CustomCard(
  //         transaction[index],
  //         deleteTransaction,
  //         ValueKey(transaction[index].id),
  //       );
  //     },
  //   );
  // }
  Widget build(BuildContext context) {
    return ListView(
        children: transaction.map(
      (tx) {
        return CustomCard(
          tx,
          deleteTransaction,
          ValueKey(tx.id),
        );
      },
    ).toList());
  }
}
