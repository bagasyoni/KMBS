import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:akunt/config/config.dart';
import 'package:printing/printing.dart';

class InvoicePembelian {
  Future<bool> proses_print(var data_transaksi, var detail_transaksi) async {
    final bool result = await Printing.directPrintPdf(
        onLayout: (PdfPageFormat format) async =>
            (await _generatePdf(format, data_transaksi, detail_transaksi)));
    return result;
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, var data_transaksi, var detail_transaksi) async {
    final pdf = pw.Document();
    int jumlah_barang = detail_transaksi.length;

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(2),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(
              child: pw.Padding(
                padding: pw.EdgeInsets.only(top: 16, left: 16, right: 16),
                child: pw.Text(
                  "INVOICE PEMBELIAN",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            pw.Center(
              child: pw.Container(
                width: 200,
                child: pw.Divider(
                  height: 1,
                  thickness: 1,
                ),
              ),
            ),
            pw.Center(
              child: pw.Padding(
                padding: pw.EdgeInsets.only(top: 4, left: 16, right: 16),
                child: pw.Text(
                  "NO. Bukti : " + data_transaksi['no_bukti'].toString(),
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    flex: 5,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(left: 16, top: 4),
                        child: pw.Text(
                          "Tanggal : " + data_transaksi["tanggal"].toString(),
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(right: 16, top: 4),
                        child: pw.Text(
                          "No. SP : " + data_transaksi["no_sp"].toString(),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.only(left: 16, top: 4),
                      child: pw.Text(
                        "Kepada YTH : " + data_transaksi["supplier"].toString(),
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Container(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(right: 16, top: 4),
                        child: pw.Text(
                          "Jatuh Tempo : " +
                              data_transaksi["jatuh_tempo"].toString(),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            pw.Center(
              child: pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: pw.Divider(
                    height: 1,
                    thickness: 1,
                  )),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: pw.Row(children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Text("No.", style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 2,
                  child:
                      pw.Text("Kode Barang", style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 3,
                  child:
                      pw.Text("Nama Barang", style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text("Satuan",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Text("Qty",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("Harga",
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(fontSize: 12)),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Text("SubTotal",
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(fontSize: 12)),
                ),
              ]),
            ),
            pw.Center(
              child: pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: pw.Divider(
                    height: 1,
                    thickness: 1,
                  )),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: pw.Table(children: [
                for (int i = 0; i < jumlah_barang; i++)
                  pw.TableRow(
                    children: [
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text("${i + 1}",
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(detail_transaksi[i]['kd_brg'],
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(detail_transaksi[i]["na_brg"],
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(detail_transaksi[i]["satuan"],
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Text(
                            detail_transaksi[i]["qty"]
                                .toString()
                                .replaceAll(".0", ""),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                            config().format_rupiah(
                                detail_transaksi[i]["harga_beli"].toString()),
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                            config().format_rupiah(
                                detail_transaksi[i]["sub_total"].toString()),
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(fontSize: 12)),
                      ),
                    ],
                  )
              ]),
            ),
            pw.Center(
              child: pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: pw.Divider(
                    height: 1,
                    thickness: 1,
                  )),
            ),
            pw.Center(
              child: pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Keterangan : ${data_transaksi['keterangan']}",
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "Pajak : ",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "${data_transaksi['pajak'].toString().replaceAll(".0", "")}%",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            pw.Center(
              child: pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          "Total :",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          config().format_rupiah(
                              (data_transaksi["total"]).toString()),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        );
      },
    ));

    return pdf.save();
  }

  pw.Widget _line() {
    return pw.LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 3.0;
        final dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return pw.Flex(
          children: List.generate(dashCount, (_) {
            return pw.SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: pw.DecoratedBox(
                decoration: pw.BoxDecoration(color: PdfColor.fromHex("606060")),
              ),
            );
          }),
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          direction: pw.Axis.horizontal,
        );
      },
    );
  }
}
