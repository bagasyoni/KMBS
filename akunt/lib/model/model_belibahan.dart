import 'package:akunt/controller/login_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class model_belibahan {
  String baseUrl = base_url;

  /// paginate
  Future<List> data_belibahanpaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/belibahanpaginate"),
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
  Future countBelibahanPaginate(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbelibahanpaginate"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> data_modal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_beli_bahan"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<bool> insert_beli_bahan(Map data_insert) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_beli_bahan"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NO_SJ": data_insert['NO_SJ'].toString(),
          "TGL_SJ": data_insert['TGL_SJ'].toString(),
          "TGL_INVOICE": data_insert['TGL_INVOICE'].toString(),
          "NO_FP": data_insert['NO_FP'].toString(),
          "TGL_FP": data_insert['TGL_FP'].toString(),
          "CURR": data_insert['CURR'].toString(),
          "CURRNM": data_insert['CURRNM'].toString(),
          "RATE": data_insert['RATE'].toString(),
          "KODES": data_insert['KODES'].toString(),
          "NAMAS": data_insert['NAMAS'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL1": data_insert['TOTAL1'].toString(),
          "DISC": data_insert['DISC'].toString(),
          "PPN": data_insert['PPN'].toString(),
          "PPH": data_insert['PPH'].toString(),
          "DISC1": data_insert['DISC1'].toString(),
          "PPN1": data_insert['PPN1'].toString(),
          "PPH1": data_insert['PPH1'].toString(),
          "NETT1": data_insert['NETT1'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "RPDISC": data_insert['RPDISC'].toString(),
          "RPPPN": data_insert['RPPPN'].toString(),
          "RPPPH": data_insert['RPPPH'].toString(),
          "RPDISC1": data_insert['RPDISC1'].toString(),
          "RPPPN1": data_insert['RPPPN1'].toString(),
          "RPPPH1": data_insert['RPPPH1'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
          "TYP": data_insert['TYP'].toString(),
          "USRIN": data_insert['USRIN'].toString(),
          "PER": data_insert['PER'].toString(),
          "GOL": data_insert['GOL'].toString(),
          "NO_PO": data_insert['NO_PO'].toString(),
          "SISA": data_insert['SISA'].toString(),
          "TG_IN": data_insert['TG_IN'].toString(),
          "INVOICE": data_insert['INVOICE'].toString(),
          "INVOICEX": data_insert['INVOICEX'],
        },
      );

      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_beli_bahan"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "QTYPO": data_detail[i]['QTYPO'].toString(),
            "KD_BHN": data_detail[i]['KD_BHN'].toString(),
            "NA_BHN": data_detail[i]['NA_BHN'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "HARGA": data_detail[i]['HARGA'].toString(),
            "TOTAL": data_detail[i]['TOTAL'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "HARGA1": data_detail[i]['HARGA1'].toString(),
            "TOTAL1": data_detail[i]['TOTAL1'].toString(),
            "BLT": data_detail[i]['BLT'].toString(),
            "DISC": data_detail[i]['DISC'].toString(),
            "RRPDISC": data_detail[i]['RRPDISC'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
            "TYP": data_detail[i]['TYP'].toString(),
            "GOL": data_detail[i]['GOL'].toString(),
            "NO_PO": data_detail[i]['NO_PO'].toString(),
          },
        );
      }
      await http.post(
        Uri.parse("${baseUrl}:3000/beliins"),
        body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> update_beli_bahan(Map data_insert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/belidel"),
        body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
      );
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": data_insert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "belid"
        },
      );

      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_beli_bahan"),
        body: {
          "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
          "TGL": data_insert['TGL'].toString(),
          "NO_SJ": data_insert['NO_SJ'].toString(),
          "TGL_SJ": data_insert['TGL_SJ'].toString(),
          "TGL_INVOICE": data_insert['TGL_INVOICE'].toString(),
          "NO_FP": data_insert['NO_FP'].toString(),
          "TGL_FP": data_insert['TGL_FP'].toString(),
          "CURR": data_insert['CURR'].toString(),
          "CURRNM": data_insert['CURRNM'].toString(),
          "RATE": data_insert['RATE'].toString(),
          "KODES": data_insert['KODES'].toString(),
          "NAMAS": data_insert['NAMAS'].toString(),
          "ALAMAT": data_insert['ALAMAT'].toString(),
          "KOTA": data_insert['KOTA'].toString(),
          "NOTES": data_insert['NOTES'].toString(),
          "TOTAL_QTY": data_insert['TOTAL_QTY'].toString(),
          "TOTAL1": data_insert['TOTAL1'].toString(),
          "DISC": data_insert['DISC'].toString(),
          "PPN": data_insert['PPN'].toString(),
          "PPH": data_insert['PPH'].toString(),
          "DISC1": data_insert['DISC1'].toString(),
          "PPN1": data_insert['PPN1'].toString(),
          "PPH1": data_insert['PPH1'].toString(),
          "NETT1": data_insert['NETT1'].toString(),
          "TOTAL": data_insert['TOTAL'].toString(),
          "RPDISC": data_insert['RPDISC'].toString(),
          "RPPPN": data_insert['RPPPN'].toString(),
          "RPPPH": data_insert['RPPPH'].toString(),
          "RPDISC1": data_insert['RPDISC1'].toString(),
          "RPPPN1": data_insert['RPPPN1'].toString(),
          "RPPPH1": data_insert['RPPPH1'].toString(),
          "NETT": data_insert['NETT'].toString(),
          "FLAG": data_insert['FLAG'].toString(),
          "TYP": data_insert['TYP'].toString(),
          "USRIN": data_insert['USRIN'].toString(),
          "PER": data_insert['PER'].toString(),
          "GOL": data_insert['GOL'].toString(),
          "NO_PO": data_insert['NO_PO'].toString(),
          "SISA": data_insert['SISA'].toString(),
          "TG_IN": data_insert['TG_IN'].toString(),
          "INVOICE": data_insert['INVOICE'].toString(),
          "INVOICEX": data_insert['INVOICEX'],
        },
      );

      List data_detail = data_insert['tabeld'];
      for (int i = 0; i < data_detail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_beli_bahan"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": data_insert['NO_BUKTI'].toString(),
            "QTYPO": data_detail[i]['QTYPO'].toString(),
            "KD_BHN": data_detail[i]['KD_BHN'].toString(),
            "NA_BHN": data_detail[i]['NA_BHN'].toString(),
            "SATUAN": data_detail[i]['SATUAN'].toString(),
            "QTY": data_detail[i]['QTY'].toString(),
            "HARGA": data_detail[i]['HARGA'].toString(),
            "TOTAL": data_detail[i]['TOTAL'].toString(),
            "KET": data_detail[i]['KET'].toString(),
            "HARGA1": data_detail[i]['HARGA1'].toString(),
            "TOTAL1": data_detail[i]['TOTAL1'].toString(),
            "BLT": data_detail[i]['BLT'].toString(),
            "DISC": data_detail[i]['DISC'].toString(),
            "RRPDISC": data_detail[i]['RRPDISC'].toString(),
            "PER": data_insert['PER'].toString(),
            "FLAG": data_insert['FLAG'].toString(),
            "TYP": data_detail[i]['TYP'].toString(),
            "GOL": data_detail[i]['GOL'].toString(),
            "NO_PO": data_detail[i]['NO_PO'].toString(),
          },
        );
      }
      await http.post(
        Uri.parse("${baseUrl}:3000/beliins"),
        body: {"NO_BUKTI": data_insert['NO_BUKTI'].toString()},
      );
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

  Future<List> cari_belibahan(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_beli_bahan"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///CARI UNTUK DETAIL HUT
  Future<List> cari_belibahan_hut(String key_cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_beli_bahan_hut"),
      body: {"cari": key_cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> select_beli_bahan(
      String cari, String start_date, String end_date, String periode) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_beli_bahan"),
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
  Future<List> select_beli_bahan_detail(
      String no_bukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": no_bukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> delete_beli_bahan(String no_bukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_beli_bahan"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
