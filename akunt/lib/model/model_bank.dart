import 'package:akunt/view/printing/printer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_bank {
  static String table = 'bank';
  String baseUrl = base_url;

  Future<List> cari_bank(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribank"),
      body: {"cari": key_cari},
    );
    var result2 = json.decode(response.body);
    return result2['data'].toList();
  }

  Future<List> data_bank_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbank"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribank"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_bank(Map data_insert) async {
    final response = await http.post(Uri.parse("${baseUrl}:3000/tambahbank"),
        body: {
          "KD_BANK": data_insert['KD_BANK'],
          "NA_BANK": data_insert['NA_BANK']
        });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_bank_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahbank"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BANK": data_insert['KD_BANK'],
      "NA_BANK": data_insert['NA_BANK']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_bank_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusbank"),
      body: {"NO_ID": id},
    );
  }
}
