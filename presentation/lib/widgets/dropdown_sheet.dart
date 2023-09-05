import 'package:flutter/material.dart';
import 'package:presentation/widgets/text.dart';

class DropdownSheet {
  static selectFromBottomSheetMap(BuildContext context, List options) async {
    final selected = await DropdownSheet.showBottomSheet(
      options: options,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const Text(
            //   "Contacto",
            //   style: TextStyle(fontSize: 20, color: purple),
            // ),
            for (var option in options)
              if (option['value'] != null && option['value'] != '')
                InkWell(
                  onTap: () {
                    Navigator.pop(context, option);
                  },
                  child: Ink(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextWidget(
                        text: '${option['nombre']}',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
          ],
        );
      },
    );
    return selected;
  }

  // static selectFromBottomSheetFilter(
  //     BuildContext context, List<Filter> options) async {
  //   final selected = await DropdownSheet.showBottomSheet(
  //     options: options,
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             for (var option in options)
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.pop(context, option);
  //                 },
  //                 child: Ink(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 12),
  //                     child: TextWidget(
  //                       text: '${option.name}',
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   return selected;
  // }

  // static selectFromBottomSheetParameter(
  //     BuildContext context, List<Parameter> options) async {
  //   final selected = await DropdownSheet.showBottomSheet(
  //     options: options,
  //     context: context,
  //     builder: (context) {
  //       return SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             for (var option in options)
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.pop(context, option);
  //                 },
  //                 child: Ink(
  //                   width: double.infinity,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(vertical: 12),
  //                     child: TextWidget(
  //                       text: '${option.nombreLargo}',
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   return selected;
  // }

  static Future showBottomSheet({
    required BuildContext context,
    List? options,
    required Widget Function(BuildContext) builder,
    Color backgroundColor = Colors.white,
  }) async {
    final response = await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: builder,
    );
    return response;
  }
}
