import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_mutasibrg {
  static String table = 'stockb';
  static String table_detail = 'stockbd';
  static String tipe = 'KA';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  /// paginate
  Future<List> data_mutasibrgpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/mutasibrgpaginate"),
      body: {
        "cari": cari,
        "offset": paramoffset.toString(),
        "limit": paramlimit.toString()
      },
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///paginate
  Future countMutasibrgPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countmutasibrgpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_mutasibrg(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_mutasibrg"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "PER": data_insert['PER'].toString(),
          "USRNM": data_insert['USRNM'].toString(),
          "FLAG": "KA",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_mutasibrg"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_detail[i]['KD_BRG'].toString(),
            "NA_BRG": data_detail[i]['NA_BRG'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "STOCKR": data_detail[i]['STOCKR'].toString(),
            "FISIK": data_detail[i]['FISIK'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": "KA",
          },
        );
      }
      await http.post(
        Uri.parse("${baseUrl}:3000/stockbins"),
        body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_mutasibrg(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "stockbd"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_mutasibrg"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "PER": data_insert['PER'].toString(),
          "USRNM": data_insert['USRNM'].toString(),
          "FLAG": "KA",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_mutasibrg"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_detail[i]['KD_BRG'].toString(),
            "NA_BRG": data_detail[i]['NA_BRG'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "STOCKR": data_detail[i]['STOCKR'].toString(),
            "FISIK": data_detail[i]['FISIK'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": "KA",
          },
        );
      }
      await http.post(
        Uri.parse("${baseUrl}:3000/stockbins"),
        body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countmutasibrg(String date) async {
    var konek = await m_koneksi.koneksi();
    var result = await konek
        .query("SELECT no_bukti FROM $table where TGL like '$date%';");
    await konek.close();
    return result.toList();
  }

  Future<List> get_no_bukti(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_nobukti"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_mutasibrg(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_mutasibrg"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_mutasibrg_aktif(String cari, String sales,
      String customer, String start_date, String end_date) async {
    var konek = await m_koneksi.koneksi();
    String filter_extra = "";
    if (sales.isNotEmpty) {
      filter_extra = " and sales = '$sales' ";
    }
    if (customer.isNotEmpty) {
      filter_extra += " and customer = '$customer' ";
    }
    var results2 = await konek.query(
        "select * from $table where (NO_BUKTI like '%$cari%') $filter_extra and POSTED = '0' and TGL between '$start_date' and '$end_date';");
    await konek.close();
    return results2.toList();
  }

  ///SELECT DETAIL
  Future<List> select_mutasibrg_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_mutasibrg(String no_bukti) async {
    await http.post(
      Uri.parse("${baseUrl}:3000/stockbdel"),
      body: {"NO_BUKTI": no_bukti},
    );
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_mutasibrg"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> update_status_diterima(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results = await konek
        .query("update $table set POSTED = '1' where NO_BUKTI = '$no_bukti';");
    await konek.close();
    return results.toList();
  }
}
