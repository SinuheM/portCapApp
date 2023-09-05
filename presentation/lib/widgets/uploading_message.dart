import 'package:flutter/material.dart';
import 'package:presentation/styles/theme.dart';
import 'package:presentation/widgets/text.dart';

class UploadingMessage extends StatelessWidget {
  final String message;
  const UploadingMessage({super.key, this.message = 'Guardando información'});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: black.withOpacity(0.75),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: white,
            ),
            const SizedBox(height: 10),
            TextWidget(
              text: message,
              color: white,
              fontSize: 20,
            )
          ],
        ),
      ),
    );
  }
}
