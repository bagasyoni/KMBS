import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/view/beli_bahan/pilih_pobahan.dart';
import 'package:akunt/controller/belibahan_controller.dart';
import 'package:akunt/view/beli_bahan/widget/add_belibahan_card.dart';

Widget KeteranganUmum(
    BuildContext context, BelibahanController belibahanController) {
  return Container(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24, right: 23, top: 16),
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No. Bukti",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.no_buktiController,
                                    // readOnly: widget.isModeEdit,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
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
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pilih PO",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.no_poController,
                                    // readOnly: widget.isModeEdit,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 12, bottom: 15),
                                      hintText: "",
                                      hintStyle: GoogleFonts.poppins(
                                          color: GreyColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      // icon: Image.asset(
                                      //   "assets/images/ic_search.png",
                                      //   height: 20,
                                      // ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onTap: () {
                                      showAnimatedDialog_withCallBack(
                                          context,
                                          PilihPobahan(
                                              belibahanController
                                                      .no_poController
                                                      .text
                                                      .isEmpty
                                                  ? null
                                                  : belibahanController
                                                      .tglController.text,
                                              belibahanController),
                                          isFlip: false, callback: (value) {
                                        if (value != null) {
                                          belibahanController
                                              .importDataFromPO(value);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Supplier",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.kodesController,
                                    // readOnly: widget.isModeEdit,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 12, bottom: 15),
                                      hintText: "",
                                      hintStyle: GoogleFonts.poppins(
                                          color: GreyColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      // icon: Image.asset(
                                      //   "assets/images/ic_search.png",
                                      //   height: 20,
                                      // ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    // onTap: () {
                                    //   showAnimatedDialog(
                                    //       context,
                                    //       PilihSupplier(
                                    //           belibahanController
                                    //                   .kodesController
                                    //                   .text
                                    //                   .isEmpty
                                    //               ? null
                                    //               : belibahanController
                                    //                   .namasController.text,
                                    //           belibahanController),
                                    //       isFlip: false);
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
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
                          flex: 2,
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
                                //   height: 35,
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: GreyColor),
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   padding: EdgeInsets.symmetric(horizontal: 16),
                                //   child: TextFormField(
                                //     controller:
                                //         belibahanController.acno1Controller,
                                //     // readOnly: widget.isModeEdit,
                                //     decoration: InputDecoration(
                                //       contentPadding:
                                //           EdgeInsets.only(top: 12, bottom: 15),
                                //       hintText: "Cari Acno",
                                //       hintStyle: GoogleFonts.poppins(
                                //           color: GreyColor,
                                //           fontWeight: FontWeight.w400,
                                //           fontSize: 14),
                                //       icon: Image.asset(
                                //         "assets/images/ic_search.png",
                                //         height: 20,
                                //       ),
                                //       border: InputBorder.none,
                                //       focusedBorder: InputBorder.none,
                                //       focusedErrorBorder: InputBorder.none,
                                //       errorBorder: InputBorder.none,
                                //       enabledBorder: InputBorder.none,
                                //       disabledBorder: InputBorder.none,
                                //     ),
                                //     onTap: () {
                                //       showAnimatedDialog(
                                //           context,
                                //           PilihAccount(
                                //               belibahanController
                                //                       .acno1Controller
                                //                       .text
                                //                       .isEmpty
                                //                   ? null
                                //                   : belibahanController
                                //                       .acno1_nmController.text,
                                //               belibahanController),
                                //           isFlip: false);
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
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
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tanggal",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.tglController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
                                      icon: Image.asset(
                                        "assets/images/ic_tanggal.png",
                                        height: 20,
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      belibahanController.chooseDate =
                                          await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      belibahanController
                                                              .chooseDate ??
                                                          DateTime.now(),
                                                  lastDate: DateTime(2050),
                                                  firstDate: DateTime(
                                                      DateTime.now().year)) ??
                                              belibahanController.chooseDate;
                                      belibahanController.tglController.text =
                                          belibahanController.format_tanggal
                                              .format(belibahanController
                                                  .chooseDate);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
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
                                  "Nama Supplier",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.namasController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
                                      icon: Image.asset(
                                        "assets/images/ic_user_warna.png",
                                        height: 20,
                                      ),
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
                          flex: 4,
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
                                //   height: 35,
                                //   decoration: BoxDecoration(
                                //     color: Colors.teal[50],
                                //     border: Border.all(color: GreyColor),
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   padding: EdgeInsets.symmetric(horizontal: 16),
                                //   child: TextFormField(
                                //     controller:
                                //         belibahanController.acno1_nmController,
                                //     readOnly: true,
                                //     decoration: InputDecoration(
                                //       contentPadding:
                                //           EdgeInsets.only(top: 15, bottom: 18),
                                //       icon: Image.asset(
                                //         "assets/images/ic_user_warna.png",
                                //         height: 20,
                                //       ),
                                //       hintStyle: GoogleFonts.poppins(
                                //           color: GreyColor,
                                //           fontWeight: FontWeight.w400,
                                //           fontSize: 14),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Uang",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.currController,
                                    // readOnly: widget.isModeEdit,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 12, bottom: 15),
                                      hintText: "",
                                      hintStyle: GoogleFonts.poppins(
                                          color: GreyColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      // icon: Image.asset(
                                      //   "assets/images/ic_search.png",
                                      //   height: 20,
                                      // ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                    // onTap: () {
                                    //   showAnimatedDialog(
                                    //       context,
                                    //       PilihCurrency(
                                    //           belibahanController.currController
                                    //                   .text.isEmpty
                                    //               ? null
                                    //               : belibahanController
                                    //                   .currnmController.text,
                                    //           belibahanController),
                                    //       isFlip: false);
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.currnmController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 1, bottom: 16),
                                      icon: Image.asset(
                                        "assets/images/ic_user_warna.png",
                                        height: 20,
                                      ),
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
                                  "Alamat",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.alamatController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
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
                          flex: 3,
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
                          flex: 1,
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
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 10, bottom: 26),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rate",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.rateController,
                                    // readOnly: widget.isModeEdit,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
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
                          flex: 2,
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
                                //   child: Checkbox(
                                //     checkColor: Colors.white,
                                //     fillColor:
                                //         MaterialStateProperty.resolveWith(
                                //             getColor),
                                //     value: isChecked,
                                //     onChanged: (bool newvalue) {
                                //       setState(() {
                                //         isChecked = newvalue;
                                //         newvalue = PobahanlokalController
                                //             .rateksController;
                                //       });
                                //       if (isChecked == true) {
                                //         print(1);
                                //       } else
                                //         print(0);
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kota",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.teal[50],
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.kotaController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 1, bottom: 16),
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
                          flex: 2,
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
                          flex: 3,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Keterangan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        belibahanController.notesController,
                                    readOnly: false,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 15, bottom: 18),
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
                          flex: 1,
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
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "No.",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Kode Bahan",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Nama Bahan",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Satuan",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Keterangan",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Harga",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Qty",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Sub Total",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                width: 36,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: belibahanController.data_bhn_keranjang.length,
            itemBuilder: (BuildContext context, int index) {
              return AddBelibahanCard(context, index,
                  belibahanController.data_bhn_keranjang[index]);
            },
          ),
        ),
      ],
    ),
  );
}
