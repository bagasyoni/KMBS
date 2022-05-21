import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_pakaibhn {
  String baseUrl = base_url;

  /// paginate
  Future<List> data_pakaibhnpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/pakaibhnpaginate"),
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
  Future countPakaibhnPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countpakaibhnpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_pakaibhn"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_pakaibhn(Map data_insert) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_pakaibhn"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "USRIN": data_insert['USRIN'].toString(),
          "PER": data_insert['PER'].toString(),
          "TG_IN": data_insert['TG_IN'].toString(),
        },
      );

      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_pakaibhn"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BHN": data_detail[i]['KD_BHN'].toString(),
            "NA_BHN": data_detail[i]['NA_BHN'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_pakaibhn(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "pakaid"
        },
      );

      ///DATA HEADER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_pakaibhn"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "USRNM": data_insert['USRNM'].toString(),
          "PER": data_insert['PER'].toString(),
          "TG_SMP": data_insert['TG_SMP'].toString(),
        },
      );

      ///DATA DETAIL
      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_pakaibhn"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "KD_BHN": data_detail[i]['KD_BHN'].toString(),
            "NA_BHN": data_detail[i]['NA_BHN'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> check_no_bukti(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_nobukti"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> get_no_bukti(
      String tipe, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": tipe, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_pakai_bhn(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_pakaibhn"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_pakaibhn(
      String cari, String start_date, String end_date, String periode) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_pakaibhn"),
      body: {
        "cari": cari,
        "tglawal": start_date,
        "tglakhir": end_date,
        "periode": periode
      },
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT DETAIL
  Future<List> select_pakaibhn_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_pakaibhn(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_pakaibhn"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
