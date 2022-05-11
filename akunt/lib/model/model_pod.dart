import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import '../constants.dart';

class model_pod {
  static String table = 'pod';
  String baseUrl = base_url;

  Future<List> cari_pod(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pod_bahan(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod_bahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pod_nonbahan(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod_nonbahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pod_import(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod_import"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pod_mesin(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod_mesin"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pod_sparepart(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pod_sparepart"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///filter_modal
  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_pod"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
