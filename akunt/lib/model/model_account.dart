import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_account {
  static String table = 'account';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_accountcari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilacc"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_account(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cariacc"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_accpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/accpaginate"),
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
  Future countAccPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countaccpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_kas(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_acc_kas"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_bank(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_acc_bank"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_account(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahacc"), body: {
      "ACNO": data_insert['ACNO'],
      "NAMA": data_insert['NAMA'],
      "NAMA_KEL": data_insert['NAMA_KEL'],
      "NM_GRUP": data_insert['NM_GRUP']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_account_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahacc"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "ACNO": data_insert['ACNO'],
      "NAMA": data_insert['NAMA'],
      "NAMA_KEL": data_insert['NAMA_KEL'],
      "NM_GRUP": data_insert['NM_GRUP'],
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_account_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusacc"),
      body: {"NO_ID": id},
    );
  }
}
