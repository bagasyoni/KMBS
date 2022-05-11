import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_sparepart {
  static String table = 'bhn';
  String baseUrl = base_url;

  Future<List> cari_sparepart(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carisparepart"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_sparepartcari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilsparepart"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_sparepartpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/sparepartpaginate"),
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
  Future countSparepartPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countsparepartpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_sparepart"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_sparepart(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahsparepart"), body: {
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_sparepart_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahsparepart"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN'],
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_sparepart_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapussparepart"),
      body: {"NO_ID": id},
    );
  }
}
