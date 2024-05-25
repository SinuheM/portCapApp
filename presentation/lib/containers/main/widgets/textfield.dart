import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CalculatorTextfield extends StatelessWidget {
  final String? prefixLabel;
  final String? suffixLabel;
  final String formControlName;
  final bool readOnly;
  final Function? onChanged;
  const CalculatorTextfield(
      {super.key,
      this.prefixLabel,
      this.suffixLabel,
      required this.formControlName,
      this.onChanged,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          if (prefixLabel != null) ...[
            SizedBox(
              width: 20,
              child: TextWidget(
                text: prefixLabel!,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color2,
                height: 1.50,
                letterSpacing: 0.50,
              ),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: SizedBox(
              height: 40,
              child: ReactiveTextField(
                formControlName: formControlName,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (val) {
                  if (onChanged != null) onChanged!(val);
                },
                decoration: InputDecoration(
                  enabled: !readOnly,
                  fillColor: const Color(0xffD7DEDE),
                  filled: readOnly,
                  contentPadding: const EdgeInsets.all(8),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xff1E1E1E)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xff1E1E1E)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xff1E1E1E)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  suffixIcon: suffixLabel != null
                      ? Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 40,
                            width: 75,
                            decoration: BoxDecoration(
                              color: const Color(0xffD7DEDE),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              border:
                                  Border.all(color: const Color(0xff1E1E1E)),
                            ),
                            child: Center(child: Text(suffixLabel!)),
                          ),
                        )
                      : null,
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.right,
                maxLines: 3,
                minLines: 2,
                textInputAction: TextInputAction.next,
                showErrors: (control) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
