import 'package:expense_tracking/models/expense.dart';
import 'package:expense_tracking/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseRemoved,
  });

  final List<Expense> expenses;
  final Function(Expense) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expenses[index].id),
        onDismissed: (direction) {
          onExpenseRemoved(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
