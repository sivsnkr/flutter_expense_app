import 'package:flutter/foundation.dart';

class Transaction {
  final id;
  final name;
  final amount;
  final date;
  Transaction({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date,
  });
}
