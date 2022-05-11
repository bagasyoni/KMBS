import 'package:akunt/view/printing/printer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_periode {
  static String table = 'perid';
  String baseUrl = base_url;

  Future<List> cari_periode(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cariperiode"),
      body: {"cari": key_cari},
    );
    var result2 = json.decode(response.body);
    return result2['data'].toList();
  }

  Future<List> data_periode_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilperiode"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cariperiode"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_periode(Map data_insert) async {
    final response = await http.post(Uri.parse("${baseUrl}:3000/tambahperid"),
        body: {"PERIOD": data_insert['PERIOD'], "YER": data_insert['YER']});
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_periode_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahperiode"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "PERIOD": data_insert['PERIOD'],
      "YER": data_insert['YER']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_periode_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusperiode"),
      body: {"NO_ID": id},
    );
  }
}
