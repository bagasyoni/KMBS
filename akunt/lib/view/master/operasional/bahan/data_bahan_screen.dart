import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/animation_custom_dialog.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/master/operasional/bahan_controller.dart';
import 'package:akunt/view/base_widget/notif_hapus.dart';
import 'package:akunt/view/master/operasional/bahan/bahan_card.dart';
import 'package:akunt/view/master/operasional/bahan/tambah_bahan_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:provider/provider.dart';

// IMPORT PRINT WEB
// import 'dart:js' as js;

class DataBahanScreen extends StatefulWidget {
  @override
  _DataBahanScreenState createState() => _DataBahanScreenState();
}

class _DataBahanScreenState extends State<DataBahanScreen> {
  var f = NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    Provider.of<BahanController>(context, listen: false).initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BahanController>(
        builder: (context, bahanController, child) {
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
                "Data Bahan",
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
            OnHoverButton(
              child: InkWell(
                hoverColor: Colors.white,
                onTap: () {
                  // js.context.callMethod('open', [
                  //   'http://localhost/KMBS/KMBS/kmbs_php/Laporan_Masterbhn.php'
                  // ]);
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
            OnHoverButton(
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              TambahBahanScreen(isModeEdit: false)));
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_add.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Tambah Baru",
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
                      flex: 6,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              "assets/images/ic_search.png",
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
                            Expanded(
                              child: Container(
                                height: 30,
                                child: TextField(
                                  controller: bahanController.searchController,
                                  onChanged: (value) {
                                    Provider.of<BahanController>(context,
                                            listen: false)
                                        .setProses(true);
                                    Provider.of<BahanController>(context,
                                            listen: false)
                                        .search(value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Cari Disini",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: GreyColor),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 14),
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: (bahanController.data_bahanList.length > 0)
                    ? ListView(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 16, bottom: 4),
                          child: PaginatedDataTable(
                            source: MyData(bahanController.data_bahanList,
                                context, bahanController),
                            // header: Text('My Products'),
                            columns: [
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'No',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Kode',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Nama',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Satuan',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Acno',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Uraian',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(label: Text('')),
                            ],
                            sortColumnIndex: 0,
                            sortAscending: true,
                            initialFirstRowIndex: 0,
                            columnSpacing: 0,
                            horizontalMargin: 10,
                            rowsPerPage: 15,
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
  BahanController bahanController;
  MyData(this.dtx, this.context, this.bahanController);
  bool get isRowCountApproximate => false;
  int get rowCount => dtx.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(SizedBox(
        width: double.infinity,
        child: Text("${index + 1}",
            style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
      )),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(dtx[index]['KD_BHN'].toString(),
            style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
      )),
      DataCell(SizedBox(
        width: double.infinity,
        child: Text(dtx[index]['NA_BHN'].toString(),
            style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
      )),
      DataCell(
        SizedBox(
          width: double.infinity,
          child: Text(dtx[index]['SATUAN'].toString(),
              style: TextStyle(color: Colors.black), textAlign: TextAlign.left),
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
          child: Text(dtx[index]['ACNO_NM'].toString(),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.right),
        ),
      ),
      DataCell(
        Text(''),
      ),
    ]);
  }
}
