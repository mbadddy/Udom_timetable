// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_textfield.dart';

class AnimatedRow extends StatefulWidget {
  final String title;
  final TextInputType type;
  final String? value;
  final TextEditingController controller;
  final bool isEditable;
  final bool obcure;
  final String? Function(String? value)? validator;

  const AnimatedRow({
    Key? key,
    required this.title,
    required this.type,
    this.value,
    required this.controller,
    required this.isEditable,
    required this.obcure,
    this.validator,
  }) : super(key: key);

  @override
  State<AnimatedRow> createState() => _AnimatedRowState();
}

class _AnimatedRowState extends State<AnimatedRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TweenAnimationBuilder(
            builder: (_, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(20.0 * value, 0.0),
                child: Transform.translate(
                    offset: const Offset(-20.0, 0.0), child: child),
              ),
            ),
            duration: const Duration(milliseconds: 500),
            tween: Tween(begin: 0.0, end: 1.0),
            child: Text(
              widget.isEditable ? '${widget.title}:' : '* ${widget.title}:',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Divider(),
          Flexible(
            child: TweenAnimationBuilder(
              builder: (_, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(-20.0 * value, 0.0),
                  child: Transform.translate(
                      offset: const Offset(20.0, 0.0), child: child),
                ),
              ),
              duration: const Duration(milliseconds: 500),
              tween: Tween(begin: 0.0, end: 1.0),
              child: widget.isEditable
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.value ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  : CustomTextField(
                      value: widget.value,
                      controller: widget.controller,
                      hint: 'fill your ${widget.title.toLowerCase()}',
                      validator: widget.validator, type: widget.type, obscure: widget.obcure,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
