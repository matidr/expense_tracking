import 'dart:io';

import 'package:expense_tracking/models/expense.dart';
import 'package:expense_tracking/widgets/new_expense/new_expense_landscape.dart';
import 'package:expense_tracking/widgets/new_expense/new_expense_portrait.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: now,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final titleIsInvalid = _titleController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;
    if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
      _showDialog();
      return;
    }
    final expense = Expense(
      amount: enteredAmount,
      title: _titleController.text,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  void _onCategoryChanged(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: width >= 600
                  ? NewExpenseLandscape(
                      titleController: _titleController,
                      amountController: _amountController,
                      selectedCategory: _selectedCategory,
                      selectedDate: _selectedDate,
                      presentDatePicker: _presentDatePicker,
                      onCategoryChanged: _onCategoryChanged,
                      onSubmitExpenseData: _submitExpenseData,
                    )
                  : NewExpensePortrait(
                      titleController: _titleController,
                      amountController: _amountController,
                      selectedCategory: _selectedCategory,
                      selectedDate: _selectedDate,
                      presentDatePicker: _presentDatePicker,
                      onCategoryChanged: _onCategoryChanged,
                      onSubmitExpenseData: _submitExpenseData,
                    ),
            ),
          ),
        );
      },
    );
  }
}
