import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_bagas {
  static String table = 'bagas';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_bagascari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbagas"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_bagas(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_acc_kas"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_bagas(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribagas"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_bagaspaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/bagaspaginate"),
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
  Future countBagasPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbagaspaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_bagas(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahbagas"), body: {
      "KD_BGS": data_insert['KD_BGS'],
      "NA_BGS": data_insert['NA_BGS'],
      "SATUAN": data_insert['SATUAN']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_bagas_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahbagas"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BGS": data_insert['KD_BGS'],
      "NA_BGS": data_insert['NA_BGS'],
      "SATUAN": data_insert['SATUAN']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_bagas_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusbagas"),
      body: {"NO_ID": id},
    );
  }
}
