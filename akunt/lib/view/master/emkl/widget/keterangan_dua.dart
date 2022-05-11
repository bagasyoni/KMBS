import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/emkl_controller.dart';
import 'package:akunt/view/master/brg/widget/tambah_satuan_barang.dart';

Widget KeteranganDua(
    BuildContext context, EmklController emklController) {
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
