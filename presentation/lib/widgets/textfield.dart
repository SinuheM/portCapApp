import 'dart:math';

import 'package:flutter/material.dart';
import 'package:presentation/helpers/input_formatters/uppercase.dart';
import 'package:presentation/styles/theme.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends StatelessWidget {
  final String controller;
  final TextInputType textInputType;
  final List<Validators> validators;
  final int? maxLines;
  final int? maxLength;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Map<String, String Function(Object)>? messages;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final bool expands;
  final Function? onChanged;

  const CustomTextField({
    Key? key,
    this.validators = const [],
    this.maxLines = 1,
    this.maxLength,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.expands = false,
    this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.messages,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Random().nextBool() ? Colors.red : Colors.blue,
      height: 40,
      child: ReactiveTextField(
        maxLength: maxLength,
        readOnly: readOnly,
        formControlName: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        maxLines: 1,
        expands: expands,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          if (textInputType == TextInputType.text) UpperCaseTextFormatter(),
        ],
        onChanged: (control) {
          if (onChanged != null) {
            onChanged!(control.value);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          counterText: ' ',
          labelStyle: const TextStyle(color: black),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff1E1E1E)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xff1E1E1E)),
          ),
        ),
        validationMessages: messages,
      ),
    );
  }
}
