import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';

class DraggableInfo extends StatelessWidget {
  final PolygonInfo polygonInfo;
  const DraggableInfo({super.key, required this.polygonInfo});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.4,
      minChildSize: 0.07,
      initialChildSize: 0.4,
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
              const Center(
                child: Icon(
                  Icons.horizontal_rule,
                  color: grey,
                  size: 30,
                ),
              ),
              const SizedBox(height: 15),
              TextWidget(
                text: 'Información de ${polygonInfo.zona}',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color2,
                height: 1.50,
                letterSpacing: 0.50,
              ),
              const SizedBox(height: 18.0),
              RowInfo(
                  title: 'Contenido de humedad',
                  value: '${polygonInfo.contenidoDeHumedad}'),
              const SizedBox(height: 16),
              RowInfo(
                  title: 'Tipo de suelo', value: '${polygonInfo.tipoDeSuelo}'),
              const SizedBox(height: 16),
              RowInfo(title: 'Densidad', value: '${polygonInfo.densidad}'),
              const SizedBox(height: 16),
              RowInfo(
                  title: 'Capacidad portante',
                  value: '${polygonInfo.capacidadPortante}'),
            ],
          ),
        );
      },
    );
  }
}

class RowInfo extends StatelessWidget {
  final String title;
  final String value;
  const RowInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextWidget(
            text: title,
            fontSize: 16,
            color: color1,
            fontWeight: FontWeight.w400,
            height: 1.50,
            letterSpacing: 0.50,
          ),
        ),
        TextWidget(
          text: value,
          fontSize: 16,
          color: color2,
          fontWeight: FontWeight.w500,
          height: 1.14,
          letterSpacing: 0.50,
        )
      ],
    );
  }
}
