import 'package:flutter/material.dart';
import 'package:presentation/helpers/input_formatters/uppercase.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';
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
  final String hintText;
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
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.messages,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: hintText,
          fontWeight: FontWeight.w400,
          color: grey,
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 70,
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              errorStyle: const TextStyle(
                color: red,
              ),
              counterText: ' ',
              labelText: null,
              labelStyle: const TextStyle(color: black),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              alignLabelWithHint: false,
              hintText: null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: grey),
              ),
            ),
            validationMessages: messages,
          ),
        ),
      ],
    );
  }
}
