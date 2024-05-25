import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/containers/main/widgets/calculator.dart';
import 'package:presentation/containers/main/widgets/info.dart';
import 'package:presentation/containers/main/widgets/result.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';

class DraggableInfo extends StatefulWidget {
  final PolygonInfo polygonInfo;
  final Function()? onClose;
  const DraggableInfo({
    super.key,
    required this.polygonInfo,
    required this.onClose,
  });

  @override
  State<DraggableInfo> createState() => _DraggableInfoState();
}

class _DraggableInfoState extends State<DraggableInfo> {
  int currentStep = 0;
  Map<String, dynamic> _result = {};

  calculateCimentation() {
    setState(() {
      currentStep = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: widget.key,
      maxChildSize: 0.8,
      minChildSize: 0.1,
      initialChildSize: 0.45,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: white,
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.horizontal_rule,
                      color: grey,
                      size: 30,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: widget.onClose,
                          icon: const Icon(Icons.close)))
                ],
              ),
              const SizedBox(height: 15),
              if (currentStep == 0)
                InfoCard(
                  polygonInfo: widget.polygonInfo,
                  onCalculate: () {
                    setState(() {
                      currentStep = 1;
                    });
                  },
                ),
              if (currentStep == 1)
                CalculatorCard(
                  currentValues: _result,
                  polygonInfo: widget.polygonInfo,
                  onCalculate: (result) {
                    setState(() {
                      currentStep = 2;
                      _result = result;
                    });
                  },
                ),
              if (currentStep == 2)
                ResultCard(
                  result: _result,
                  onReturn: () {
                    setState(() {
                      currentStep = 1;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class RowInfo extends StatelessWidget {
  final String title;
  final String? value;
  final String? secondValue;
  final bool hasBullet;
  const RowInfo(
      {super.key,
      required this.title,
      this.value,
      this.secondValue,
      this.hasBullet = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: '•  $title',
          fontSize: 16,
          color: color1,
          fontWeight: FontWeight.bold,
          height: 1.50,
          letterSpacing: 0.50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasBullet)
                const TextWidget(
                  text: '• ',
                  fontSize: 14,
                  color: color2,
                  fontWeight: FontWeight.w400,
                  height: 1.14,
                  letterSpacing: 0.50,
                ),
              if (value != null)
                Expanded(
                  child: TextWidget(
                    text: value!,
                    fontSize: 14,
                    color: color2,
                    fontWeight: FontWeight.w400,
                    height: 1.14,
                    letterSpacing: 0.50,
                    maxLines: 10,
                  ),
                ),
            ],
          ),
        ),
        if (secondValue != null)
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasBullet)
                  const TextWidget(
                    text: '• ',
                    fontSize: 14,
                    color: color2,
                    fontWeight: FontWeight.w400,
                    height: 1.14,
                    letterSpacing: 0.50,
                  ),
                Expanded(
                  child: TextWidget(
                    text: secondValue!,
                    fontSize: 14,
                    color: color2,
                    fontWeight: FontWeight.w400,
                    height: 1.14,
                    letterSpacing: 0.50,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
