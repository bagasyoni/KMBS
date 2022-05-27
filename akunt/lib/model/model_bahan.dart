import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_bahan {
  String baseUrl = base_url;

  Future<List> cari_bahan(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribahan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_bahan_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_bahanpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/bahanpaginate"),
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
  Future countbahanPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbahanpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_bahan_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_bahan(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahbahan"), body: {
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN'],
      "ACNO": data_insert['ACNO'],
      "ACNO_NM": data_insert['ACNO_NM'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_bahan_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahbahan"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN'],
      "ACNO": data_insert['ACNO'],
      "ACNO_NM": data_insert['ACNO_NM'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_bahan_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusbahan"),
      body: {"NO_ID": id},
    );
  }
}
