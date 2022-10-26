import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class ModelBtbBarangLokal {
  String baseUrl = base_url;

  /// paginate
  Future<List> dataBtbBarangLokalPaginate(
      String cari, int paramoffset, int paramlimit) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/btbbaranglokalpaginate"),
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
  Future countBtbBarangLokalPaginate(String keyCari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/countbtbbaranglokalpaginate"),
      body: {"cari": keyCari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> dataModal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/modal_btb_barang_lokal"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> insertBtbBarangLokal(Map dataInsert) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/tambah_header_btb_barang_lokal"),
        body: {
          "NO_BUKTI": dataInsert['NO_BUKTI'].toString(),
          "TGL": dataInsert['TGL'].toString(),
          "JTEMPO": dataInsert['JTEMPO'].toString(),
          "CURR": dataInsert['CURR'].toString(),
          "CURRNM": dataInsert['CURRNM'].toString(),
          "RATE": dataInsert['RATE'].toString(),
          "KODES": dataInsert['KODES'].toString(),
          "NAMAS": dataInsert['NAMAS'].toString(),
          "ALAMAT": dataInsert['ALAMAT'].toString(),
          "KOTA": dataInsert['KOTA'].toString(),
          "NOTES": dataInsert['NOTES'].toString(),
          "TOTAL_QTY": dataInsert['TOTAL_QTY'].toString(),
          "SISA_QTY": dataInsert['SISA_QTY'].toString(),
          "TOTAL1": dataInsert['TOTAL1'].toString(),
          "DISC": dataInsert['DISC'].toString(),
          "PPN": dataInsert['PPN'].toString(),
          "NETT1": dataInsert['NETT1'].toString(),
          "DISC1": dataInsert['DISC1'].toString(),
          "PPN1": dataInsert['PPN1'].toString(),
          "PPH1": dataInsert['PPH1'].toString(),
          "PPH": dataInsert['PPH'].toString(),
          "TOTAL": dataInsert['TOTAL'].toString(),
          "RPDISC": dataInsert['RPDISC'].toString(),
          "RPPPN": dataInsert['RPPPN'].toString(),
          "NETT": dataInsert['NETT'].toString(),
          "SISA": dataInsert['SISA'].toString(),
          "RPDISC1": dataInsert['RPDISC1'].toString(),
          "RPPPN1": dataInsert['RPPPN1'].toString(),
          "RPPPH1": dataInsert['RPPPH1'].toString(),
          "RPPPH": dataInsert['RPPPH'].toString(),
          "USRIN": dataInsert['USRIN'].toString(),
          "TG_IN": dataInsert['TG_IN'].toString(),
          "FLAG": dataInsert['FLAG'].toString(),
          "PER": dataInsert['PER'].toString(),
          "TYP": dataInsert['TYP'].toString(),
          "GOL": dataInsert['GOL'].toString(),
          "BRAND": dataInsert['BRAND'].toString(),
          "rateks": dataInsert['rateks'],
          "ACNO1": dataInsert['ACNO1'].toString(),
          "ACNO1_NM": dataInsert['ACNO1_NM'].toString(),
        },
      );

      List dataDetail = dataInsert['tabeld'];
      for (int i = 0; i < dataDetail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_btb_barang_lokal"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": dataInsert['NO_BUKTI'].toString(),
            "PER": dataInsert['PER'].toString(),
            "FLAG": dataInsert['FLAG'].toString(),
            "NO_PO": dataDetail[i]['NO_PO'].toString(),
            "QTYPO": dataDetail[i]['QTYPO'].toString(),
            "KD_BRG": dataDetail[i]['KD_BRG'].toString(),
            "NA_BRG": dataDetail[i]['NA_BRG'].toString(),
            "SATUAN": dataDetail[i]['SATUAN'].toString(),
            "QTY": dataDetail[i]['QTY'].toString(),
            "SATUANBL": dataDetail[i]['SATUANBL'].toString(),
            "QTYBL": dataDetail[i]['QTYBL'].toString(),
            "HARGA1": dataDetail[i]['HARGA1'].toString(),
            "TOTAL1": dataDetail[i]['TOTAL1'].toString(),
            "KET": dataDetail[i]['KET'].toString(),
            "HARGA": dataDetail[i]['HARGA'].toString(),
            "TOTAL": dataDetail[i]['TOTAL'].toString(),
            "BLT": dataDetail[i]['BLT'].toString(),
            "DISC": dataDetail[i]['DISC'].toString(),
            "RPDISC": dataDetail[i]['RPDISC'].toString(),
            "TYP": dataDetail[i]['TYP'].toString(),
            "GOL": dataDetail[i]['GOL'].toString(),
            "HTG": dataDetail[i]['HTG'].toString(),
            "SIZ": dataDetail[i]['SIZ'].toString(),
            "KD": dataDetail[i]['KD'].toString(),
            "KODECAB": dataDetail[i]['KODECAB'].toString(),
            "WARNA": dataDetail[i]['WARNA'].toString(),
            "PRODUK": dataDetail[i]['PRODUK'].toString(),
            "GRP": dataDetail[i]['GRP'].toString(),
            "ACNO": dataDetail[i]['ACNO'].toString(),
            "ACNO_NM": dataDetail[i]['ACNO_NM'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///UPDATE BTB BAHAN LOKAL DETAIL
  Future<List> updateBtbBarangLokal(Map dataInsert) async {
    try {
      await http.post(
        Uri.parse("${baseUrl}:3000/hapus_detail"),
        body: {
          "no_bukti": dataInsert['NO_BUKTI'].toString(),
          "kolom": "NO_BUKTI",
          "tabel": "belid"
        },
      );

      ///DATA HEADER
      final response = await http.post(
        Uri.parse("${baseUrl}:3000/edit_header_btb_barang_lokal"),
        body: {
          "NO_BUKTI": dataInsert['NO_BUKTI'].toString(),
          "TGL": dataInsert['TGL'].toString(),
          "JTEMPO": dataInsert['JTEMPO'].toString(),
          "CURR": dataInsert['CURR'].toString(),
          "CURRNM": dataInsert['CURRNM'].toString(),
          "RATE": dataInsert['RATE'].toString(),
          "KODES": dataInsert['KODES'].toString(),
          "NAMAS": dataInsert['NAMAS'].toString(),
          "ALAMAT": dataInsert['ALAMAT'].toString(),
          "KOTA": dataInsert['KOTA'].toString(),
          "NOTES": dataInsert['NOTES'].toString(),
          "TOTAL_QTY": dataInsert['TOTAL_QTY'].toString(),
          "SISA_QTY": dataInsert['SISA_QTY'].toString(),
          "TOTAL1": dataInsert['TOTAL1'].toString(),
          "DISC": dataInsert['DISC'].toString(),
          "PPN": dataInsert['PPN'].toString(),
          "NETT1": dataInsert['NETT1'].toString(),
          "DISC1": dataInsert['DISC1'].toString(),
          "PPN1": dataInsert['PPN1'].toString(),
          "PPH1": dataInsert['PPH1'].toString(),
          "PPH": dataInsert['PPH'].toString(),
          "TOTAL": dataInsert['TOTAL'].toString(),
          "RPDISC": dataInsert['RPDISC'].toString(),
          "RPPPN": dataInsert['RPPPN'].toString(),
          "NETT": dataInsert['NETT'].toString(),
          "SISA": dataInsert['SISA'].toString(),
          "RPDISC1": dataInsert['RPDISC1'].toString(),
          "RPPPN1": dataInsert['RPPPN1'].toString(),
          "RPPPH1": dataInsert['RPPPH1'].toString(),
          "RPPPH": dataInsert['RPPPH'].toString(),
          "USRNM": dataInsert['USRNM'].toString(),
          "TG_SMP": dataInsert['TG_SMP'].toString(),
          "FLAG": dataInsert['FLAG'].toString(),
          "PER": dataInsert['PER'].toString(),
          "TYP": dataInsert['TYP'].toString(),
          "GOL": dataInsert['GOL'].toString(),
          "BRAND": dataInsert['BRAND'].toString(),
          "rateks": dataInsert['rateks'],
          "ACNO1": dataInsert['ACNO1'].toString(),
          "ACNO1_NM": dataInsert['ACNO1_NM'].toString(),
        },
      );

      ///DATA DETAIL
      List dataDetail = dataInsert['tabeld'];
      for (int i = 0; i < dataDetail.length; i++) {
        await http.post(
          Uri.parse("${baseUrl}:3000/tambah_detail_btb_barang_lokal"),
          body: {
            "REC": (i + 1).toString(),
            "NO_BUKTI": dataInsert['NO_BUKTI'].toString(),
            "PER": dataInsert['PER'].toString(),
            "FLAG": dataInsert['FLAG'].toString(),
            "NO_PO": dataDetail[i]['NO_PO'].toString(),
            "QTYPO": dataDetail[i]['QTYPO'].toString(),
            "KD_BRG": dataDetail[i]['KD_BRG'].toString(),
            "NA_BRG": dataDetail[i]['NA_BRG'].toString(),
            "SATUAN": dataDetail[i]['SATUAN'].toString(),
            "QTY": dataDetail[i]['QTY'].toString(),
            "SATUANBL": dataDetail[i]['SATUANBL'].toString(),
            "QTYBL": dataDetail[i]['QTYBL'].toString(),
            "HARGA1": dataDetail[i]['HARGA1'].toString(),
            "TOTAL1": dataDetail[i]['TOTAL1'].toString(),
            "KET": dataDetail[i]['KET'].toString(),
            "HARGA": dataDetail[i]['HARGA'].toString(),
            "TOTAL": dataDetail[i]['TOTAL'].toString(),
            "BLT": dataDetail[i]['BLT'].toString(),
            "DISC": dataDetail[i]['DISC'].toString(),
            "RPDISC": dataDetail[i]['RPDISC'].toString(),
            "TYP": dataDetail[i]['TYP'].toString(),
            "GOL": dataDetail[i]['GOL'].toString(),
            "HTG": dataDetail[i]['HTG'].toString(),
            "SIZ": dataDetail[i]['SIZ'].toString(),
            "KD": dataDetail[i]['KD'].toString(),
            "KODECAB": dataDetail[i]['KODECAB'].toString(),
            "WARNA": dataDetail[i]['WARNA'].toString(),
            "PRODUK": dataDetail[i]['PRODUK'].toString(),
            "GRP": dataDetail[i]['GRP'].toString(),
            "ACNO": dataDetail[i]['ACNO'].toString(),
            "ACNO_NM": dataDetail[i]['ACNO_NM'].toString(),
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> checkNoBukti(
      String kode, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/check_nobukti"),
      body: {"cari": kode, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> getNoBukti(
      String tipe, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/no_urut"),
      body: {"tipe": tipe, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> cariBtbBarangLokal(String cari) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/cari_btb_barang_lokal"),
      body: {"cari": cari},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT HEADER
  Future<List> selectBtbBarangLokal(
      String cari, String startDate, String endDate, String periode) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/tampil_btb_barang_lokal"),
      body: {
        "cari": cari,
        "tglawal": startDate,
        "tglakhir": endDate,
        "periode": periode
      },
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///SELECT DETAIL
  Future<List> selectBtbBarangLokalDetail(
      String noBukti, String paramkolom, String paramtabel) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/select_detail"),
      body: {"cari": noBukti, "kolom": paramkolom, "tabel": paramtabel},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  ///COBA COBA SELECT DETAIL
  Future<List> selectDetail(String noBukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/ambil_btb_detail"),
      body: {"cari": noBukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }

  Future<List> deleteBtbBarangLokal(String noBukti) async {
    final response = await http.post(
      Uri.parse("${baseUrl}:3000/hapus_btb_baranglokal"),
      body: {"no_bukti": noBukti},
    );
    var results2 = json.decode(response.body);
    return results2['data'].toList();
  }
}
