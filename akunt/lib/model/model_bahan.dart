import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_bahan {
  static String table = 'bhn';
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
      "JENIS": data_insert['JENIS'],
      "SATUAN": data_insert['SATUAN'],
      "TYPE": data_insert['TYPE'],
      "KODEV": data_insert['KODEV'],
      "KD_BHNLM": data_insert['KD_BHNLM'],
      "NA_BHNLM": data_insert['NA_BHNLM'],
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA'],
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
      "JENIS": data_insert['JENIS'],
      "SATUAN": data_insert['SATUAN'],
      "TYPE": data_insert['TYPE'],
      "KODEV": data_insert['KODEV'],
      "KD_BHNLM": data_insert['KD_BHNLM'],
      "NA_BHNLM": data_insert['NA_BHNLM'],
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA'],
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
