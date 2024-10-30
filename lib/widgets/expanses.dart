import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expanses_list/expanses_list.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  final List<Expanse> _registeredExpenses = [
    Expanse(
      category: Category.work,
      title: "title ",
      amount: 29.9,
      date: DateTime.now(),
    ),
    Expanse(
      category: Category.food,
      title: "title ",
      amount: 29.9,
      date: DateTime.now(),
    ),
    Expanse(
      category: Category.leisure,
      title: "title ",
      amount: 29.9,
      date: DateTime.now(),
    ),
    Expanse(
      category: Category.travel,
      title: "title ",
      amount: 29.9,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome"),
            Expanded(
              child: ExpensesList(
                expenses: _registeredExpenses,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
