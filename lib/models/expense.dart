import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, word }

class Expanse {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  Expanse({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}
