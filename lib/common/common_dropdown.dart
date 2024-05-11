import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged onChanged;
  final int value;
  final List<DropdownMenuItem<int>> items;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.value,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<int>(
        value: value,
        onChanged: onChanged,
        items: items,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value < 0 || value > 14) {
            return 'Please select a value between 0 and 14';
          }
          return null;
        },
      ),
    );
  }
}
