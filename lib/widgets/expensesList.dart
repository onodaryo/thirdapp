import 'package:flutter/material.dart';

import 'package:keihi/models/expense.dart';
import 'package:keihi/widgets/expenseItem.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, itemBuilder: (ctx, index) => ExpenseItem(expense: expenses[index],)
    );
  }
}
