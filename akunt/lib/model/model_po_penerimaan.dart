import 'package:akunt/mysql/koneksi_mysql.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class model_po_penerimaan {
  static String table = 'po';
  static String table_detail = 'pod';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<List> delete_order_penjualan(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results1 =
        await konek.query("delete from $table where no_bukti = '$no_bukti';");
    var results2 = await konek
        .query("delete from $table_detail where no_bukti = '$no_bukti';");
    await konek.close();
    return results2.toList();
  }

  Future<List> insert_po_penerimaan(Map data_insert) async {
    try {
      print(data_insert['barang']);
      var konek = await m_koneksi.koneksi();
      var results1 = await konek.query(
          'insert into ' +
              table +
              ' (id,no_bukti,sales,supplier,tanggal,keterangan,total_qty,total_used,total_po,status) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            0,
            data_insert['no_bukti'],
            data_insert['sales'],
            data_insert['supplier'],
            data_insert['tanggal'],
            data_insert['keterangan'],
            data_insert['total_qty'],
            data_insert['total_used'],
            data_insert['total_po'],
            data_insert['status'],
          ]);
      List data_barang = data_insert['barang'];
      await konek.queryMulti(
          'insert into ' +
              table_detail +
              ' (id,no_bukti,kd_brg,na_brg,satuan,qty,harga_po,sub_total) values (?, ?, ?, ?, ?, ?, ?, ?)',
          [
            for (int i = 0; i < data_barang.length; i++)
              [
                0,
                data_insert['no_bukti'].toString(),
                data_barang[i]['kd_brg'].toString(),
                data_barang[i]['na_brg'].toString(),
                data_barang[i]['satuan'].toString(),
                data_barang[i]['qty'],
                data_barang[i]['harga_po'],
                data_barang[i]['sub_total']
              ]
          ]);
      await konek.close();
      return results1.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> update_po_penerimaan(Map data_insert) async {
    try {
      var konek = await m_koneksi.koneksi();
      await konek.query(
          "delete from $table_detail where no_bukti ='${data_insert['no_bukti']}' ;");
      var results1 = await konek
          .query("update $table set sales = '${data_insert['sales']}', "
                  "supplier = '${data_insert['supplier']}', " +
              "tanggal = '${data_insert['tanggal']}', " +
              "keterangan = '${data_insert['keterangan']}', " +
              "total_used = '${data_insert['total_used']}', " +
              "total_po = '${data_insert['total_po']}', " +
              "status = '${data_insert['status']}' " +
              "where no_bukti ='${data_insert['no_bukti']}';");
      List data_barang = data_insert['barang'];
      await konek.queryMulti(
          'insert into ' +
              table_detail +
              ' (id,no_bukti,kd_brg,na_brg,satuan,qty,harga_po,sub_total) values (?, ?, ?, ?, ?, ?, ?, ?)',
          [
            for (int i = 0; i < data_barang.length; i++)
              [
                0,
                data_insert['no_bukti'].toString(),
                data_barang[i]['kd_brg'].toString(),
                data_barang[i]['na_brg'].toString(),
                data_barang[i]['satuan'].toString(),
                data_barang[i]['qty'],
                data_barang[i]['harga_po'],
                data_barang[i]['sub_total']
              ]
          ]);
      await konek.close();
      return results1.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> countOrderPembelian(String date) async {
    var konek = await m_koneksi.koneksi();
    var result = await konek
        .query("SELECT no_bukti FROM $table where tanggal like '$date%';");
    await konek.close();
    return result.toList();
  }

  Future<List> get_no_bukti(String kode) async {
    var konek = await m_koneksi.koneksi();
    var results2 =
        await konek.query("select * from $table where no_bukti = '$kode';");
    await konek.close();
    return results2.toList();
  }

  Future<List> select_po_penerimaan(
      String cari, String start_date, String end_date, String supplier) async {
    // var konek = await m_koneksi.koneksi();
    if (supplier != "") {
      // var results2 = await konek.query(
      //     "select * from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and supplier = '$supplier' and tanggal between '$start_date' and '$end_date';");
      // await konek.close();
      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/flutterjualbeli/po_terima.php/selectpoterimasupp"),
        body: {
          "cari": cari,
          "supplier": supplier,
          "start_date": start_date,
          "end_date": end_date
        },
      );
      var results2 = json.decode(response.body);
      return results2.toList();
    } else {
      // var results2 = await konek.query(
      //     "select * from $table where (no_bukti like '%$cari%' or supplier like '%$cari%') and tanggal between '$start_date' and '$end_date';");
      // await konek.close();
      final response = await http.post(
        Uri.parse(
            "https://edompetiaragatzuonline.com/flutterjualbeli/po_terima.php/selectpoterimanosupp"),
        body: {
          "cari": cari,
          "supplier": supplier,
          "start_date": start_date,
          "end_date": end_date
        },
      );
      var results2 = json.decode(response.body);
      return results2.toList();
    }
  }

  Future<List> select_po_penerimaan_aktif(String cari, String sales,
      String supplier, String start_date, String end_date) async {
    // var konek = await m_koneksi.koneksi();
    // String filter_extra = "";
    // if (sales.isNotEmpty) {
    //   filter_extra = " and sales = '$sales' ";
    // }
    // if (supplier.isNotEmpty) {
    //   filter_extra += " and KODES = '$supplier' ";
    // }
    // var results2 = await konek.query(
    //     "select *, (SELECT NAMAS from sup where KODES=$table.KODES and TYPE=$table.GOLONGAN) as GOL, (SELECT GOLONGAN from sup where KODES=$table.KODES and TYPE=$table.GOLONGAN) as GOL, (SELECT KLB2 from sup where KODES=$table.KODES and TYPE=$table.GOLONGAN) as KLB2 from $table where (NO_BUKTI like '%$cari%' or KODES like '%$cari%') $filter_extra and TGL between '$start_date' and '$end_date';");
    // await konek.close();
    String filter_extra = "";
    if (supplier.isNotEmpty) {
      filter_extra += " and KODES = '$supplier' ";
    }
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/po_terima.php/selectpoterimaaktif"),
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

  Future<List> select_po_penerimaan_detail(String no_bukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results2 = await konek
    //     .query("select * from $table_detail where NO_BUKTI = '$no_bukti';");
    // await konek.close();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/po_terima.php/selectpoterimadetail"),
      body: {"no_bukti": no_bukti},
    );
    var results2 = json.decode(response.body);
    return results2.toList();
  }

  Future<bool> update_total_used(String no_bukti) async {
    // var konek = await m_koneksi.koneksi();
    // var results = await konek.query(
    //     "update $table set total_used = total_used + 1 where no_bukti = '$no_bukti';");
    // await konek.close();
    // return results.toList();
    final response = await http.post(
      Uri.parse(
          "https://edompetiaragatzuonline.com/flutterjualbeli/po_terima.php/updatetotalused"),
      body: {"no_bukti": no_bukti},
    );
    if (response.statusCode >= 200) {
      return true;
    }
    return false;
  }
}
