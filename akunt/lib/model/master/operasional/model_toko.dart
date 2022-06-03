import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_toko {
  String baseUrl = base_url;

  Future<List> data_tokocari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampiltoko"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_toko(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caritoko"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_tokopaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tokopaginate"),
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
  Future countTokoPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/counttokopaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal_toko(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_toko"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_toko(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahtoko"), body: {
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON": data_insert['TELPON'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_toko_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahtoko"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODE": data_insert['KODE'],
      "NAMA": data_insert['NAMA'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON": data_insert['TELPON'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_toko_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapustoko"),
      body: {"NO_ID": id},
    );
  }
}
