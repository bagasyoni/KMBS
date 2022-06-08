// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/view/base_widget/mode_export.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controller/laporan_pon_controller.dart';
import '../../model/master/operasional/data_supp.dart';
import 'widget/filter_tanggal.dart';

class LapPonScreen extends StatefulWidget {
  @override
  _LapPonScreenState createState() => _LapPonScreenState();
}

class _LapPonScreenState extends State<LapPonScreen> {
  String baseUrl = base_url;
  @override
  void initState() {
    Provider.of<LapPonController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LapPonController>(builder: (context, lapPon, child) {
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
                "Laporan Purchase Order",
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
            // if (Provider.of<LoginController>(context, listen: false)
            //         .role_staff ==
            //     1)
            // OnHoverButton(
            //   child: InkWell(
            //     hoverColor: Colors.transparent,
            //     onTap: () {},
            //     child: Container(
            //       height: 30,
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Image.asset(
            //             "assets/images/ic_add.png",
            //             height: 30,
            //           ),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           Text(
            //             "Tambah Baru",
            //             style: GoogleFonts.poppins(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w400,
            //                 color: Colors.black),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
                  lapPon.proses_export_perSupplier(1);
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 16, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          showAnimatedDialog_withCallBack(
                              context, FilterTanggal(), isFlip: true,
                              callback: (value) {
                            if (value != null) {
                              if (value) {
                                lapPon.initData_add();
                                lapPon.notifyListeners();
                              } else {
                                lapPon.notifyListeners();
                                Navigator.pop(context, true);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
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
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/ic_tanggal.png",
                                height: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  width: 1,
                                  height: 25,
                                  color: GreyColor,
                                ),
                              ),
                              Text(
                                lapPon.range,
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
                  ],
                ),
              ),
              Expanded(
                child: (lapPon.data_list.length > 0)
                    ? ListView(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 4),
                          child: PaginatedDataTable(
                            source: MyData(lapPon.data_list, context, lapPon),
                            // header: Text('My Products'),
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Center(
                                    child: Text('Tanggal'),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Center(
                                    child: Text('No. Bukti'),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Center(
                                    child: Text(
                                      'Kd. Barang',
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(label: Text('Nama Barang')),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Qty.',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Harga',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.end,
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
      );
    });
  }
}

class MyData extends DataTableSource {
  var dtx = [];
  var f = NumberFormat("#,##0.00", "en_US");
  BuildContext context;
  LapPonController lapPon;
  MyData(this.dtx, this.context, this.lapPon);
  bool get isRowCountApproximate => false;
  int get rowCount => dtx.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    print(dtx[index]['TGL']);
    print(dtx[index]['NO_PO']);
    return DataRow(cells: [
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
      DataCell(Center(
        child: Text(
          dtx[index]['NO_PO'].toString(),
          style: TextStyle(color: Colors.black),
        ),
      )),
      DataCell(
        Center(
          child: Text(
            dtx[index]['KD_BRG'].toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      DataCell(
        Text(
          dtx[index]['NA_BRG'].toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(
          f.format(dtx[index]['KG']).toString(),
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.end,
        ),
      )),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(
          f.format(dtx[index]['HARGA']).toString(),
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.end,
        ),
      )),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(
          f.format(dtx[index]['TOTAL']).toString(),
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.end,
        ),
      )),
      DataCell(
        Text(''),
      ),
    ]);
  }
}
