import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/containers/main/widgets/draggable_info.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/button.dart';
import 'package:presentation/widgets/text.dart';

class InfoCard extends StatelessWidget {
  final PolygonInfo polygonInfo;
  final Function() onCalculate;
  const InfoCard(
      {super.key, required this.polygonInfo, required this.onCalculate});

  @override
  Widget build(BuildContext context) {
    Offset imageOffset = const Offset(110.0, 15.0);

    return Column(
      children: [
        TextWidget(
          text: 'Información del ${polygonInfo.id}',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color2,
          height: 1.50,
          letterSpacing: 0.50,
        ),
        const SizedBox(height: 18.0),
        RowInfo(title: 'Zonificación', value: '${polygonInfo.zona}'),
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
                        image: AssetImage(
                            'assets/images/dibujo_app-removebg-preview.png'), // ruta de la imagen
                        fit: BoxFit.contain, // ajustar la imagen al contenedor
                      ),
                    ),
                  ))),
        ),
        const SizedBox(height: 18.0),
        RowInfo(
            title: 'Contenido de humedad',
            value: '${polygonInfo.contenidoDeHumedad}'),
        const SizedBox(height: 16),
        RowInfo(title: 'Límites', value: '${polygonInfo.limites?.join('\n')}'),
        const SizedBox(height: 16),
        RowInfo(
          hasBullet: true,
          title: 'Tipo de suelo',
          value: 'Clasificación SUCS\n${polygonInfo.tipoDeSueloSucs}',
          secondValue: 'Clasificación AASHTO\n${polygonInfo.tipoDeSueloAashto}',
        ),
        const SizedBox(height: 16),
        RowInfo(
          title: 'Peso específico natural',
          value: '${polygonInfo.pesoEspecficoNatural}',
        ),
        const SizedBox(height: 16),
        RowInfo(
            title: 'Cohesión y ángulo de fricción',
            value: 'c ${polygonInfo.cohesinYAnguloDeFriccin?.c}\n'
                'φ ${polygonInfo.cohesinYAnguloDeFriccin?.q}'),
        const SizedBox(height: 16),
        RowInfo(
            title: 'Capacidad portante',
            value: '${polygonInfo.capacidadPortante}'),
        const SizedBox(height: 33),
        CustomButton(
          text: 'CALCULO DE CIMENTACIÓN',
          percentWidth: 1,
          onPressed: onCalculate,
          buttonColor: const Color(0xffA92918),
          borderRadius: 19,
          height: 60,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 33),
      ],
    );
  }
}
