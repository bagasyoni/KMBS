import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class model_girok {
  String baseUrl = base_url;

  /// paginate
  Future<List> data_girokpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/girokpaginate"),
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
  Future countGirokPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countgirokpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_girok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insert_girok(Map data_insert) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_girok"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "TYPE": data_insert['TYPE'].toString(),
          "BACNO": data_insert['BACNO'].toString(),
          "BNAMA": data_insert['BNAMA'].toString(),
          "CURR": data_insert['CURR'].toString(),
          "CURRNM": data_insert['CURRNM'].toString(),
          "RATE": data_insert['RATE'].toString(),
          "KODE": data_insert['KODE'].toString(),
          "NAMA": data_insert['NAMA'].toString(),
          "KET": data_insert['KET'].toString(),
          "PER": data_insert['PER'].toString(),
          "JUMLAH1": data_insert['JUMLAH1'].toString(),
          "JUMLAH": data_insert['JUMLAH'].toString(),
          "USRIN": data_insert['USRIN'].toString(),
          "TG_IN": data_insert['TG_IN'].toString(),
          "BG": data_insert['BG'].toString(),
          "UM": data_insert['UM'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
        },
      );

      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_girok"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "PER": data_insert['PER'].toString(),
            "TYPE": data_insert['TYPE'].toString(),
            "ACNO": data_detail[i]['ACNO'].toString(),
            "NACNO": data_detail[i]['NACNO'].toString(),
            "NO_FAKTUR": data_detail[i]['NO_FAKTUR'].toString(),
            "URAIAN": data_detail[i]['URAIAN'].toString(),
            "JUMLAHINV": data_detail[i]['JUMLAHINV'].toString(),
            "JUMLAH": data_detail[i]['JUMLAH'].toString(),
            "JUMLAH1": data_detail[i]['JUMLAH1'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
            "UM": data_detail[i]['UM'].toString(),
            "CURRD": data_detail[i]['CURRD'].toString(),
            "RATED": data_detail[i]['RATE'].toString(),
            "NOINV": data_detail[i]['NOINV'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_girok(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "girod"
        },
      );

      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_girok"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "TYPE": data_insert['TYPE'].toString(),
          "BACNO": data_insert['BACNO'].toString(),
          "BNAMA": data_insert['BNAMA'].toString(),
          "CURR": data_insert['CURR'].toString(),
          "CURRNM": data_insert['CURRNM'].toString(),
          "RATE": data_insert['RATE'].toString(),
          "KODE": data_insert['KODE'].toString(),
          "NAMA": data_insert['NAMA'].toString(),
          "KET": data_insert['KET'].toString(),
          "PER": data_insert['PER'].toString(),
          "JUMLAH1": data_insert['JUMLAH1'].toString(),
          "JUMLAH": data_insert['JUMLAH'].toString(),
          "USRIN": data_insert['USRIN'].toString(),
          "TG_IN": data_insert['TG_IN'].toString(),
          "BG": data_insert['BG'].toString(),
          "UM": data_insert['UM'].toString(),
          "JTEMPO": data_insert['JTEMPO'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
        },
      );

      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_girok"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "PER": data_insert['PER'].toString(),
            "TYPE": data_insert['TYPE'].toString(),
            "ACNO": data_detail[i]['ACNO'].toString(),
            "NACNO": data_detail[i]['NACNO'].toString(),
            "NO_FAKTUR": data_detail[i]['NO_FAKTUR'].toString(),
            "URAIAN": data_detail[i]['URAIAN'].toString(),
            "JUMLAHINV": data_detail[i]['JUMLAHINV'].toString(),
            "JUMLAH": data_detail[i]['JUMLAH'].toString(),
            "JUMLAH1": data_detail[i]['JUMLAH1'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
            "UM": data_detail[i]['UM'].toString(),
            "CURRD": data_detail[i]['CURRD'].toString(),
            "RATED": data_detail[i]['RATE'].toString(),
            "NOINV": data_detail[i]['NOINV'].toString(),
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
      Uri.parse("${baseUrl}:3000/no_urut_giro"),
      body: {"tipe": tipe, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cari_girok(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_girok"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_girok(
      String cari, String start_date, String end_date, String periode) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_girok"),
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
  Future<List> select_girok_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_girok(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_girok"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  //MODEL HUTANG
  Future<List> cari_hutang(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_hutang_giro"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
