import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';

class DraggableInfo extends StatelessWidget {
  final PolygonInfo polygonInfo;
  const DraggableInfo({super.key, required this.polygonInfo});

  @override
  Widget build(BuildContext context) {
    Offset imageOffset = const Offset(110.0, 15.0);
    return DraggableScrollableSheet(
      key: key,
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
              const Center(
                child: Icon(
                  Icons.horizontal_rule,
                  color: grey,
                  size: 30,
                ),
              ),
              const SizedBox(height: 15),
              TextWidget(
                text: 'Información del ${polygonInfo.id}',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color2,
                height: 1.50,
                letterSpacing: 0.50,
              ),
              const SizedBox(height: 18.0),
              RowInfo(
                  title: 'Zonificación',
                  value: '${polygonInfo.zona}'),
              const SizedBox(height: 1),
              SizedBox(
                height: 1,
                width: 1,
                child: Transform.translate(
                  offset: imageOffset,
                  child: Transform.scale(
                    scale: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/dibujo_app-removebg-preview.png'), // ruta de la imagen
                          fit: BoxFit.contain, // ajustar la imagen al contenedor
                        ),
                      ),
                    )
                  )
                ),
              ),
              const SizedBox(height: 18.0),
              RowInfo(
                  title: 'Contenido de humedad',
                  value: '${polygonInfo.contenidoDeHumedad}'),
              const SizedBox(height: 16),
              RowInfo(
                  title: 'Límites',
                  value: '${polygonInfo.limites?.join('\n')}'),
              const SizedBox(height: 16),
              RowInfo(
                hasBullet: true,
                title: 'Tipo de suelo',
                value: 'Clasificación SUCS\n${polygonInfo.tipoDeSueloSucs}',
                secondValue:
                    'Clasificación AASHTO\n${polygonInfo.tipoDeSueloAashto}',
              ),
              const SizedBox(height: 16),
              RowInfo(
                title: 'Peso específico natural',
                value: '${polygonInfo.pesoEspecficoNatural}',
              ),
              const SizedBox(height: 16),
              RowInfo(
                  title: 'Cohesión y ángulo de fricción',
                  value: '${polygonInfo.cohesinYAnguloDeFriccin?.join('\n')}'),
              const SizedBox(height: 16),
              RowInfo(
                title: 'Capacidad portante',
                value: '${polygonInfo.capacidadPortante}'),
              const SizedBox(height: 16),
              RowInfo(
                title: 'Cimentación superficial propuesta',
                value: '${polygonInfo.cimentacionSuperficialPropuesta?.join('\n')}'),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
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
  final String? secondValue;
  final bool hasBullet;
  const RowInfo(
      {super.key,
      required this.title,
      required this.value,
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
              Expanded(
                child: TextWidget(
                  text: value,
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
