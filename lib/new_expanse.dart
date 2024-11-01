import 'package:expenses/widgets/custom_Text_Form_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class AddNewExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24, left: 16, right: 16),
      child: SingleChildScrollView(
        child: AddNoteForm(),
      ),
    );
  }
}

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> form_key = GlobalKey();
  AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled; // if entered wronge input
  String? title;
  double? amount;
  DateTime? _selectedDate;
  final _dateFormat = DateFormat(
      'yyyy-MM-dd'); // == DateFormat dateFormated = DateFormat.yMd();
  Category selectedCategory = Category.travel;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate; // Update the selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form_key,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            hint: "Title",
            onSaved: (value) {
              title = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            hint: 'amount',
            maxLines: 1,
            prefixText: "\$",
            textInputType: TextInputType.number,
            onSaved: (value) {
              amount = double.tryParse(value!);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          // CustomBotton(
          //   onTap: () {
          //     if (form_key.currentState!.validate()) {
          //       form_key.currentState!.save();
          //     } else {
          //       autovalidateMode = AutovalidateMode.always;
          //       setState(() {});
          //     }
          //     ;
          //   },
          // ),
          CustomTextField(
            hint: 'Date',
            maxLines: 1,
            textInputType: TextInputType.number,
            onSaved: (value) => _selectDate(context),
          ),
          const SizedBox(
            height: 30,
          ),
          DropdownButton(
            value: selectedCategory,
            items: Category.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name.toUpperCase()),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (form_key.currentState!.validate()) {
                    form_key.currentState!.save();
                  } else {
                    // autovalidateMode = AutovalidateMode.always;
                    // setState(() {});
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("error"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: Text("okay"),
                          ),
                        ],
                      ),
                    );
                  }
                  ;
                },
                child: Text("Save"),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
