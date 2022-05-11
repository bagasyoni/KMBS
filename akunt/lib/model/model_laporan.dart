import 'package:akunt/mysql/koneksi_mysql.dart';

class model_laporan {
  static String table = 'order_penjualan';
  static String table_detail = 'detail_barang_order_penjualan';
  koneksi_mysql m_koneksi = koneksi_mysql();

  Future<List> select_order_penjualan(
      String cari, String start_date, String end_date, String customer) async {
    var konek = await m_koneksi.koneksi();
    if (customer != "") {
      var results2 = await konek.query(
          "select * from $table where (no_bukti like '%$cari%' or customer like '%$cari%') and customer = '$customer' and tanggal between '$start_date' and '$end_date';");
      await konek.close();
      return results2.toList();
    } else {
      var results2 = await konek.query(
          "select * from $table where (no_bukti like '%$cari%' or customer like '%$cari%') and tanggal between '$start_date' and '$end_date';");
      await konek.close();
      return results2.toList();
    }
  }

  Future<List> select_order_penjualan_aktif(String cari, String sales,
      String customer, String start_date, String end_date) async {
    var konek = await m_koneksi.koneksi();
    String filter_extra = "";
    if (sales.isNotEmpty) {
      filter_extra = " and sales = '$sales' ";
    }
    if (customer.isNotEmpty) {
      filter_extra += " and customer = '$customer' ";
    }
    var results2 = await konek.query(
        "select * from $table where (no_bukti like '%$cari%' or customer like '%$cari%' or sales like '%$cari%') $filter_extra and status = '0' and tanggal between '$start_date' and '$end_date';");
    await konek.close();
    return results2.toList();
  }

  Future<List> select_order_penjualan_detail(String no_bukti) async {
    var konek = await m_koneksi.koneksi();
    var results2 = await konek
        .query("select * from $table_detail where no_bukti = '$no_bukti';");
    await konek.close();
    return results2.toList();
  }
}
