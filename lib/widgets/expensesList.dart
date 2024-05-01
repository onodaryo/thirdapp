import 'package:flutter/material.dart';

import 'package:keihi/models/expense.dart';
import 'package:keihi/widgets/expenseItem.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemovedExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemovedExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
