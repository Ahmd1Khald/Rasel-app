import 'package:flutter/material.dart';

class ReusableTextFormField extends StatefulWidget {
  final String hintText;
  final Function(String) validator;
  final Function(String) onSaved;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const ReusableTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  _ReusableTextFormFieldState createState() => _ReusableTextFormFieldState();
}

class _ReusableTextFormFieldState extends State<ReusableTextFormField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password,color: Colors.white,),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white,),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.white,),
          onPressed: _toggle,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
      ),
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      validator: (value) => widget.validator(value!),
      onSaved: (value) => widget.onSaved(value!),
    );
  }
}