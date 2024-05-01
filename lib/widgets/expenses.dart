import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:keihi/models/expense.dart';
import 'package:keihi/widgets/expensesList.dart';
import 'package:keihi/widgets/newExpense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(title: 'Flutter Course', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense(onAddExpense: _addExpense,));
  }

  void _addExpense(Expense expense){
    setState((){
      _registeredExpense.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children:[
          const Text('This is ChartSpace.'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpense),
          ),
        ],
      ),
    );
  }
}
