import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expanses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expanse> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => ExpensesItem(
        expense: expenses[index],
      ),
    );
  }
}
