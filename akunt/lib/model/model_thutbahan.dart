import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_thutbahan {
  static String table = 'beli';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> cari_thutbahan(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_thut_bahan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_thutbahan_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_thut_bahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_thutbahan_paginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/thut_paginate_bahan"),
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
  Future count_thutbahan_Paginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/count_thutpaginate_bahan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_thutbahan(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_thut_bahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> get_data_thutbahan(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_thutbahan(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambah_thut_bahan"), body: {
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_BELI": data_insert['NO_BELI'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "FLAG": "HT",
      "PER": data_insert['PER'].toString(),
      "USRNM": LoginController.nama_staff.toString(),
    });
    await http.post(
      Uri.parse("${baseUrl}:3000/thutins"),
      body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
    );
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_thutbahan_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_thut_bahan"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_BELI": data_insert['NO_BELI'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "TOTAL": data_insert['TOTAL'],
      "NOTES": data_insert['NOTES'],
      "FLAG": "HT",
      "PER": data_insert['PER'].toString(),
      "USRNM": LoginController.nama_staff.toString(),
    });
    await http.post(
      Uri.parse("${baseUrl}:3000/thutins"),
      body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
    );
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
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

  Future<List> delete_thutbahan_byID(String id, String no_bukti) async {
    await http.post(
      Uri.parse("${baseUrl}:3000/thutdel"),
      body: {"NO_BUKTI": no_bukti},
    );
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_thut_bahan"),
      body: {"NO_ID": id},
    );
  }
}
