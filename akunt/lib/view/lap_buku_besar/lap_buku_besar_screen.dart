// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/view/base_widget/mode_export.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:provider/provider.dart';
import 'package:akunt/view/lap_buku_besar/widget/tambah_periode.dart';

import '../../constants.dart';
import '../../controller/laporan_buku_besar_controller.dart';
import 'widget/filter_tanggal.dart';

class LapBukubesarScreen extends StatefulWidget {
  @override
  _LapBukubesarScreenState createState() => _LapBukubesarScreenState();
}

class _LapBukubesarScreenState extends State<LapBukubesarScreen> {
  var f = NumberFormat("#,##0.00", "en_US");
  String baseUrl = base_url;
  @override
  void initState() {
    Provider.of<LapBukubesarController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LapBukubesarController>(
        builder: (context, lapBukubesar, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              Container(
                height: 25,
                width: 1,
                color: AbuColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Laporan Buku Besar",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 20,
            padding: EdgeInsets.all(0),
            icon: Image.asset(
              "assets/images/ic_back.png",
              height: 30,
            ),
          ),
          actions: [
            SizedBox(
              width: 16,
            ),
            OnHoverButton(
              child: InkWell(
                onTap: () {},
                hoverColor: Colors.white,
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_download.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Export",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            OnHoverButton(
              child: InkWell(
                hoverColor: Colors.white,
                onTap: () {
                  lapBukubesar.proses_export_lapbukubesar(1);
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_print.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Cetak",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 32, right: 32, top: 16, bottom: 8),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         flex: 3,
              //         child: InkWell(
              //           onTap: () {
              //             showAnimatedDialog_withCallBack(
              //                 context, FilterTanggal(), isFlip: true,
              //                 callback: (value) {
              //               if (value != null) {
              //                 if (value) {
              //                   // lapBukubesar.initData_add();
              //                   lapBukubesar.notifyListeners();
              //                 } else {
              //                   lapBukubesar.notifyListeners();
              //                   Navigator.pop(context, true);
              //                 }
              //               }
              //             });
              //           },
              //           child: Container(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 16, vertical: 10),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(10),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: GreyColor,
              //                   spreadRadius: 1,
              //                   blurRadius: 4,
              //                   offset:
              //                       Offset(1, 2), // changes position of shadow
              //                 ),
              //               ],
              //             ),
              //             child: Row(
              //               children: [
              //                 Image.asset(
              //                   "assets/images/ic_tanggal.png",
              //                   height: 25,
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(horizontal: 8),
              //                   child: Container(
              //                     width: 1,
              //                     height: 25,
              //                     color: GreyColor,
              //                   ),
              //                 ),
              //                 Text(
              //                   lapBukubesar.range,
              //                   style: GoogleFonts.poppins(
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w400,
              //                       color: Colors.black),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: GreyColor,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                iconEnabledColor: HijauColor,
                                value: lapBukubesar.periode,
                                items: lapBukubesar.dropdown_periode,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (value == "Tambah Baru ?") {
                                      showAnimatedDialog_withCallBack(
                                          context, TambahPeriode(),
                                          isFlip: true, callback: (value) {
                                        if (value != null) {
                                          if (value) {
                                            lapBukubesar.filter_periode();
                                            lapBukubesar.notifyListeners();
                                          }
                                        }
                                      });
                                    } else {
                                      lapBukubesar.periode = value;
                                      lapBukubesar.notifyListeners();
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: GreyColor,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                iconEnabledColor: HijauColor,
                                value: lapBukubesar.account,
                                items: lapBukubesar.dropdown_account,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (value == "Tambah Baru ?") {
                                      showAnimatedDialog_withCallBack(
                                          context, TambahPeriode(),
                                          isFlip: true, callback: (value) {
                                        if (value != null) {
                                          if (value) {
                                            lapBukubesar.filter_account();
                                            lapBukubesar.notifyListeners();
                                          }
                                        }
                                      });
                                    } else {
                                      lapBukubesar.account = value;
                                      lapBukubesar.notifyListeners();
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: (lapBukubesar.data_list.length > 0)
                    ? ListView(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 4),
                          child: PaginatedDataTable(
                            source: MyData(
                                lapBukubesar.data_list, context, lapBukubesar),
                            // header: Text('My Products'),
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Center(
                                    child: Text('No Bukti'),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Center(
                                    child: Text('Tanggal'),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Kode',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Nama',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Uraian',
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child:
                                      Text('Awal', textAlign: TextAlign.right),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Masuk',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text('Keluar',
                                      textAlign: TextAlign.right),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Akhir',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                              DataColumn(label: Text('')),
                            ],
                            initialFirstRowIndex: 0,
                            columnSpacing: 0,
                            horizontalMargin: 10,
                            rowsPerPage: 8,
                            showCheckboxColumn: true,
                          ),
                        ),
                      ])
                    : Container(
                        child: Center(
                          child: Text(
                            "Tidak ada data",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: GreyColor),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: GreyColor,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Jumlah Transaksi : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: lapBukubesar.data_list.length.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 20,
                    width: 1,
                    color: GreyColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Awal : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: f.format(lapBukubesar.awal).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 20,
                    width: 1,
                    color: GreyColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Debet : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: f.format(lapBukubesar.debet).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 20,
                    width: 1,
                    color: GreyColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Kredit : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: f.format(lapBukubesar.kredit).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 20,
                    width: 1,
                    color: GreyColor,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Akhir : ",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: f.format(lapBukubesar.akhir).toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget pageField() {
    LapBukubesarController pageTerima =
        Provider.of<LapBukubesarController>(context, listen: false);
    return Container(
      width: 70,
      height: 35,
      child: TextField(
        textAlign: TextAlign.center,
        controller: pageTerima.c_page,
        decoration: InputDecoration(
          hintText: "1",
          hintStyle: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: GreyColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
        onSubmitted: (value) {
          int index = 1;
          try {
            index = int.parse(value.trim());
          } catch (e) {
            index = 1;
          }
          if (index == 0) {
            index = 1;
          } else {
            if (index > 0) {
              index = index - 1;
            }
          }
          if (index > pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.select_data();
          } else if (index < pageTerima.page_index) {
            pageTerima.offset = (index * pageTerima.limit);
            pageTerima.page_index = index;
            pageTerima.c_page.text = (pageTerima.page_index + 1).toString();
            pageTerima.select_data();
          }
        },
      ),
    );
  }
}

class MyData extends DataTableSource {
  var dtx = [];
  var f = NumberFormat("#,##0.00", "en_US");
  BuildContext context;
  LapBukubesarController lapBukubesar;
  MyData(this.dtx, this.context, this.lapBukubesar);
  bool get isRowCountApproximate => false;
  int get rowCount => dtx.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(dtx[index]['NO_BUKTI'].toString(),
            style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
      )),
      DataCell(
        Center(
          child: Text(
            DateFormat('dd/MM/yyyy', "id_ID")
                .format(DateTime.parse(dtx[index]['TGL']))
                .toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(dtx[index]['ACNO'].toString(),
            style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
      )),
      DataCell(
        SizedBox(
          width: double.infinity,
          child: Text(dtx[index]['NAMA'].toString(),
              style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
        ),
      ),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(dtx[index]['URAIAN'].toString(),
            style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
      )),
      DataCell(
        SizedBox(
          width: double.infinity,
          child: Text(f.format(dtx[index]['AWAL']).toString(),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.right),
        ),
      ),
      DataCell(
        SizedBox(
          width: double.infinity,
          child: Text(f.format(dtx[index]['DEBET']).toString(),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.right),
        ),
      ),
      DataCell(
        SizedBox(
          width: double.infinity,
          child: Text(f.format(dtx[index]['KREDIT']).toString(),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.right),
        ),
      ),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(
          f.format(dtx[index]['AKHIR']).toString(),
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
      )),
      DataCell(
        Text(''),
      ),
    ]);
  }
}
