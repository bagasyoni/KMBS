import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_tpiu {
  static String table = 'jual';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> cari_tpiu(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_tpiu"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_tpiu_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_tpiu"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_tpiu_paginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tpiu_paginate"),
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
  Future count_tpiu_Paginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/count_tpiupaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_tpiu(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_tpiu"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> get_data_tpiu(String id) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where NO_ID = '$id';");
    await konek.close();
    return results2.toList();
  }

  Future<bool> insert_data_tpiu(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambah_tpiu"), body: {
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_JUAL": data_insert['NO_JUAL'],
      "KODEC": data_insert['KODEC'],
      "NAMAC": data_insert['NAMAC'],
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "FLAG": "PT",
      "PER": "02/2022",
      "USRNM": LoginController.nama_staff.toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_tpiu_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_tpiu"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_JUAL": data_insert['NO_JUAL'],
      "KODEC": data_insert['KODEC'],
      "NAMAC": data_insert['NAMAC'],
      "TOTAL": data_insert['TOTAL'],
      "NOTES": data_insert['NOTES'],
      "FLAG": "PT",
      "PER": "02/2022",
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

  Future<List> delete_tpiu_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_tpiu"),
      body: {"NO_ID": id},
    );
  }
}
