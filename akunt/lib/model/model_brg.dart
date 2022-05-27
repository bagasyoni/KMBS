import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_brg {
  String baseUrl = base_url;

  Future<List> cari_barang(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribrg"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_brg_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbrg"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_brgpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/brgpaginate"),
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
  Future countBrgPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbrgpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///filter_modal
  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_brg_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_brg(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahbrg"), body: {
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "SATUAN": data_insert['SATUAN'],
      "ACNO": data_insert['ACNO'],
      "ACNO_NM": data_insert['ACNO_NM'],
      "PRODUK": data_insert['PRODUK'],
      "SIZ": data_insert['SIZ'].toString(),
      "WARNA": data_insert['WARNA'],
      "JENIS": data_insert['JENIS'],
      "NOTES": data_insert['NOTES'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_brg_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahbrg"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BRG": data_insert['KD_BRG'],
      "NA_BRG": data_insert['NA_BRG'],
      "SATUAN": data_insert['SATUAN'],
      "ACNO": data_insert['ACNO'],
      "ACNO_NM": data_insert['ACNO_NM'],
      "PRODUK": data_insert['PRODUK'],
      "SIZ": data_insert['SIZ'].toString(),
      "WARNA": data_insert['WARNA'],
      "JENIS": data_insert['JENIS'],
      "NOTES": data_insert['NOTES'],
      "USRNM": data_insert['USRNM'],
      "TG_SMP": data_insert['TG_SMP'].toString(),
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_brg_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusbrg"),
      body: {"NO_ID": id},
    );
  }
}
