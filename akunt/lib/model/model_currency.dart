import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_currency {
  static String table = 'currency';
  koneksi_mysql m_koneksi = koneksi_mysql();
  String baseUrl = base_url;

  Future<List> data_currencycari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilcurr"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_currency(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caricurr"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_currpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/currpaginate"),
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
  Future countCurrPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countcurrpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_curr(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_curr"),
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

  Future<bool> insert_data_currency(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahcurr"), body: {
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

  Future<bool> update_data_currency_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahcurr"), body: {
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

  Future<List> delete_currency_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapuscurr"),
      body: {"NO_ID": id},
    );
  }
}
