import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.onSaved,
    this.textInputType = TextInputType.text,
    this.prefixText = "",
  });

  final String hint;
  final int maxLines;
  final TextInputType textInputType;
  final void Function(String?)? onSaved;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          //
          return "Field is required ";
        } else {
          return null;
        }
      },
      // kPrimaryColor,
      maxLines: maxLines,
      keyboardType: textInputType,

      decoration: InputDecoration(
        hintText: hint,
        // hintStyle: const TextStyle(
        //   color: Colors.red,
        // ),
        prefixText: prefixText,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        // focusedBorder: buildOutlineInputBorder(Colors.green),
        // enabledBorder:
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: color ?? Colors.white,
        ));
  }
}
