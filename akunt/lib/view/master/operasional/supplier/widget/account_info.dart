import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/supplier_controller.dart';
import 'package:akunt/view/master/operasional/supplier/pilih_bank.dart';
import 'package:akunt/view/master/operasional/supplier/pilih_bahan.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/animation_custom_dialog.dart';

Widget AccountInfo(
    BuildContext context, SupplierController supplierController) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: 23, top: 10),
            child: Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 7),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#Acc",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        supplierController.blacnoaController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 18, bottom: 18),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 25,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 7),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "#Nama",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        supplierController.blacnobController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 18, bottom: 18),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 25,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
