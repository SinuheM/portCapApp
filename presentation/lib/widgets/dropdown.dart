import 'package:flutter/material.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDropdown<T> extends StatelessWidget {
  final Function(dynamic deliveryType) onChangedValue;
  final String controller;
  final List items;
  final String itemLabel;
  final String itemValue;
  final List<Validators> validators;
  final Widget? prefixIcon;
  final Map<String, String Function(Object)>? messages;
  final String hintText;
  final bool readOnly;
  const CustomDropdown(
      {Key? key,
      this.validators = const [],
      required this.items,
      required this.itemLabel,
      required this.itemValue,
      required this.hintText,
      required this.controller,
      this.readOnly = false,
      this.prefixIcon,
      this.messages,
      required this.onChangedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
          text: hintText,
          fontWeight: FontWeight.w400,
          color: grey,
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 70,
          child: ReactiveDropdownField<T>(
            readOnly: readOnly,
            items: [
              for (Map item in items)
                DropdownMenuItem(
                  value: item[itemValue],
                  child: Text(item[itemLabel]),
                ),
            ],
            formControlName: controller,
            onChanged: (val) {
              onChangedValue(items
                  .firstWhere((element) => element[itemValue] == val.value));
            },
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                color: red,
              ),
              contentPadding: const EdgeInsets.only(left: 12, right: 12),
              counterText: ' ',
              labelText: null,
              labelStyle: const TextStyle(color: black),
              prefixIcon: prefixIcon,
              alignLabelWithHint: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: grey),
              ),
            ),
            validationMessages: messages,
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
