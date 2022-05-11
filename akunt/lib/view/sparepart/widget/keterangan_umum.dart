import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/brg_controller.dart';
import 'package:akunt/view/master/brg/widget/tambah_satuan_barang.dart';

Widget KeteranganUmum(BuildContext context, BrgController brgController) {
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
                //           "Satuan",
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
                //           decoration: ShapeDecoration(
                //             shape: RoundedRectangleBorder(
                //               side: BorderSide(
                //                   width: 1.0,
                //                   style: BorderStyle.solid,
                //                   color: HijauColor),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(8.0)),
                //             ),
                //           ),
                //           child: Padding(
                //             padding: EdgeInsets.only(left: 16, right: 16),
                //             child: DropdownButtonHideUnderline(
                //               child: DropdownButton(
                //                 isExpanded: true,
                //                 iconEnabledColor: HijauColor,
                //                 value: brgController.satuan_barang,
                //                 items: brgController.dropdownList_satuan_barang,
                //                 onChanged: (value) {
                //                   if (value != null) {
                //                     if (value == "Tambah Baru ?") {
                //                       showAnimatedDialog_withCallBack(
                //                           context, TambahSatuanBarang(),
                //                           isFlip: true, callback: (value) {
                //                         if (value != null) {
                //                           if (value) {
                //                             brgController.data_satuan_barang();
                //                             brgController.notifyListeners();
                //                           }
                //                         }
                //                       });
                //                     } else {
                //                       brgController.satuan_barang = value;
                //                       brgController.notifyListeners();
                //                     }
                //                   }
                //                 },
                //               ),
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
                //           "Ukuran",
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
