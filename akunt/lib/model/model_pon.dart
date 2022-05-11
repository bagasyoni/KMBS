import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import '../constants.dart';

class model_pon {
  static String table = 'po';
  String baseUrl = base_url;

  Future<List> data_pon(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pon"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> search_pon(String pon) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pon"),
      body: {"cari": pon},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> noUrutPon(
      String jenis, String paramtabel, String paramkolom) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": jenis, "tabel": paramtabel, "kolom": paramkolom},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_pon(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambah_pon"), body: {
      "NO_PO": data_insert['NO_PO'],
      "TGL": data_insert['TGL'],
      // "FLAG": "BHN",
      "JTEMPO": data_insert['JTEMPO'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "HARGA": data_insert['HARGA'].toString(),
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "RPRATE": data_insert['RPRATE'].toString(),
      "RPHARGA": data_insert['RPHARGA'].toString(),
      "RPTOTAL": data_insert['RPTOTAL'].toString()
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> get_data_po(String nobukti) async {}

  Future<List> select_po(
      String cari, String start_date, String end_date) async {}

  Future<bool> update_pon_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_pon"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_PO": data_insert['NO_PO'],
      "TGL": data_insert['TGL'],
      "JTEMPO": data_insert['JTEMPO'],
      "NAMAS": data_insert['NAMAS'],
      "KODES": data_insert['KODES'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "HARGA": data_insert['HARGA'].toString(),
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "RPRATE": data_insert['RPRATE'].toString(),
      "RPHARGA": data_insert['RPHARGA'].toString(),
      "RPTOTAL": data_insert['RPTOTAL'].toString()
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_pon(String NO_ID) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_pon"),
      body: {"noid": NO_ID},
    );
  }
}
