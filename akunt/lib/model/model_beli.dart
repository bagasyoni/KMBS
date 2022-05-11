import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import '../constants.dart';

class model_beli {
  static String table = 'beli';
  String baseUrl = base_url;

  Future<List> data_beli(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_beli"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> search_beli(String beli) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_beli"),
      body: {"cari": beli},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_belipaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/belipaginate"),
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
  Future countBeliPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbelipaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> noUrutBeli(
      String jenis, String paramtabel, String paramkolom) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": jenis, "tabel": paramtabel, "kolom": paramkolom},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

// NO_BUKTI, TGL, NO_PO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, LAIN, TOTAL, NOTES, RPRATE, RPHARGA, RPLAIN, RPTOTAL, AJU, BL, EMKL, JCONT, HARGAT, ACNOA, NACNOA
  Future<bool> insert_beli(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambah_beli"), body: {
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_PO": data_insert['NO_PO'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "HARGA": data_insert['HARGA'].toString(),
      "LAIN": data_insert['LAIN'],
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "RPRATE": data_insert['RPRATE'].toString(),
      "RPHARGA": data_insert['RPHARGA'].toString(),
      "RPLAIN": data_insert['RPLAIN'].toString(),
      "RPTOTAL": data_insert['RPTOTAL'].toString(),
      "AJU": data_insert['AJU'].toString(),
      "BL": data_insert['BL'].toString(),
      "EMKL": data_insert['EMKL'],
      "JCONT": data_insert['JCONT'].toString(),
      "HARGAT": data_insert['HARGAT'].toString(),
      "ACNOA": data_insert['ACNOA'],
      "NACNOA": data_insert['NACNOA']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_beli_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubah_beli"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "NO_BUKTI": data_insert['NO_BUKTI'],
      "TGL": data_insert['TGL'],
      "NO_PO": data_insert['NO_PO'],
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "KG": data_insert['KG'].toString(),
      "HARGA": data_insert['HARGA'].toString(),
      "LAIN": data_insert['LAIN'],
      "TOTAL": data_insert['TOTAL'].toString(),
      "NOTES": data_insert['NOTES'],
      "RPRATE": data_insert['RPRATE'].toString(),
      "RPHARGA": data_insert['RPHARGA'].toString(),
      "RPLAIN": data_insert['RPLAIN'].toString(),
      "RPTOTAL": data_insert['RPTOTAL'].toString(),
      "AJU": data_insert['AJU'].toString(),
      "BL": data_insert['BL'].toString(),
      "EMKL": data_insert['EMKL'],
      "JCONT": data_insert['JCONT'].toString(),
      "HARGAT": data_insert['HARGAT'].toString(),
      "ACNOA": data_insert['ACNOA'],
      "NACNOA": data_insert['NACNOA']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_beli(String NO_ID) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_beli"),
      body: {"noid": NO_ID},
    );
  }
}
