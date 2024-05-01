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
        background: Container(
          padding:const EdgeInsets.symmetric(vertical: 36),
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          child: const Text(
            'Remove this item',
            textAlign: TextAlign.end,
            style: TextStyle(color: Color.fromARGB(255, 252, 139, 139),
            ),
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemovedExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
