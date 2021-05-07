import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './data/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  List<Transaction> get _rescentTransactions {
    return transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 8),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, String amount, DateTime date) {
    final tempTx = Transaction(
      id: transactions.length,
      amount: amount,
      name: title,
      date: date,
    );
    setState(() {
      transactions.add(tempTx);
    });
  }

  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  void _deleteTransaction(id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final listTransactionWidget = Container(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appbar.preferredSize.height) *
          0.8,
      child: TransactionList(transactions, _deleteTransaction),
    );

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape && transactions.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            Container(
              width: double.infinity,
              child: transactions.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Oops, no transaction yet!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          'assets/images/oops.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        if (!isLandscape)
                          Container(
                            height: (mediaQuery.size.height -
                                    mediaQuery.padding.top -
                                    appbar.preferredSize.height) *
                                0.2,
                            child: Chart(_rescentTransactions),
                          ),
                        if (!isLandscape) listTransactionWidget,
                        if (isLandscape)
                          _showChart
                              ? Container(
                                  height: (mediaQuery.size.height -
                                          mediaQuery.padding.top -
                                          appbar.preferredSize.height) *
                                      0.8,
                                  child: Chart(_rescentTransactions),
                                )
                              : listTransactionWidget,
                      ],
                    ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: appBody,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: !isLandscape
      //     ? FloatingActionButton(
      //         child: Icon(
      //           Icons.add,
      //         ),
      //         onPressed: () => _startAddNewTransaction(context),
      //       )
      //     : Container(),
    );
  }
}
