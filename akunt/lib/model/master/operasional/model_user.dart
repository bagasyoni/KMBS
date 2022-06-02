import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_user {
  String baseUrl = base_url;

  Future<List> cari_user(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cariuser"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_user_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampiluser"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_userpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/userpaginate"),
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
  Future countUserPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countuserpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///filter_modal
  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_user_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_user(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahuser"), body: {
      "USERNAME": data_insert['USERNAME'],
      "PASSWORD": data_insert['PASSWORD'],
      "STATUS": data_insert['STATUS'],
      "NOTES": data_insert['NOTES'],
      "USRIN": data_insert['USRIN'],
      "TG_IN": data_insert['TG_IN'].toString(),
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_user_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahuser"), body: {
      "USERNAME": data_insert['USERNAME'],
      "PASSWORD": data_insert['PASSWORD'],
      "STATUS": data_insert['STATUS'],
      "NOTES": data_insert['NOTES'],
      "USRIN": data_insert['USRIN'],
      "TG_IN": data_insert['TG_IN'].toString(),
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> check_username(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_username"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_user_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapususer"),
      body: {"USERNAME": id},
    );
  }
}
