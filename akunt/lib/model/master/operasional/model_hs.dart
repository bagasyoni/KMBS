import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_hs {
  String baseUrl = base_url;

  Future<List> cari_hs(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carihs"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_hs_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilhs"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_hspaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hspaginate"),
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
  Future countHsPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/counthspaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///filter_modal
  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_hs"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_hs(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahhs"), body: {
      "NO_HS": data_insert['NO_HS'],
      "URAIAN": data_insert['URAIAN'],
      "KD_SATUAN": data_insert['KD_SATUAN'],
      "KD_BRG": data_insert['KD_BRG'],
      "KDJENIS": data_insert['KDJENIS'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_hs_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahhs"), body: {
      "NO_HS": data_insert['NO_HS'],
      "URAIAN": data_insert['URAIAN'],
      "KD_SATUAN": data_insert['KD_SATUAN'],
      "KD_BRG": data_insert['KD_BRG'],
      "KDJENIS": data_insert['KDJENIS'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> check_hs(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_hs"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_hs_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapushs"),
      body: {"ID_HS": id},
    );
  }
}
