import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_so {
  static String table = 'so';
  static String table_detail = 'sod';
  static String tipe = 'SO';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  /// paginate
  Future<List> data_sopaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/sopaginate"),
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
  Future countSoPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countsopaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_so"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_so(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_so"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "PER": data_insert['PER'].toString(),
          "KODEC": data_insert['KODEC'].toString(),
          "NAMAC": data_insert['NAMAC'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "SO",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      // PER,TYPE,ACNO,NACNO,URAIAN,JUMLAH
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_so"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_detail[i]['KD_BRG'].toString(),
            "NA_BRG": data_detail[i]['NA_BRG'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "HARGA": data_detail[i]['HARGA'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "TOTAL": data_detail[i]['TOTAL'].toString(),
            "FLAG": "SO",
            "PER": data_insert['PER'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///UPDATE PO BAHAN DETAIL
  Future<List> update_so(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "sod"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_so"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "PER": data_insert['PER'].toString(),
          "KODEC": data_insert['KODEC'].toString(),
          "NAMAC": data_insert['NAMAC'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "SO",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_so"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BRG": data_detail[i]['KD_BRG'].toString(),
            "NA_BRG": data_detail[i]['NA_BRG'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "HARGA": data_detail[i]['HARGA'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "TOTAL": data_detail[i]['TOTAL'].toString(),
            "FLAG": "SO",
            "PER": data_insert['PER'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> check_no_bukti(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_nobukti"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> get_no_bukti(
      String tipe, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": tipe, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_so(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_so"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_so(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_so"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_so_aktif(String cari, String sales, String customer,
      String start_date, String end_date) async {
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
  Future<List> select_so_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///COBA COBA SELECT DETAIL
  Future<List> select_detail(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/ambil_so_detail"),
      body: {"cari": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_so(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_so"),
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
