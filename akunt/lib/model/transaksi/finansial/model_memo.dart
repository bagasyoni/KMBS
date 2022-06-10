import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_memo {
  static String table = 'memo';
  static String table_detail = 'memod';
  static String tipe = 'MEMO';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> insert_memo(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_memo"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "KET": data_insert['KET'].toString(),
          "DEBET": data_insert['DEBET'].toString(),
          "KREDIT": data_insert['KREDIT'].toString(),
          "PER": "02/2022",
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "M",
          "TYPE": "MM",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_memo"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "PER": "02/2022",
            "ACNO": data_detail[i]['ACNO'].toString(),
            "NACNO": data_detail[i]['NACNO'].toString(),
            "URAIAN": data_detail[i]['URAIAN'].toString(),
            "DEBET": data_detail[i]['DEBET'].toString(),
            "KREDIT": data_detail[i]['KREDIT'].toString(),
            "FLAG": "M",
            "TYPE": "MM",
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_memo(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "memod"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_memo"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "KET": data_insert['KET'].toString(),
          "DEBET": data_insert['DEBET'].toString(),
          "KREDIT": data_insert['KREDIT'].toString(),
          "PER": "02/2022",
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "M",
          "TYPE": "MM",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_memo"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "PER": "01/2022",
            "ACNO": data_detail[i]['ACNO'].toString(),
            "NACNO": data_detail[i]['NACNO'].toString(),
            "URAIAN": data_detail[i]['URAIAN'].toString(),
            "DEBET": data_detail[i]['DEBET'].toString(),
            "KREDIT": data_detail[i]['KREDIT'].toString(),
            "FLAG": "M",
            "TYPE": "MM",
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countmemo(String date) async {
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
  Future<List> select_memo(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_memo"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_memo_aktif(String cari, String sales, String customer,
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
  Future<List> select_memo_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_memo(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_memo"),
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
