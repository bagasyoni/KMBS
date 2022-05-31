import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/toko_controller.dart';

Widget KeteranganPenilaian(
    BuildContext context, TokoController currencyController) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 0),
            child: Row(
              children: [
                Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
