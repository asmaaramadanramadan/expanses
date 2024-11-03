import '../models/expense.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expanse> expenses;

  get buckets {
    return [
      ExpensesBucket.forCategory(Category.food, expenses),
      ExpensesBucket.forCategory(Category.work, expenses),
      ExpensesBucket.forCategory(Category.leisure, expenses),
      ExpensesBucket.forCategory(Category.travel, expenses),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDaekMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final ele in buckets)
                      ChartBar(
                        fill: ele.totalExpenses == 0
                            ? 0
                            : ele.totalExpenses / maxTotalExpense,
                      ),
                  ],
                ),
              ),
              constraints.maxHeight < 200
                  ? Container()
                  : SizedBox(
                      height: 12,
                    ),
              constraints.maxHeight < 200
                  ? Container()
                  : Row(
                      children: buckets
                          .map<Widget>((e) => Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Icon(
                                    categoryIcons[e.category],
                                    color: isDaekMode
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.7),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
