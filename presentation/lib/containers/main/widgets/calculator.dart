import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/containers/main/bloc/map_bloc.dart';
import 'package:presentation/containers/main/widgets/draggable_info.dart';
import 'package:presentation/containers/main/widgets/textfield.dart';
import 'package:presentation/widgets/button.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CalculatorCard extends StatefulWidget {
  final PolygonInfo polygonInfo;
  final Function(Map<String, dynamic>) onCalculate;
  final Map<String, dynamic> currentValues;
  const CalculatorCard(
      {super.key,
      required this.polygonInfo,
      required this.onCalculate,
      required this.currentValues});

  @override
  State<CalculatorCard> createState() => _CalculatorCardState();
}

class _CalculatorCardState extends State<CalculatorCard> {
  final FormGroup form = FormGroup({
    'cohesion': FormControl<String>(validators: [Validators.required]),
    'frictionAngle': FormControl<String>(validators: [Validators.required]),
    'weight': FormControl<String>(),
    'df': FormControl<String>(validators: [Validators.required]),
    'B': FormControl<String>(validators: [Validators.required]),
    'L': FormControl<String>(validators: [Validators.required]),
    'loadAdmissible': FormControl<String>(disabled: true, validators: []),
  });

  calculateLoadAdmissible(Map<String, dynamic> data) {
    if (!form.valid) return;
    Config? config = context.read<MapBloc>().state.config;
    // qu = C(Nc)(Fcs)(Fcd)(Fci) + γ(Df)(Nq)(Fqs)(Fqd)(Fqi) + 0.5γ(B)(Nγ)(Fγs)(Fγd)(Fγi)
    // B32*B39*B42*B45*B48+B38*B35*B40*B43*B46*B48+0.5*B38*B36*B41*B44*B47*B49
    double b32 = double.parse(data['cohesion']);
    double b33 = double.parse(data['frictionAngle']);
    //viene de firebase
    double b34 = config?.values?.beta ?? 0.0;
    double b35 = double.parse(data['df']);
    double b36 = double.parse(data['B']);
    double b37 = double.parse(data['L']);
    //Peso especifico del suelo
    double b38 = double.parse(data['weight']);
    // =EXP(PI()*TAN(B33*PI()/180))*TAN((45+B33/2)*PI()/180)^2
    double b40 =
        exp(pi * tan(b33 * pi / 180)) * pow(tan((45 + b33 / 2) * pi / 180), 2);
    // =(B40-1)/(TAN(B33*PI()/180))
    double b39 = (b40 - 1) / tan(b33 * pi / 180);
    // =2*(B40+1)*TAN(B33*PI()/180)
    double b41 = 2 * (b40 + 1) * tan(b33 * pi / 180);
    // =1+(B36/B37)*(B40/B39)
    double b42 = 1 + (b36 / b37) * (b40 / b39);
    // =1+(B36/B37)*TAN(B33*PI()/180)
    double b43 = 1 + (b36 / b37) * tan(b33 * pi / 180);
    // =1-0.4*B36/B37
    double b44 = 1 - 0.4 * b36 / b37;
    // =1+0.4*B35/B36
    double b45 = 1 + 0.4 * b35 / b36;
    // =1+2*TAN(B33*PI()/180)*((1-SENO(B33*PI()/180))^2)*(B35/B36)
    double b46 = 1 +
        2 *
            tan(b33 * pi / 180) *
            pow((1 - sin(b33 * pi / 180)), 2) *
            (b35 / b36);
    double b47 = config?.values?.fd ?? 0.0;
    // =(1-B34/90)^2
    double b48 = pow((1 - b34 / 90), 2).toDouble();
    // =(1-B34/B33)^2
    double b49 = pow((1 - b34 / b33), 2).toDouble();
    double b50 = config?.values?.fs ?? 0.0;
    // =B32*B39*B42*B45*B48+B38*B35*B40*B43*B46*B48+0.5*B38*B36*B41*B44*B47*B49
    double b52 = b32 * b39 * b42 * b45 * b48 +
        b38 * b35 * b40 * b43 * b46 * b48 +
        0.5 * b38 * b36 * b41 * b44 * b47 * b49;

    // =C52/B50/10
    double cimentation = b52 / b50 / 10;

    form.control('loadAdmissible').value = cimentation.toString();
  }

  @override
  void initState() {
    super.initState();
    form.patchValue(widget.currentValues.isEmpty
        ? {
            'cohesion':
                widget.polygonInfo.cohesinYAnguloDeFriccin?.c.toString(),
            'weight': 
              widget.polygonInfo.pesoEspecficoNatural.toString(),
            'frictionAngle':
                widget.polygonInfo.cohesinYAnguloDeFriccin?.q.toString()
          }
        : widget.currentValues);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          const SizedBox(height: 18.0),
          const RowInfo(
            title: 'Cohesión y angulo de fricción',
          ),
          CalculatorTextfield(
            prefixLabel: 'c',
            suffixLabel: 'kg/cm2',
            formControlName: 'cohesion',
            onChanged: (val) {
              calculateLoadAdmissible(form.value);
            },
          ),
          const SizedBox(height: 2),
          CalculatorTextfield(
            prefixLabel: 'φ',
            suffixLabel: 'º',
            formControlName: 'frictionAngle',
            onChanged: (val) {
              calculateLoadAdmissible(form.value);
            },
          ),
          const SizedBox(height: 25.0),
          const RowInfo(
            title: 'Dimensiones de cimentación',
          ),
          CalculatorTextfield(
            prefixLabel: 'Df',
            suffixLabel: 'm',
            formControlName: 'df',
            onChanged: (val) {
              calculateLoadAdmissible(form.value);
            },
          ),
          const SizedBox(height: 2),
          CalculatorTextfield(
            prefixLabel: 'B',
            suffixLabel: 'm',
            formControlName: 'B',
            onChanged: (val) {
              calculateLoadAdmissible(form.value);
            },
          ),
          const SizedBox(height: 2),
          CalculatorTextfield(
            prefixLabel: 'L',
            suffixLabel: 'm',
            formControlName: 'L',
            onChanged: (val) {
              calculateLoadAdmissible(form.value);
            },
          ),
          const SizedBox(height: 25.0),
          const RowInfo(
            title: 'Carga admisible (qadm)',
          ),
          const CalculatorTextfield(
            readOnly: true,
            formControlName: 'loadAdmissible',
            suffixLabel: 'kg/cm2',
          ),
          const SizedBox(height: 33),
          ReactiveFormConsumer(builder: (context, form, child) {
            return CustomButton(
              text: 'CIMENTACIÓN PROPUESTA',
              percentWidth: 1,
              onPressed: form.valid
                  ? () {
                      widget.onCalculate(form.rawValue);
                    }
                  : null,
              buttonColor: const Color(0xffA92918),
              borderRadius: 19,
              height: 60,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            );
          }),
          const SizedBox(height: 33),
        ],
      ),
    );
  }
}
