import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/brg_controller.dart';

Widget KeteranganPenentuanHarga(BrgController brgController) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 0),
            child: Row(
              children: [
                // Expanded(
                //   flex: 5,
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Harga Beli",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.black),
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //         Container(
                //           height: 40,
                //           decoration: BoxDecoration(
                //             border: Border.all(color: GreyColor),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           padding: EdgeInsets.symmetric(horizontal: 16),
                //           child: TextFormField(
                //             controller: brgController.satuanController,
                //             decoration: InputDecoration(
                //               contentPadding:
                //                   EdgeInsets.only(top: 18, bottom: 18),
                //               border: InputBorder.none,
                //               focusedBorder: InputBorder.none,
                //               focusedErrorBorder: InputBorder.none,
                //               errorBorder: InputBorder.none,
                //               enabledBorder: InputBorder.none,
                //               disabledBorder: InputBorder.none,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(flex: 1, child: SizedBox()),
                // Expanded(
                //   flex: 5,
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Harga Jual",
                //           style: TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.black),
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //         Container(
                //           height: 40,
                //           decoration: BoxDecoration(
                //             border: Border.all(color: GreyColor),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           padding: EdgeInsets.symmetric(horizontal: 16),
                //           child: TextFormField(
                //             controller: brgController.satuanController,
                //             decoration: InputDecoration(
                //               contentPadding:
                //                   EdgeInsets.only(top: 18, bottom: 18),
                //               border: InputBorder.none,
                //               focusedBorder: InputBorder.none,
                //               focusedErrorBorder: InputBorder.none,
                //               errorBorder: InputBorder.none,
                //               enabledBorder: InputBorder.none,
                //               disabledBorder: InputBorder.none,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
