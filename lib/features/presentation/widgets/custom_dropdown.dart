
import 'package:dairy_track/features/presentation/themes/themes.dart';
import 'package:flutter/material.dart';


class CustomDropdownFormField extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
     
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Themes.secondary,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        
        hintText: 'Select $labelText',
        
        border: _outlineBorder(),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        errorBorder: _errorBorder(),
      ),
      items: items
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
    );
  }

  OutlineInputBorder _outlineBorder() {
    return OutlineInputBorder(
      borderRadius: Themes.radius10,
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: Themes.radius10,
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: Themes.radius10,
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    );
  }

  OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderRadius: Themes.radius10,
      borderSide: BorderSide(color: Colors.blue[200]!),
    );
  }
}
