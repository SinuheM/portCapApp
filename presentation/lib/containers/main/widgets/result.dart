import 'package:flutter/material.dart';
import 'package:presentation/containers/main/widgets/draggable_info.dart';
import 'package:presentation/containers/main/widgets/textfield.dart';
import 'package:presentation/widgets/button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResultCard extends StatefulWidget {
  final Map<String, dynamic> result;
  final Function() onReturn;
  const ResultCard({super.key, required this.result, required this.onReturn});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  final FormGroup form = FormGroup({
    'cohesion': FormControl<String>(),
    'frictionAngle': FormControl<String>(),
    'df': FormControl<String>(
      disabled: true,
    ),
    'B': FormControl<String>(
      disabled: true,
    ),
    'L': FormControl<String>(
      disabled: true,
    ),
    'loadAdmissible': FormControl<String>(),
  });

  @override
  void initState() {
    super.initState();
    form.patchValue(widget.result);
  }

  getResult() {
    final value = double.parse(form.control('loadAdmissible').value ?? 0.0);
    if (value < 0.8) {
      return 'Platea';
    } else if (value >= 0.8 && value < 1.2) {
      return 'Zapata combinada';
    } else if (value >= 1.2 && value < 1.5) {
      return 'Zapata conectada';
    } else {
      return 'Zapatas aisladas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          const SizedBox(height: 18.0),
          RowInfo(title: getResult()),
          Container(
            height: 160,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/dibujo_app-removebg-preview.png'), // ruta de la imagen
                fit: BoxFit.contain, // ajustar la imagen al contenedor
              ),
            ),
          ),
          const SizedBox(height: 18.0),
          const RowInfo(title: 'Dimensiones de cimentación'),
          const CalculatorTextfield(
            readOnly: true,
            prefixLabel: 'Df',
            suffixLabel: 'm',
            formControlName: 'df',
          ),
          const SizedBox(height: 2),
          const CalculatorTextfield(
            readOnly: true,
            prefixLabel: 'B',
            suffixLabel: 'm',
            formControlName: 'B',
          ),
          const SizedBox(height: 2),
          const CalculatorTextfield(
            readOnly: true,
            prefixLabel: 'L',
            suffixLabel: 'm',
            formControlName: 'L',
          ),
          const SizedBox(height: 33),
          CustomButton(
            text: 'Volver',
            percentWidth: 1,
            onPressed: widget.onReturn,
            buttonColor: const Color(0xffA92918),
            borderRadius: 19,
            height: 60,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 33),
        ],
      ),
    );
  }
}
