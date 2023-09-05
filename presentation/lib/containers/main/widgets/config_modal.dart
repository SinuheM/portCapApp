import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:presentation/containers/main/bloc/map_bloc.dart';
import 'package:presentation/containers/main/widgets/animated_icon.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';

class ConfigModal extends StatefulWidget {
  const ConfigModal({super.key});

  @override
  State<ConfigModal> createState() => _ConfigModalState();
}

class _ConfigModalState extends State<ConfigModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Port Cap',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: color1,
                  height: 1.33,
                ),
                const SizedBox(height: 16),
                const TextWidget(
                  text: 'Creado por: Kathy Bilbao Rojas',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: color2,
                  height: 1.25,
                  letterSpacing: 0.25,
                ),
                const SizedBox(height: 9),
                BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    final DateFormat dateFormat =
                        DateFormat('dd/MM/yyyy hh:mm:ss');
                    final isInfoLoading = state.isInfoLoading;
                    if (isInfoLoading) {
                      _animationController.repeat();
                    } else {
                      _animationController.stop();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text:
                              'Ultima actualización: ${state.dateLastUpdate != null ? dateFormat.format(state.dateLastUpdate!) : '-'}',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: color3,
                          height: 1.67,
                          letterSpacing: 0.25,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            final mapBloc = context.read<MapBloc>();
                            mapBloc
                              ..add(const GetPolygonsEvent(forceRefresh: true))
                              ..add(const GetPolygonsInformationEvent(
                                  forceRefresh: true));
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: grey2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                SpinningIconButton(
                                  controller: _animationController,
                                  iconData: Icons.sync,
                                  onPressed: () async {
                                    _animationController.stop();
                                  },
                                ),
                                const SizedBox(width: 4),
                                const TextWidget(text: 'Actualizar Información')
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
