// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class model_order_pembelian {
  static String table = 'po';
  static String table_detail = 'pod';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  //// REPORT COPY ////
  Future<List> data_lap(String TGL1, String TGL2) async {
    var data_whr = {
      "tgla": TGL1,
      "tglb": TGL2,
    };

    final response = await http.post(
      Uri.parse("${baseUrl}:3000/lappo"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }

  Future<List> delete_order_penjualan(String no_bukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results1 =
    //     await konek.query("delete from $table where NO_BUKTI = '$no_bukti';");
    // var results2 = await konek
    //     .query("delete from $table_detail where NO_BUKTI = '$no_bukti';");
    // await konek.close();
    // return results2.toList();

    var data_whr = {
      "tabel": "POD",
      "data_whr": "NO_BUKTI = '${no_bukti}'",
    };

    await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/delete"),
      body: data_whr,
    );

    data_whr = {
      "tabel": "PO",
      "data_whr": "NO_BUKTI = '${no_bukti}'",
    };

    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/delete"),
      body: data_whr,
    );
    // final response = await http.post(
    //   Uri.parse(
    //       "https://edompetiaragatzuonline.com/flutterjualbeli/po.php/datacust"),
    //   body: {"no_bukti": no_bukti},
    // );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<bool> insert_order_pembelian(Map data_insert) async {
    try {
      // print(data_insert);
      // var konek = await m_koneksi.koneksi();
      // var results1 = await konek.query(
      //     // 'insert into ' +
      //     //     table +
      //     //     ' (id,no_bukti,sales,supplier,tanggal,keterangan,total_qty,total_used,total_po,status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      //     'insert into ' +
      //         table +
      //         ' (NO_ID,NO_BUKTI,KODES,TGL,CAT1,TOTAL_QTY,TOTAL,STATUS) values ( ?, ?, ?, ?, ?, ?, ?, ?)',
      //     [
      //       0,
      //       data_insert['NO_BUKTI'],
      //       // data_insert['sales'],
      //       data_insert['KODES'],
      //       data_insert['TGL'],
      //       data_insert['CAT1'] ?? "",
      //       data_insert['TOTAL_QTY'],
      //       // data_insert['total_used'],
      //       data_insert['TOTAL'],
      //       data_insert['STATUS'],
      //     ]);

      var datah = {
        "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
        "TGL": data_insert['TGL'].toString(),
        "KODES": data_insert['KODES'].toString(),
        "CAT1": data_insert['CAT1'] ?? "",
        "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
        "TOTAL": data_insert['TOTAL'].toString(),
        "STATUS": data_insert['STATUS'].toString()
      };

      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/inputHeader"),
        body: datah,
      );
      // print(data_insert);

      List data_barang = data_insert['barang'];
      // print(response);

      for (int i = 0; i < data_barang.length; i++) {
        await http.post(
          Uri.parse(
              "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/inputDetail"),
          body: {
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_barang[i]['KD_BRG'].toString(),
            "NA_BRG": data_barang[i]['NA_BRG'].toString(),
            "KET_UK": data_barang[i]['ket_uk'].toString(),
            "QTY": data_barang[i]['qty'].toString(),
            "HARGA": data_barang[i]['harga'].toString(),
            "TOTAL": data_barang[i]['total'].toString(),
          },
        );
      }

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
      // return false;
      // await konek.queryMulti(
      //     'insert into ' +
      //         table_detail +
      //         ' (NO_ID,no_bukti,KD_BRG,NA_BRG,ket_uk,qty,harga,total) values (?, ?, ?, ?, ?, ?, ?, ?)',
      //     [
      //       for (int i = 0; i < data_barang.length; i++)
      //         [
      //           0,
      //           data_insert['NO_BUKTI'].toString(),
      //           data_barang[i]['KD_BRG'].toString(),
      //           data_barang[i]['NA_BRG'].toString(),
      //           data_barang[i]['ket_uk'].toString(),
      //           data_barang[i]['qty'],
      //           data_barang[i]['harga'],
      //           data_barang[i]['total']
      //         ]
      //     ]);
      // await konek.query(
      //     "UPDATE POD,po set POD.ID=PO.NO_ID where pod.no_bukti=po.no_bukti and po.no_bukti='${data_insert['NO_BUKTI']}'");
      // // await konek.query(
      // //     "UPDATE POD,brg set POD.KET_UK=brg.KET_UK,POD.KET_KEM=brg.KET_KEM where pod.KD_BRG=brg.KD_BRG and pod.NO_BUKTI='${data_insert['NO_BUKTI']}'");
      // await konek.close();

      // return results1.toList();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_order_pembelian(Map data_insert) async {
    try {
      var datah = {
        "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
        "TGL": data_insert['TGL'].toString(),
        "CAT1": data_insert['CAT1'] ?? "",
        "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
        "TOTAL": data_insert['TOTAL'].toString(),
        "STATUS": data_insert['STATUS'].toString()
      };

      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/editHeader"),
        body: datah,
      );

      var data_whr = {
        "tabel": "POD",
        "data_whr": "NO_BUKTI = '${data_insert['NO_BUKTI']}'"
      };

      await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/delete"),
        body: data_whr,
      );

      List data_barang = data_insert['barang'];
      // print(response);

      for (int i = 0; i < data_barang.length; i++) {
        await http.post(
          Uri.parse(
              "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/inputDetail"),
          body: {
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_barang[i]['KD_BRG'].toString(),
            "NA_BRG": data_barang[i]['NA_BRG'].toString(),
            "KET_UK": data_barang[i]['ket_uk'].toString(),
            "QTY": data_barang[i]['qty'].toString(),
            "HARGA": data_barang[i]['harga'].toString(),
            "TOTAL": data_barang[i]['total'].toString(),
          },
        );
      }
      // var konek = await m_koneksi.koneksi();
      // await konek.query(
      //     "delete from $table_detail where no_bukti ='${data_insert['no_bukti']}' ;");
      // var results1 = await konek.query(
      //     "update $table set KODES = '${data_insert['supplier']}', " +
      //         "TGL = '${data_insert['tanggal']}', " +
      //         "CAT1 = '${data_insert['keterangan']}', " +
      //         "TOTAL_QTY = '${data_insert['total_qty']}', " +
      //         "TOTAL = '${data_insert['total_po']}', " +
      //         "STATUS = '${data_insert['status']}' " +
      //         "where NO_BUKTI ='${data_insert['no_bukti']}';");
      // List data_barang = data_insert['barang'];
      // await konek.queryMulti(
      //     'insert into ' +
      //         table_detail +
      //         ' (NO_ID,no_bukti,KD_BRG,NA_BRG,ket_uk,qty,harga,total) values (?, ?, ?, ?, ?, ?, ?, ?)',
      //     [
      //       for (int i = 0; i < data_barang.length; i++)
      //         [
      //           0,
      //           data_insert['no_bukti'].toString(),
      //           data_barang[i]['KD_BRG'].toString(),
      //           data_barang[i]['NA_BRG'].toString(),
      //           data_barang[i]['ket_uk'].toString(),
      //           data_barang[i]['qty'],
      //           data_barang[i]['harga'],
      //           data_barang[i]['total']
      //         ]
      //     ]);
      // await konek.close();
      var results2 = json.decode(response.body);
      return results2.toList();
      // return results1.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countOrderPembelian(String date) async {
    var konek = await m_koneksi.koneksi();
    var result = await konek
        .query("SELECT no_bukti FROM $table where tgl like '$date%';");
    await konek.close();
    return result.toList();
    // final response = await http.post(
    //   Uri.parse(
    //       "https://edompetiaragatzuonline.com/flutterjualbeli/po.php/datacust"),
    //   body: {"date": date},
    // );
    // var results2 = json.decode(response.body);
    // return results2.toList();
  }

  Future<List> get_no_bukti(String kode) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 =
    //     await konek.query("select * from $table where no_bukti = '$kode';");
    // await konek.close();
    // return results2.toList();
    // final response = await http.post(
    //   Uri.parse(
    //       "https://edompetiaragatzuonline.com/flutterjualbeli/po.php/datacust"),
    //   body: {"kode": kode},
    // );

    final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/inputCeknb"),
        body: {"NO_BUKTI": kode});
    var results2 = json.decode(response.body);
    // print(results2);
    return results2.toList();
  }

  Future<List> select_order_pembelian(
      String cari, String start_date, String end_date, String supplier) async {
    var konek = await m_koneksi.koneksi();
    // print(
    //     "select * from $table where (no_bukti like '%$cari%' or kodes like '%$cari%') and tgl between '$start_date' and '$end_date';");
    if (supplier != "") {
      var results2 = await konek.query(
          "select * from $table where (no_bukti like '%$cari%' or kodes like '%$cari%') and kodes = '$supplier' and tgl between '$start_date' and '$end_date';");
      await konek.close();
      return results2.toList();
    } else {
      var results2 = await konek.query(
          "select * from $table where (no_bukti like '%$cari%' or kodes like '%$cari%') and TGL between '$start_date' and '$end_date';");
      await konek.close();
      return results2.toList();
    }
  }

  Future<List> select_order_pembelian_aktif(String cari, String sales,
      String supplier, String start_date, String end_date) async {
    var konek = await m_koneksi.koneksi();
    String filter_extra = "";
    if (sales.isNotEmpty) {
      filter_extra = " and sales = '$sales' ";
    }
    if (supplier.isNotEmpty) {
      filter_extra += " and supplier = '$supplier' ";
    }
    var results2 = await konek.query(
        "select * from $table where (no_bukti like '%$cari%' or kodes like '%$cari%') $filter_extra and status = '1' and tgl between '$start_date' and '$end_date';");
    await konek.close();
    return results2.toList();
  }

 Future<List> select_order_pembelian_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> update_total_used(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results = await konek.query(
        "update $table set total_used = total_used + 1 where no_bukti = '$no_bukti';");
    await konek.close();
    return results.toList();
  }
}
