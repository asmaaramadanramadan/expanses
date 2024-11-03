import 'dart:io';
import 'package:expenses/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class AddNewExpense extends StatelessWidget {
  final void Function(Expanse expense) addExpense;

  const AddNewExpense({
    super.key,
    required this.addExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: SingleChildScrollView(
        child: AddNoteForm(addExpense: addExpense),
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  final void Function(Expanse expense) addExpense;
  const AddNoteForm({
    super.key,
    required this.addExpense,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _title;
  double? _amount;
  DateTime? _selectedDate;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  Category _selectedCategory = Category.travel;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_title == null || _amount == null || _selectedDate == null) {
        _showPlatformSpecificDialog(
            context, "Missing Fields", "Please ensure all fields are filled.");
        return;
      }

      widget.addExpense(Expanse(
        amount: _amount!,
        title: _title!,
        category: _selectedCategory,
        date: _selectedDate!,
      ));
      Navigator.pop(context);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
      _showPlatformSpecificDialog(
          context, "Error", "Please fill all fields correctly.");
    }
  }

  void _showPlatformSpecificDialog(
      BuildContext context, String title, String content) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            hint: "Title",
            onSaved: (value) => _title = value,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Amount',
            prefixText: "\$",
            textInputType: TextInputType.number,
            onSaved: (value) => _amount = double.tryParse(value ?? ''),
          ),
          const SizedBox(height: 30),
          DropdownButton<Category>(
            value: _selectedCategory,
            items: Category.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name.toUpperCase()),
                    ))
                .toList(),
            onChanged: (value) => setState(() {
              if (value != null) _selectedCategory = value;
            }),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text("Save"),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
