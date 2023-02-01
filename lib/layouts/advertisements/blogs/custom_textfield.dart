// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
    final TextInputType type;
  final IconData? icon;
  final String hint;
  final TextEditingController controller;
  final bool passType;
  final bool obscure;
  final String? value;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.type,
    this.icon,
    required this.hint,
    required this.controller,
    this.passType = false,
    required this.obscure,
    this.value,
    required this.validator
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    if (widget.value != null) {
      widget.controller.text = widget.value ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          keyboardType: widget.type,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.obscure,
          enableSuggestions: !widget.passType,
          autocorrect: !widget.passType,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: Color.fromARGB(255, 0, 153, 38),
                  )
                : null,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 153, 38)),
          ),
        ),
      ),
    );
  }
}
