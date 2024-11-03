import 'package:expenses/widgets/custom_text_form_field.dart';
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
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: SingleChildScrollView(
          child: AddNoteForm(
            addExpense: addExpense,
          ),
        ),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _title;
  double? _amount;
  DateTime? _selectedDate;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  Category _selectedCategory = Category.travel;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
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

      // Check if all required fields have values
      if (_title == null || _amount == null || _selectedDate == null) {
        // Show an alert if any field is missing
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Missing Fields"),
            content: const Text("Please ensure all fields are filled."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"),
              ),
            ],
          ),
        );
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
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please fill all fields correctly."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
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
            onSaved: (value) {
              _title = value;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hint: 'Amount',
            maxLines: 1,
            prefixText: "\$",
            textInputType: TextInputType.number,
            onSaved: (value) {
              _amount = double.tryParse(value!);
            },
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
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
              }
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
