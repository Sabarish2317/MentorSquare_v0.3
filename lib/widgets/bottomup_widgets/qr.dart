import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../Data/Widget_data_variables/global_student_data.dart';
import '../../ui_consts/them_data.dart';

class MyBarcodeGen extends StatelessWidget {
  const MyBarcodeGen({super.key});

  @override
  Widget build(BuildContext context) {
    return SfBarcodeGenerator(
        value: studentRegNo,
        showValue: true,
        symbology: Code128(),
        textAlign: TextAlign.center,
        textStyle: appTheme.textTheme.bodyLarge);
  }
}
