import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/controller/penerimaan_controller.dart';
import 'package:akunt/view/penerimaan/widget/transaksi_barang_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExportBySupplierScreen extends StatefulWidget {
  String supplier;

  ExportBySupplierScreen(this.supplier);

  @override
  _ExportBySupplierScreenState createState() => _ExportBySupplierScreenState();
}

class _ExportBySupplierScreenState extends State<ExportBySupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PenerimaanController>(
        builder: (context, controller, child) {
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
                "Data Pembelian Barang by ${widget.supplier}",
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
                hoverColor: Colors.transparent,
                onTap: () {
                  controller.proses_export_perSupplier(0);
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_excel.png",
                        height: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "to Excel",
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
                onTap: () {
                  controller.proses_export_perSupplier(1);
                },
                hoverColor: Colors.white,
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_pdf.png",
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
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Tanggal",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "No. Bukti",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "No. SP",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Kode Barang",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Nama Barang",
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
                          "Harga Beli",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "SubTotal",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: (controller.data_excel_bySupplier.length > 0)
                      ? ListView.builder(
                          itemCount: controller.data_excel_bySupplier.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TransaksiBarangCard(index, controller);
                          },
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              "Tidak ada data",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: GreyColor),
                            ),
                          ),
                        ),
                ),
              ],
            )),
      );
    });
  }
}
