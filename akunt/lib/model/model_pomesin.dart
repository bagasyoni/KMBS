import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_pomesin {
  static String table = 'po';
  static String table_detail = 'pod';
  static String tipe = 'PO';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_po_mesin"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_po_mesin(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_po_mesin"),
        body: {
          "nobukti": data_insert['no_bukti'].toString(),
          "dragon": data_insert['dragon'].toString(),
          "kodes": data_insert['kodes'].toString(),
          "namas": data_insert['namas'].toString(),
          "tanggal": data_insert['tanggal'].toString(),
          "jtempo": data_insert['jtempo'].toString(),
          "kota": data_insert['kota'].toString(),
          "alamat": data_insert['alamat'].toString(),
          "matauang": data_insert['matauang'].toString(),
          "kurs": data_insert['kurs'].toString(),
          "produk": data_insert['produk'].toString(),
          "jenis": data_insert['jenis'].toString(),
          "subdiv": data_insert['subdiv'].toString(),
          "an": data_insert['an'].toString(),
          "notabayar": data_insert['notabayar'].toString(),
          "notakirim": data_insert['notakirim'].toString(),
          "notes": data_insert['notes'].toString(),
          "pajak": data_insert['pajak'].toString(),
          "total": data_insert['total'].toString(),
          "per": "01/2022",
          "flag": "PB",
          "flag2": "IM",
          "user": LoginController.nama_staff.toString(),
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      // PER,TYPE,ACNO,NACNO,URAIAN,JUMLAH
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_po_mesin"),
          body: {
            "rec": (i + 1).toString(),
            "nobukti": data_insert['no_bukti'].toString(),
            "per": "01/2022",
            "flag": "PB",
            "flag2": "IM",
            "kd_brg": data_detail[i]['kd_brg'].toString(),
            "na_brg": data_detail[i]['na_brg'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "harga": data_detail[i]['harga'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "total": data_detail[i]['total'].toString(),
            "user": LoginController.nama_staff.toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_po_mesin(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['no_bukti'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "pod"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_po_mesin"),
        body: {
          "nobukti": data_insert['no_bukti'].toString(),
          "dragon": data_insert['dragon'].toString(),
          "kodes": data_insert['kodes'].toString(),
          "namas": data_insert['namas'].toString(),
          "tanggal": data_insert['tanggal'].toString(),
          "jtempo": data_insert['jtempo'].toString(),
          "kota": data_insert['kota'].toString(),
          "alamat": data_insert['alamat'].toString(),
          "matauang": data_insert['matauang'].toString(),
          "kurs": data_insert['kurs'].toString(),
          "produk": data_insert['produk'].toString(),
          "jenis": data_insert['jenis'].toString(),
          "subdiv": data_insert['subdiv'].toString(),
          "an": data_insert['an'].toString(),
          "notabayar": data_insert['notabayar'].toString(),
          "notakirim": data_insert['notakirim'].toString(),
          "notes": data_insert['notes'].toString(),
          "pajak": data_insert['pajak'].toString(),
          "total": data_insert['total'].toString(),
          "per": "01/2022",
          "flag": "PB",
          "flag2": "IM",
          "user": LoginController.nama_staff.toString(),
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      // PER,TYPE,ACNO,NACNO,URAIAN,JUMLAH
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_po_mesin"),
          body: {
            "rec": (i + 1).toString(),
            "nobukti": data_insert['no_bukti'].toString(),
            "per": "01/2022",
            "flag": "PB",
            "flag2": "IM",
            "kd_brg": data_detail[i]['kd_brg'].toString(),
            "na_brg": data_detail[i]['na_brg'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "harga": data_detail[i]['harga'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "total": data_detail[i]['total'].toString(),
            "user": LoginController.nama_staff.toString(),
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

  Future<List> cari_po_mesin(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_po_mesin"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_po_mesin(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_po_mesin"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_po_mesin_aktif(String cari, String sales, String customer,
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
  Future<List> select_po_mesin_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_po_mesin(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results1 =
        await konek.query("delete from $table where NO_BUKTI = '$no_bukti';");
    var results2 = await konek
        .query("delete from $table_detail where NO_BUKTI = '$no_bukti';");
    await konek.close();
    return results2.toList();
  }

  Future<List> update_status_diterima(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results = await konek
        .query("update $table set POSTED = '1' where NO_BUKTI = '$no_bukti';");
    await konek.close();
    return results.toList();
  }
}
