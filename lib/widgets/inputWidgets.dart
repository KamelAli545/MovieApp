import 'package:flutter/material.dart';

class InputWidgets extends StatefulWidget {
  const InputWidgets({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.color,
    this.prefixIcon,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool obscureText;
  final Color? color;
  final IconData? prefixIcon;

  @override
  State<InputWidgets> createState() => _InputWidgetsState();
}

class _InputWidgetsState extends State<InputWidgets> {
  late bool _hidden = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        readOnly: widget.readOnly,
        obscureText: _hidden,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.color != null ? TextStyle(color: widget.color) : null,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: Colors.white70)
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _hidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70,
            ),
            onPressed: () => setState(() => _hidden = !_hidden),
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}