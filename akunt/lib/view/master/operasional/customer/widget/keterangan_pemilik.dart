import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/customer_controller.dart';
import 'package:akunt/view/master/operasional/customer/pilih_bank.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/animation_custom_dialog.dart';

Widget KeteranganLain(
    BuildContext context, CustomerController customerController) {
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
                    padding: EdgeInsets.only(left: 24, right: 24, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kode Bank",
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
                                        customerController.bankController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 18, bottom: 15),
                                      hintText: "Cari Bank",
                                      hintStyle: GoogleFonts.poppins(
                                          color: GreyColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      icon: Image.asset(
                                        "assets/images/ic_search.png",
                                        height: 20,
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onTap: () {
                                      showAnimatedDialog(
                                          context,
                                          PilihBank(
                                              customerController.kodecController
                                                      .text.isEmpty
                                                  ? null
                                                  : customerController
                                                      .namacController.text,
                                              customerController),
                                          isFlip: false);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                    padding: EdgeInsets.only(left: 24, right: 24, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nama Bank",
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
                                        customerController.bank_namaController,
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
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                                  "No. Rekening",
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
                                        customerController.bank_rekController,
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
                          flex: 5,
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
                                // Container(
                                //   height: 40,
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: GreyColor),
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   padding: EdgeInsets.symmetric(horizontal: 16),
                                //   child: TextFormField(
                                //     controller:
                                //         customerController.kap_prodController,
                                //     decoration: InputDecoration(
                                //       contentPadding:
                                //           EdgeInsets.only(top: 18, bottom: 18),
                                //       border: InputBorder.none,
                                //       focusedBorder: InputBorder.none,
                                //       focusedErrorBorder: InputBorder.none,
                                //       errorBorder: InputBorder.none,
                                //       enabledBorder: InputBorder.none,
                                //       disabledBorder: InputBorder.none,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                                  "Cabang Bank",
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
                                        customerController.bank_cabController,
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
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kota Bank",
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
                                        customerController.bank_kotaController,
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
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
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
                  // Padding(
                  //   padding: EdgeInsets.only(left: 24, right: 24, top: 7),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Barang",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Container(
                  //                 height: 40,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(color: GreyColor),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 padding: EdgeInsets.symmetric(horizontal: 16),
                  //                 child: TextFormField(
                  //                   controller:
                  //                       customerController.barangController,
                  //                   decoration: InputDecoration(
                  //                     contentPadding:
                  //                         EdgeInsets.only(top: 18, bottom: 18),
                  //                     border: InputBorder.none,
                  //                     focusedBorder: InputBorder.none,
                  //                     focusedErrorBorder: InputBorder.none,
                  //                     errorBorder: InputBorder.none,
                  //                     enabledBorder: InputBorder.none,
                  //                     disabledBorder: InputBorder.none,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               // Container(
                  //               //   height: 40,
                  //               //   decoration: BoxDecoration(
                  //               //     border: Border.all(color: GreyColor),
                  //               //     borderRadius: BorderRadius.circular(5),
                  //               //   ),
                  //               //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //               //   child: TextFormField(
                  //               //     controller:
                  //               //         customerController.hargaController,
                  //               //     decoration: InputDecoration(
                  //               //       contentPadding:
                  //               //           EdgeInsets.only(top: 18, bottom: 18),
                  //               //       border: InputBorder.none,
                  //               //       focusedBorder: InputBorder.none,
                  //               //       focusedErrorBorder: InputBorder.none,
                  //               //       errorBorder: InputBorder.none,
                  //               //       enabledBorder: InputBorder.none,
                  //               //       disabledBorder: InputBorder.none,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 24, right: 24, top: 7),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Harga",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Container(
                  //                 height: 40,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(color: GreyColor),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 padding: EdgeInsets.symmetric(horizontal: 16),
                  //                 child: TextFormField(
                  //                   controller:
                  //                       customerController.hargaController,
                  //                   decoration: InputDecoration(
                  //                     contentPadding:
                  //                         EdgeInsets.only(top: 18, bottom: 18),
                  //                     border: InputBorder.none,
                  //                     focusedBorder: InputBorder.none,
                  //                     focusedErrorBorder: InputBorder.none,
                  //                     errorBorder: InputBorder.none,
                  //                     enabledBorder: InputBorder.none,
                  //                     disabledBorder: InputBorder.none,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               // Container(
                  //               //   height: 40,
                  //               //   decoration: BoxDecoration(
                  //               //     border: Border.all(color: GreyColor),
                  //               //     borderRadius: BorderRadius.circular(5),
                  //               //   ),
                  //               //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //               //   child: TextFormField(
                  //               //     controller:
                  //               //         customerController.diskonController,
                  //               //     decoration: InputDecoration(
                  //               //       contentPadding:
                  //               //           EdgeInsets.only(top: 18, bottom: 18),
                  //               //       border: InputBorder.none,
                  //               //       focusedBorder: InputBorder.none,
                  //               //       focusedErrorBorder: InputBorder.none,
                  //               //       errorBorder: InputBorder.none,
                  //               //       enabledBorder: InputBorder.none,
                  //               //       disabledBorder: InputBorder.none,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               // Container(
                  //               //   height: 40,
                  //               //   decoration: BoxDecoration(
                  //               //     border: Border.all(color: GreyColor),
                  //               //     borderRadius: BorderRadius.circular(5),
                  //               //   ),
                  //               //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //               //   child: TextFormField(
                  //               //     controller:
                  //               //         customerController.sklController,
                  //               //     decoration: InputDecoration(
                  //               //       contentPadding:
                  //               //           EdgeInsets.only(top: 18, bottom: 18),
                  //               //       border: InputBorder.none,
                  //               //       focusedBorder: InputBorder.none,
                  //               //       focusedErrorBorder: InputBorder.none,
                  //               //       errorBorder: InputBorder.none,
                  //               //       enabledBorder: InputBorder.none,
                  //               //       disabledBorder: InputBorder.none,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 24, right: 24, top: 7),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Diskon",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Container(
                  //                 height: 40,
                  //                 decoration: BoxDecoration(
                  //                   border: Border.all(color: GreyColor),
                  //                   borderRadius: BorderRadius.circular(5),
                  //                 ),
                  //                 padding: EdgeInsets.symmetric(horizontal: 16),
                  //                 child: TextFormField(
                  //                   controller:
                  //                       customerController.diskonController,
                  //                   decoration: InputDecoration(
                  //                     contentPadding:
                  //                         EdgeInsets.only(top: 18, bottom: 18),
                  //                     border: InputBorder.none,
                  //                     focusedBorder: InputBorder.none,
                  //                     focusedErrorBorder: InputBorder.none,
                  //                     errorBorder: InputBorder.none,
                  //                     enabledBorder: InputBorder.none,
                  //                     disabledBorder: InputBorder.none,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               // Container(
                  //               //   height: 40,
                  //               //   decoration: BoxDecoration(
                  //               //     border: Border.all(color: GreyColor),
                  //               //     borderRadius: BorderRadius.circular(5),
                  //               //   ),
                  //               //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //               //   child: TextFormField(
                  //               //     controller:
                  //               //         customerController.plmController,
                  //               //     decoration: InputDecoration(
                  //               //       contentPadding:
                  //               //           EdgeInsets.only(top: 18, bottom: 18),
                  //               //       border: InputBorder.none,
                  //               //       focusedBorder: InputBorder.none,
                  //               //       focusedErrorBorder: InputBorder.none,
                  //               //       errorBorder: InputBorder.none,
                  //               //       enabledBorder: InputBorder.none,
                  //               //       disabledBorder: InputBorder.none,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               // Container(
                  //               //   height: 40,
                  //               //   decoration: BoxDecoration(
                  //               //     border: Border.all(color: GreyColor),
                  //               //     borderRadius: BorderRadius.circular(5),
                  //               //   ),
                  //               //   padding: EdgeInsets.symmetric(horizontal: 16),
                  //               //   child: TextFormField(
                  //               //     controller:
                  //               //         customerController.pllController,
                  //               //     decoration: InputDecoration(
                  //               //       contentPadding:
                  //               //           EdgeInsets.only(top: 18, bottom: 18),
                  //               //       border: InputBorder.none,
                  //               //       focusedBorder: InputBorder.none,
                  //               //       focusedErrorBorder: InputBorder.none,
                  //               //       errorBorder: InputBorder.none,
                  //               //       enabledBorder: InputBorder.none,
                  //               //       disabledBorder: InputBorder.none,
                  //               //     ),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(flex: 1, child: SizedBox()),
                  //       Expanded(
                  //         flex: 5,
                  //         child: Container(
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w400,
                  //                     color: Colors.black),
                  //               ),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
