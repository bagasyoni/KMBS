// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';


class model_lappon {
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
      Uri.parse("${baseUrl}:3000/lappon"),
      body: data_whr,
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }

  Future<List> delete_order_penjualan(String no_bukti) async {
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
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<bool> insert_order_pembelian(Map data_insert) async {
    try {
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
  }

  Future<List> get_no_bukti(String kode) async {
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

  Future<List> select_order_pembelian_detail(String no_bukti) async {
    final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/noto_rest-api/TransaksiPo/dataEdit"),
        body: {"NO_BUKTI": no_bukti});
    var results2 = json.decode(response.body);
    print(results2);
    return results2.toList();
  }

  Future<List> update_total_used(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results = await konek.query(
        "update $table set total_used = total_used + 1 where no_bukti = '$no_bukti';");
    await konek.close();
    return results.toList();
  }
}
