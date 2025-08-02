import 'package:expense_tracking/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpensePortrait extends StatelessWidget {
  const NewExpensePortrait({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.selectedCategory,
    this.selectedDate,
    required this.presentDatePicker,
    required this.onCategoryChanged,
    required this.onSubmitExpenseData,
  });

  final TextEditingController titleController;
  final TextEditingController amountController;
  final DateTime? selectedDate;
  final Category selectedCategory;
  final Function() presentDatePicker;
  final Function(Category) onCategoryChanged;
  final Function() onSubmitExpenseData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          maxLength: 50,
          decoration: const InputDecoration(label: Text('Title')),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  prefixText: "\$",
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedDate == null
                        ? 'No date selected'
                        : formatter.format(selectedDate!),
                  ),
                  IconButton(
                    onPressed: presentDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          spacing: 10,
          children: [
            DropdownButton(
              value: selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                onCategoryChanged(value);
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: onSubmitExpenseData,
              child: const Text('Save expense'),
            ),
          ],
        ),
      ],
    );
  }
}
