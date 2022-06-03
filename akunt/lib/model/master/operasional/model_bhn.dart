import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class model_bhn {
  String baseUrl = base_url;

  Future<List> cari_bahan(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/caribahan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_bhn() async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbahan"),
      // body: {"cari": cari},
    );
    var results2 = json.decode(response.body);

    return results2['data'].toList();
  }

  Future<List> data_bhncari(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampilbahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///paginate
  Future countBhnPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbahanpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  /// paginate
  Future<List> data_bhnpaginate(
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

  ///filter_modal
  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_bahan_stok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_data_bhn(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/tambahbahan"), body: {
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN'],
      "HARGA": data_insert['HARGA']
    });

    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<bool> update_data_bhn_by_id(Map data_insert) async {
    final response =
        await http.post(Uri.parse("${baseUrl}:3000/ubahbhn"), body: {
      "NO_ID": data_insert['NO_ID'].toString(),
      "KD_BHN": data_insert['KD_BHN'],
      "NA_BHN": data_insert['NA_BHN'],
      "SATUAN": data_insert['SATUAN'],
      "HARGA": data_insert['HARGA']
    });

    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }

  Future<List> delete_bhn_byID(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapusbhn"),
      body: {"NO_ID": id},
    );
  }
}
