import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class model_supplier {
  static String table = 'sup';
  String baseUrl = base_url;

  Future<List> cari_supplier(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/carisup"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_supplier_tampil(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilsup"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_suppaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/suppaginate"),
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
  Future countSupPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countsuppaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_sup_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_supplier(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahsup"), body: {
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "HP": data_insert['HP'],
      "FAX": data_insert['FAX'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "BANK": data_insert['BANK'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "PKP": data_insert['PKP'],
      "NPWP": data_insert['NPWP'],
      "BARANG": data_insert['BARANG'],
      "DISKON": data_insert['DISKON'],
      "HARGA": data_insert['HARGA'],
      "AKT": data_insert['AKT']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_supplier_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahsup"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KODES": data_insert['KODES'],
      "NAMAS": data_insert['NAMAS'],
      "ALAMAT": data_insert['ALAMAT'],
      "KOTA": data_insert['KOTA'],
      "TELPON1": data_insert['TELPON1'],
      "HP": data_insert['HP'],
      "FAX": data_insert['FAX'],
      "KONTAK": data_insert['KONTAK'],
      "EMAIL": data_insert['EMAIL'],
      "BANK": data_insert['BANK'],
      "BANK_NAMA": data_insert['BANK_NAMA'],
      "BANK_REK": data_insert['BANK_REK'],
      "BANK_CAB": data_insert['BANK_CAB'],
      "BANK_KOTA": data_insert['BANK_KOTA'],
      "PKP": data_insert['PKP'],
      "NPWP": data_insert['NPWP'],
      "BARANG": data_insert['BARANG'],
      "DISKON": data_insert['DISKON'],
      "HARGA": data_insert['HARGA'],
      "AKT": data_insert['AKT']
    });
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_supplier_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapussup"),
      body: {"NO_ID": id},
    );
  }
}
