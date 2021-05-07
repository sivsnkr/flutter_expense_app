import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  final rescentTransactions;
  Chart(this.rescentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double weekDayAmountSpent = 0;
        for (var i = 0; i < rescentTransactions.length; i++) {
          if (rescentTransactions[i].date.month == weekDay.month &&
              rescentTransactions[i].date.day == weekDay.day &&
              rescentTransactions[i].date.year == weekDay.year) {
            weekDayAmountSpent += double.parse(rescentTransactions[i].amount);
          }
        }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'amount': weekDayAmountSpent,
        };
      },
    );
  }

  double get totalSpending {
    return rescentTransactions.fold(0.0, (sum, item) {
      return sum + double.parse(item.amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionValues.map((data) {
              return ChartBar(
                data['day'],
                data['amount'],
                double.parse(data['amount'].toString()) / totalSpending,
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
