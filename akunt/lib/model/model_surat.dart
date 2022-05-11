import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_surat {
  static String table = 'surat';
  static String table_detail = 'suratd';
  static String tipe = 'SJ';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<bool> insert_surat(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_surat_jalan"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "PER": "02/2022",
          "NO_SO": data_insert['NO_SO'].toString(),
          "KODEC": data_insert['KODEC'].toString(),
          "NAMAC": data_insert['NAMAC'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "SJ",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_surat_jalan"),
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
            "FLAG": "SJ",
            "PER": "02/2022",
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> update_surat(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "suratd"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_surat"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "PER": "02/2022",
          "NO_SO": data_insert['NO_SO'].toString(),
          "KODEC": data_insert['KODEC'].toString(),
          "NAMAC": data_insert['NAMAC'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "USRNM": LoginController.nama_staff.toString(),
          "FLAG": "SJ",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_surat"),
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
            "FLAG": "SJ",
            "PER": "02/2022",
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countBukti(String date) async {
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

  ///CARI UNTUK TRANSAKSI HEADER
  Future<List> cari_surat(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_surat_jalan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///CARI UNTUK DETAIL JUAL
  Future<List> cari_surat_jual(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_surat_jalan_jual"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  ///CARI UNTUK TRANSAKSI HEADER DETAIL
  Future<List> select_surat(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_surat_jalan"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_surat_aktif(String cari, String sales, String customer,
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
  Future<List> select_surat_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_surat(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_surat_jalan"),
      body: {
        "no_bukti": no_bukti,
      },
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
