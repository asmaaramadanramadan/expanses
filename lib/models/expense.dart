import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expanse {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return dateFormat.format(date);
  }

  Expanse({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}

class ExpensesBucket {
  final Category category;
  final List<Expanse> expanses;

  ExpensesBucket(this.category, this.expanses);

  ExpensesBucket.forCategory(this.category, List<Expanse> allExpanses)
      : expanses = allExpanses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expanses) {
      sum += expense.amount;
    }
    return sum;
  }
}
