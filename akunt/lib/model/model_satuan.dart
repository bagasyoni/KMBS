import 'package:flutter/material.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_satuan {
  static String table = 'master_satuan';
  String baseUrl = base_url;

  Future<List> data_satuan(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carisatuan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_satuan_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilsatuan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_satuan(String satuan) async {}

  Future<bool> cek_data_satuan(String satuan) async {}
}
