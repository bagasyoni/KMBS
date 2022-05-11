import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_thutimport {
  static String table = 'beli';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> cari_thutimport(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_thut_import"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_thutimport_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_thut_import"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_thutimport_paginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/thut_paginate_import"),
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
  Future count_thutimport_Paginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/count_thutpaginate_import"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_thutimport(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_thut_import"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> get_data_thutimport(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_thutimport(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambah_thut_import"), body: {
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_BELI": data_insert['NO_BELI'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "DR": data_insert['DR'],
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "FLAG": "HT",
      "FLAG2": "IMP",
      "PER": "01/2022",
      "USRNM": LoginController.nama_staff.toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_thutimport_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_thut_import"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_BELI": data_insert['NO_BELI'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "DR": data_insert['DR'],
      "TOTAL": data_insert['TOTAL'],
      "NOTES": data_insert['NOTES'],
      "FLAG": "HT",
      "FLAG2": "IMP",
      "PER": "01/2022",
      "USRNM": LoginController.nama_staff.toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> countBukti(String date) async {
    var konek = await m_koneksi.koneksi();
    var result = await konek
        .query("SELECT no_bukti FROM $table where TGL like '$date%';");
    await konek.close();
    return result.toList();
  }

  Future<List> delete_thutimport_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_thut_import"),
      body: {"NO_ID": id},
    );
  }
}
