import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/gudang_controller.dart';

Widget KeteranganSatu(GudangController gudangController) {
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
