import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/currency_controller.dart';

Widget KeteranganUmum(
    BuildContext context, CurrencyController currencyController) {
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
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kode",
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
                                        currencyController.kodeController,
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
                          flex: 23,
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
                                  "Nama",
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
                                        currencyController.namaController,
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
                          flex: 23,
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
                                        currencyController.tglController,
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
                                      currencyController.chooseDate =
                                          await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      currencyController
                                                              .chooseDate ??
                                                          DateTime.now(),
                                                  lastDate: DateTime(2050),
                                                  firstDate: DateTime(
                                                      DateTime.now().year)) ??
                                              currencyController.chooseDate;
                                      currencyController.tglController.text =
                                          currencyController.format_tanggal
                                              .format(currencyController
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
                          flex: 23,
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
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        currencyController.rateController,
                                    decoration: InputDecoration(
                                      hintText: "0.0000",
                                      contentPadding:
                                          EdgeInsets.only(top: 18, bottom: 14),
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
                          flex: 23,
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
                                  "Rate Bayar",
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
                                        currencyController.rate_byrController,
                                    decoration: InputDecoration(
                                      hintText: "0.0000",
                                      contentPadding:
                                          EdgeInsets.only(top: 18, bottom: 14),
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
                          flex: 23,
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
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: GreyColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: TextFormField(
                                    controller:
                                        currencyController.ketController,
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
                          flex: 23,
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
