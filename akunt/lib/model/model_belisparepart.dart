import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_belisparepart {
  static String table = 'beli';
  static String table_detail = 'belid';
  static String tipe = 'BL';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> insert_beli_sparepart(Map data_insert) async {
    try {
      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_beli_sparepart"),
        body: {
          "nobukti": data_insert['nobukti'].toString(),
          "dr": data_insert['dr'].toString(),
          "nopo": data_insert['nopo'].toString(),
          "tglpo": data_insert['tglpo'].toString(),
          "tgl": data_insert['tgl'].toString(),
          "jtempo": data_insert['jtempo'].toString(),
          "kodes": data_insert['kodes'].toString(),
          "namas": data_insert['namas'].toString(),
          "kurs": data_insert['kurs'].toString(),
          "kota": data_insert['kota'].toString(),
          "alamat": data_insert['alamat'].toString(),
          "tglfktr": data_insert['tglfktr'].toString(),
          "nofktr": data_insert['nofktr'].toString(),
          "notes": data_insert['notes'].toString(),
          "ppn": data_insert['ppn'].toString(),
          "nett": data_insert['nett'].toString(),
          "usrnm": LoginController.nama_staff.toString(),
          "flag": "BL",
          "flag2": "SP",
          "per": "01/2022",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_beli_sparepart"),
          body: {
            "rec": (i + 1).toString(),
            "nobukti": data_insert['nobukti'].toString(),
            "kdbhn": data_detail[i]['kdbhn'].toString(),
            "nabhn": data_detail[i]['nabhn'].toString(),
            "dr": data_detail[i]['dr'].toString(),
            "satuanpp": data_detail[i]['satuanpp'].toString(),
            "qtypp": data_detail[i]['qtypp'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "harga": data_detail[i]['harga'].toString(),
            "bulat": data_detail[i]['bulat'].toString(),
            "total": data_detail[i]['total'].toString(),
            "disk": data_detail[i]['disk'].toString(),
            "val": data_detail[i]['val'].toString(),
            "usrnm": LoginController.nama_staff.toString(),
            "per": "01/2022",
            "flag": "BL",
            "flag2": "SP",
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_beli_sparepart(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['no_bukti'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "belid"
        },
      );

      ///DATA HEADER
      ///AMBIL DARI CONTROLLER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_beli_sparepart"),
        body: {
          "nobukti": data_insert['nobukti'].toString(),
          "dr": data_insert['dr'].toString(),
          "nopo": data_insert['nopo'].toString(),
          "tglpo": data_insert['tglpo'].toString(),
          "tgl": data_insert['tgl'].toString(),
          "jtempo": data_insert['jtempo'].toString(),
          "kodes": data_insert['kodes'].toString(),
          "namas": data_insert['namas'].toString(),
          "kurs": data_insert['kurs'].toString(),
          "kota": data_insert['kota'].toString(),
          "alamat": data_insert['alamat'].toString(),
          "tglfktr": data_insert['tglfktr'].toString(),
          "nofktr": data_insert['nofktr'].toString(),
          "notes": data_insert['notes'].toString(),
          "ppn": data_insert['ppn'].toString(),
          "nett": data_insert['nett'].toString(),
          "usrnm": LoginController.nama_staff.toString(),
          "flag": "BL",
          "flag2": "SP",
          "per": "01/2022",
        },
      );

      ///DATA DETAIL
      ///AMBIL DARI CONTROLLER
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_beli_sparepart"),
          body: {
            "rec": (i + 1).toString(),
            "nobukti": data_insert['nobukti'].toString(),
            "kdbhn": data_detail[i]['kdbhn'].toString(),
            "nabhn": data_detail[i]['nabhn'].toString(),
            "dr": data_detail[i]['dr'].toString(),
            "satuanpp": data_detail[i]['satuanpp'].toString(),
            "qtypp": data_detail[i]['qtypp'].toString(),
            "satuan": data_detail[i]['satuan'].toString(),
            "qty": data_detail[i]['qty'].toString(),
            "harga": data_detail[i]['harga'].toString(),
            "bulat": data_detail[i]['bulat'].toString(),
            "total": data_detail[i]['total'].toString(),
            "disk": data_detail[i]['disk'].toString(),
            "val": data_detail[i]['val'].toString(),
            "usrnm": LoginController.nama_staff.toString(),
            "per": "01/2022",
            "flag": "BL",
            "flag2": "SP",
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

  Future<List> cari_belisparepart(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_beli_sparepart"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_beli_sparepart(
      String cari, String start_date, String end_date) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_beli_sparepart"),
      body: {"cari": cari, "tglawal": start_date, "tglakhir": end_date},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> select_beli_sparepart_aktif(String cari, String sales,
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
  Future<List> select_beli_sparepart_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_beli_sparepart(String no_bukti) async {
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
