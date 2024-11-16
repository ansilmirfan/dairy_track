
import 'package:dairy_track/features/presentation/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool password;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.password = false,
    this.keyboardType,
    this.maxLength,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      maxLength: widget.maxLength,
      controller: widget.controller,
      obscureText: widget.password ? !_isPasswordVisible : false,
      keyboardType: widget.keyboardType,
      decoration: _inputDecoration(),
      style: _textStyle(),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Themes.secondary,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintText: 'Enter ${widget.labelText}',
      labelText: widget.labelText,
      hintStyle: TextStyle(color: Colors.grey[400]),
      border: _outlineBorder(),
      enabledBorder: _enabledBorder(),
      focusedBorder: _focusedBorder(),
      errorBorder: _errorBorder(),
      suffixIcon: widget.password
          ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
          : null,
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
