// import 'package:akunt/model/model_barang.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class model_penerimaan {
  static String table = 'beli';
  static String table_detail = 'belid';
  static String flag = 'B3';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<bool> insert_penerimaan(Map data_insert) async {
    try {
      // var konek = await m_koneksi.koneksi();
      // var results1 = await konek.query(
      //     'insert into ' +
      //         table +
      //         ' (NO_BUKTI,NO_PO,TGL,JTEMPO,KODES,NAMAS,alamat,kota,notes,HARI,PER,GOLONGAN,usrnm,total_qty,flag,total,DPP,ppn,tg_smp,CBG) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      //     [
      //       data_insert['no_bukti'],
      //       data_insert['no_sp'],
      //       data_insert['tanggal'],
      //       data_insert['jatuh_tempo'],
      //       data_insert['supplier'],
      //       data_insert['namasupplier'],
      //       "",
      //       "",
      //       data_insert['keterangan'],
      //       data_insert['hari'],
      //       "12/2021",
      //       data_insert['gol'],
      //       LoginController.nama_staff.toString(),
      //       data_insert['qty'],
      //       flag,
      //       data_insert['total'],
      //       data_insert['total'],
      //       data_insert['pajak'],
      //       DateFormat('y-M-d').format(DateTime.now()),
      //       "MTS",
      //     ]);
      // List data_barang = data_insert['barang'];
      // await konek.queryMulti(
      //     'insert into ' +
      //         table_detail +
      //         ' (ID,rec,no_bukti,KD_BRG,NA_BRG,kemasan,qty,qtyk,hargak,harga,total,flag,PER,CBG,KET_UK) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      //     [
      //       for (int i = 0; i < data_barang.length; i++)
      //         [
      //           0,
      //           i + 1,
      //           data_insert['no_bukti'].toString(),
      //           data_barang[i]['kd_brg'].toString(),
      //           data_barang[i]['na_brg'].toString(),
      //           1,
      //           data_barang[i]['qty'],
      //           data_barang[i]['qty'],
      //           data_barang[i]['harga_beli'],
      //           data_barang[i]['harga_beli'],
      //           data_barang[i]['sub_total'],
      //           flag,
      //           "12/2021",
      //           "MTS",
      //           data_barang[i]['satuan'].toString(),
      //         ]
      //     ]);
      // for (int i = 0; i < data_barang.length; i++) {
      //   await konek.query(
      //       "update ${model_barang.table} set stok = stok+${data_barang[i]['qty']} where kd_brg ='${data_barang[i]['kd_brg'].toString()}'");
      // }
      // await konek.close();
      // return results1.toList();

      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/tambahheader"),
        body: {
          "nobukti": data_insert['no_bukti'].toString(),
          "nosp": data_insert['no_sp'].toString(),
          "tgl": data_insert['tanggal'].toString(),
          "jtempo": data_insert['jatuh_tempo'].toString(),
          "kodes": data_insert['supplier'].toString(),
          "namas": data_insert['namasupplier'].toString(),
          "notes": data_insert['keterangan'].toString(),
          "hari": data_insert['hari'].toString() ?? 0,
          "gol": data_insert['gol'].toString(),
          "user": LoginController.nama_staff.toString(),
          "qty": data_insert['qty'].toString(),
          "flag": flag.toString(),
          "total": data_insert['total'].toString(),
          "pajak": data_insert['pajak'].toString(),
          "cbg": "MTS",
        },
      );
      print(data_insert);

      List data_barang = data_insert['barang'];
      for (int i = 0; i < data_barang.length; i++) {
        await http.post(
          Uri.parse(
              "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/tambahdetail"),
          body: {
            "nobukti": data_insert['no_bukti'].toString(),
            "rec": (i + 1).toString(),
            "kdbrg": data_barang[i]['kd_brg'].toString(),
            "nabrg": data_barang[i]['na_brg'].toString(),
            "qty": data_barang[i]['qty'].toString(),
            "hb": data_barang[i]['harga_beli'].toString(),
            "total": data_barang[i]['sub_total'].toString(),
            "ketuk": data_barang[i]['satuan'].toString(),
            "flag": flag.toString(),
            "cbg": "MTS",
          },
        );
      }
      if (response.statusCode >= 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> update_penerimaan(Map data_insert) async {
    try {
      // var konek = await m_koneksi.koneksi();
      // await konek.query(
      //     "delete from $table_detail where no_bukti ='${data_insert['no_bukti']}' ;");
      // var results1 = await konek
      //     .query("update $table set NO_PO = '${data_insert['no_sp']}', "
      //             "TGL = '${data_insert['tanggal']}', " +
      //         "KODES = '${data_insert['supplier']}', " +
      //         "NAMAS = '${data_insert['namasupplier']}', " +
      //         "GOLONGAN = '${data_insert['gol']}', " +
      //         "HARI = '${data_insert['hari']}', " +
      //         "JTEMPO = '${data_insert['jatuh_tempo']}', " +
      //         "total_qty = '${data_insert['qty']}', " +
      //         "total = '${data_insert['total']}', " +
      //         "ppn = '${data_insert['pajak']}', " +
      //         "notes = '${data_insert['keterangan']}', " +
      //         "tg_smp=NOW() "
      //             "where NO_BUKTI ='${data_insert['no_bukti']}';");
      // List data_barang = data_insert['barang'];
      // await konek.queryMulti(
      //     'insert into ' +
      //         table_detail +
      //         ' (ID,rec,no_bukti,KD_BRG,NA_BRG,kemasan,qty,qtyk,hargak,harga,total,flag,PER,CBG,KET_UK) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      //     [
      //       for (int i = 0; i < data_barang.length; i++)
      //         [
      //           0,
      //           i + 1,
      //           data_insert['no_bukti'].toString(),
      //           data_barang[i]['kd_brg'].toString(),
      //           data_barang[i]['na_brg'].toString(),
      //           1,
      //           data_barang[i]['qty'],
      //           data_barang[i]['qty'],
      //           data_barang[i]['harga_beli'],
      //           data_barang[i]['harga_beli'],
      //           data_barang[i]['sub_total'],
      //           flag,
      //           "12/2021",
      //           "MTS",
      //           data_barang[i]['satuan'].toString(),
      //         ]
      //     ]);
      // await konek.close();
      // return results1.toList();
      await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/hapusdetail"),
        body: {"no_bukti": data_insert['no_bukti'].toString()},
      );

      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/ubahheader"),
        body: {
          "nobukti": data_insert['no_bukti'].toString(),
          "nosp": data_insert['no_sp'].toString(),
          "tgl": data_insert['tanggal'].toString(),
          "jtempo": data_insert['jatuh_tempo'].toString(),
          "kodes": data_insert['supplier'].toString(),
          "namas": data_insert['namasupplier'].toString(),
          "notes": data_insert['keterangan'].toString(),
          "hari": data_insert['hari'].toString(),
          "gol": data_insert['gol'].toString(),
          "user": LoginController.nama_staff.toString(),
          "qty": data_insert['qty'].toString(),
          "flag": flag.toString(),
          "total": data_insert['total'].toString(),
          "pajak": data_insert['pajak'].toString(),
          "cbg": "MTS",
        },
      );

      List data_barang = data_insert['barang'];
      for (int i = 0; i < data_barang.length; i++) {
        await http.post(
          Uri.parse(
              "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/tambahdetail"),
          body: {
            "nobukti": data_insert['no_bukti'].toString(),
            "rec": (i + 1).toString(),
            "kdbrg": data_barang[i]['kd_brg'].toString(),
            "nabrg": data_barang[i]['na_brg'].toString(),
            "qty": data_barang[i]['qty'].toString(),
            "hb": data_barang[i]['harga_beli'].toString(),
            "total": data_barang[i]['sub_total'].toString(),
            "ketuk": data_barang[i]['satuan'].toString(),
            "flag": flag.toString(),
            "cbg": "MTS",
          },
        );
      }
      if (response.statusCode >= 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countPenerimaan(String date) async {
    // var konek = await m_koneksi.koneksi();
    // var result = await konek
    //     .query("SELECT NO_BUKTI FROM $table where TGL like '$date%';");
    // await konek.close();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/countpenerimaan"),
      body: {"tgl": date},
    );
    var result = json.decode(response.body);
    return result.toList();
  }

  Future countDataTerima(
      String cari, String start_date, String end_date, String supplier) async {
    /*
    var konek = await m_koneksi.koneksi();
    start_date = start_date.replaceAll('/', '-');
    end_date = end_date.replaceAll('/', '-');
    if (end_date != "") {
      if (supplier != "") {
        var results2 = await konek.query(
            "SELECT COUNT(*) from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and supplier = '$supplier' and tanggal between '$start_date' and '$end_date';");
        await konek.close();
        return results2.toList();
      } else {
        var results2 = await konek.query(
            "SELECT COUNT(*) from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and tanggal between '$start_date' and '$end_date';");
        await konek.close();
        return results2.toList();
      }
    } else {
      if (supplier != "") {
        var results2 = await konek.query(
            "SELECT COUNT(*) from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and supplier = '$supplier' and tanggal like '%$start_date%';");
        await konek.close();
        return results2.toList();
      } else {
        var results2 = await konek.query(
            "SELECT COUNT(*) from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and tanggal like '%$start_date%';");
        await konek.close();
        return results2.toList();
      }
    }
    */
    start_date = start_date.replaceAll('/', '-');
    end_date = end_date.replaceAll('/', '-');
    String filter_extra = "";
    if (supplier.isNotEmpty) {
      filter_extra += " and KODES = '$supplier' ";
    }
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/countdataterima"),
      body: {
        "cari": cari,
        "filterextra": filter_extra,
        "supplier": supplier,
        "start_date": start_date,
        "end_date": end_date
      },
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<Map> sumPenerimaanPerbulan() async {
    var konek = await m_koneksi.koneksi();
    var result = await konek.query(
        "SELECT MONTH(TGL) AS bulan, SUM(total) AS pengeluaran FROM $table GROUP BY YEAR(TGL), MONTH(TGL)");
    Map data = new Map();
    for (var row in result) {
      print('bulan: ${row[0]}, total: ${row[1]}');
      data[row[0]] = row[1];
    }
    await konek.close();
    return data;
  }

  Future<List> get_no_bukti(String kode) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 =
    //     await konek.query("select * from $table where NO_BUKTI = '$kode';");
    // await konek.close();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/getnobukti"),
      body: {"kode": kode},
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<List> select_penerimaan(String cari, String start_date,
      String end_date, String supplier, int offset, int limit) async {
    // var konek = await m_koneksi.koneksi();
    // if (supplier != "") {
    //   var results2 = await konek.query(
    //       "select * from $table where (NO_BUKTI like '%$cari%' or KODES like '%$cari%' or NO_PO like '%$cari%') and KODES ='$supplier' and TGL between '$start_date' and '$end_date';");
    //   await konek.close();
    //   return results2.toList();
    // } else {
    //   var results2 = await konek.query(
    //       "select * from $table where (NO_BUKTI like '%$cari%' or KODES like '%$cari%' or NO_PO like '%$cari%') and TGL between '$start_date' and '$end_date';");
    //   await konek.close();
    // }
    start_date = start_date.replaceAll('/', '-');
    end_date = end_date.replaceAll('/', '-');
    String filter_extra = "";
    if (supplier.isNotEmpty) {
      filter_extra += " and KODES = '$supplier' ";
    }
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/selectpenerimaan"),
      body: {
        "cari": cari,
        "filterextra": filter_extra,
        "supplier": supplier,
        "start_date": start_date,
        "end_date": end_date,
        "offset_limit": offset.toString(),
        "batas_limit": limit.toString()
      },
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<List> select_penerimaan_detail(String no_bukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek
    //     .query("select * from $table_detail where NO_BUKTI = '$no_bukti';");
    // await konek.close();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/selectpenerimaandetail"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<bool> delete_penerimaan(String no_bukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results1 =
    //     await konek.query("delete from $table where NO_BUKTI = '$no_bukti';");
    // var results2 = await konek
    //     .query("delete from $table_detail where NO_BUKTI = '$no_bukti';");
    // await konek.close();
    // return results2.toList();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/penerimaan.php/hapuspenerimaan"),
      body: {"no_bukti": no_bukti},
    );
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }
}
