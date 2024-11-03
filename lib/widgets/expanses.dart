import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../chart/chart.dart';
import '../models/expense.dart';
import '../new_expanse.dart';
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
  void addExpenses(Expanse expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpenses(Expanse expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => AddNewExpense(
                  addExpense: addExpenses,
                ),
              );
              // showBottomSheet(context: context, builder:(context) => ,)
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                children: [
                  Chart(
                    expenses: _registeredExpenses,
                  ),
                  Expanded(
                    child: ExpensesList(
                      removeExpense: removeExpenses,
                      expenses: _registeredExpenses,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(
                      expenses: _registeredExpenses,
                    ),
                  ),
                  Expanded(
                    child: ExpensesList(
                      removeExpense: removeExpenses,
                      expenses: _registeredExpenses,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
