import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class CustomCard extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  final Key key;

  CustomCard(this.transaction, this.deleteTransaction, this.key)
      : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late Color _color;
  @override
  void initState() {
    List<Color> colorChoices = [
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.purple
    ];
    _color = colorChoices[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          children: [
            FittedBox(
              child: Container(
                width: mediaQuery.size.width * 0.4,
                // padding: EdgeInsets.all(10),
                child: Text(
                  'Rs ${widget.transaction.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    // color: Theme.of(context).primaryColor,
                    color: _color,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.54,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Theme.of(context).primaryColor,
                //     width: 2,
                //   ),
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.transaction.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy')
                              .format(widget.transaction.date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: !isLandscape
                          ? IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              onPressed: () {
                                widget.deleteTransaction(widget.transaction.id);
                              },
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).errorColor),
                              ),
                              onPressed: () => widget
                                  .deleteTransaction(widget.transaction.id),
                              child: Text('Delete'),
                            ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
