import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akunt/config/OnHoverButton.dart';
import 'package:akunt/config/color.dart';
import 'package:akunt/config/config.dart';
import 'package:akunt/view/base_widget/toast.dart';
import 'package:akunt/controller/home_controller.dart';
import 'package:akunt/controller/login_controller.dart';

import 'package:akunt/controller/pobahanlokal_controller.dart';
import 'package:akunt/controller/so_controller.dart';
import 'package:akunt/controller/belibahan_controller.dart';
import 'package:akunt/controller/jual_controller.dart';

///MASTER FINANSIAL///
import 'package:akunt/view/master/finansial/account/data_account_screen.dart';


///MASTER OPERASIONAL///
import 'package:akunt/view/master/operasional/customer/data_customer_screen.dart';
import 'package:akunt/view/master/operasional/supplier/data_supplier_screen.dart';
import 'package:akunt/view/master/operasional/bahan/data_bahan_screen.dart';
import 'package:akunt/view/master/operasional/brg/data_brg_screen.dart';
import 'package:akunt/view/master/operasional/currency/data_currency_screen.dart';
import 'package:akunt/view/master/operasional/toko/data_toko_screen.dart';
import 'package:akunt/view/master/operasional/user/data_user_screen.dart';
import 'package:akunt/view/master/operasional/hs/data_hs_screen.dart';

///TRANSAKSI///
import 'package:akunt/view/po_bahan_lokal/pobahanlokal_screen.dart';
import 'package:akunt/view/po_bahan_import/pobahanimport_screen.dart';
import 'package:akunt/view/po_barang_lokal/pobaranglokal_screen.dart';
import 'package:akunt/view/po_barang_import/pobarangimport_screen.dart';
import 'package:akunt/view/po_nonbahan/pononbahan_screen.dart';
import 'package:akunt/view/po_import/poimport_screen.dart';
import 'package:akunt/view/po_mesin/pomesin_screen.dart';
import 'package:akunt/view/po_sparepart/posparepart_screen.dart';
import 'package:akunt/view/beli_bahan/belibahan_screen.dart';
import 'package:akunt/view/beli_nonbahan/belinonbahan_screen.dart';
import 'package:akunt/view/beli_import/beliimport_screen.dart';
import 'package:akunt/view/beli_mesin/belimesin_screen.dart';
import 'package:akunt/view/beli_sparepart/belisparepart_screen.dart';
import 'package:akunt/view/thut_bahan/thutbahan_screen.dart';
import 'package:akunt/view/thut_nonbahan/thutnonbahan_screen.dart';
import 'package:akunt/view/thut_import/thutimport_screen.dart';
import 'package:akunt/view/thut_mesin/thutmesin_screen.dart';
import 'package:akunt/view/thut_sparepart/thutsparepart_screen.dart';
import 'package:akunt/view/hut_bahan/hutbahan_screen.dart';
import 'package:akunt/view/stockbhn/stockbhn_screen.dart';
import 'package:akunt/view/mutasibrg/mutasibrg_screen.dart';
import 'package:akunt/view/pakaibhn/pakaibhn_screen.dart';
import 'package:akunt/view/terima/terima_screen.dart';
import 'package:akunt/view/so/so_screen.dart';
import 'package:akunt/view/surat/surat_screen.dart';
import 'package:akunt/view/jual/jual_screen.dart';
import 'package:akunt/view/tpiu/tpiu_screen.dart';
import 'package:akunt/view/piu/piu_screen.dart';

///LAPORAN///
import 'package:akunt/view/lap_pobahan/lap_pobahan_screen.dart';
import 'package:akunt/view/lap_belibahan/lap_belibahan_screen.dart';
import 'package:akunt/view/lap_thutbahan/lap_thutbahan_screen.dart';
import 'package:akunt/view/lap_hutbahan/lap_hutbahan_screen.dart';
import 'package:akunt/view/lap_so/lap_so_screen.dart';
import 'package:akunt/view/lap_sj/lap_sj_screen.dart';
import 'package:akunt/view/lap_jual/lap_jual_screen.dart';
import 'package:akunt/view/lap_kas/lap_kas_screen.dart';
import 'package:akunt/view/lap_bank/lap_bank_screen.dart';
import 'package:akunt/view/lap_memo/lap_memo_screen.dart';
import 'package:akunt/view/lap_stocka/lap_stocka_screen.dart';
import 'package:akunt/view/lap_stockb/lap_stockb_screen.dart';
import 'package:akunt/view/lap_pakai/lap_pakai_screen.dart';
import 'package:akunt/view/lap_terima/lap_terima_screen.dart';

import 'package:akunt/view/lap_perincianstk_bhn/lap_perincianstk_bhn_screen.dart';
import 'package:akunt/view/lap_perincianstk_brg/lap_perincianstk_brg_screen.dart';
import 'package:akunt/view/lap_perincian_hut/lap_perincian_hut_screen.dart';
import 'package:akunt/view/lap_perincian_piu/lap_perincian_piu_screen.dart';
import 'package:akunt/view/lap_perincian_nera/lap_perincian_nera_screen.dart';
import 'package:akunt/view/lap_nera/lap_nera_screen.dart';
import 'package:akunt/view/lap_rl/lap_rl_screen.dart';

import 'package:akunt/view/lap_kartustk_bhn/lap_kartustk_bhn_screen.dart';
import 'package:akunt/view/lap_kartustk_brg/lap_kartustk_brg_screen.dart';
import 'package:akunt/view/lap_kartu_hut/lap_kartu_hut_screen.dart';
import 'package:akunt/view/lap_kartu_piu/lap_kartu_piu_screen.dart';
import 'package:akunt/view/lap_buku_besar/lap_buku_besar_screen.dart';

import 'package:akunt/view/login/login_screen.dart';

import 'package:akunt/view/kasmasuk/kasmasuk_screen.dart';
import 'package:akunt/view/kaskeluar/kaskeluar_screen.dart';
import 'package:akunt/view/bankmasuk/bankmasuk_screen.dart';
import 'package:akunt/view/bankkeluar/bankkeluar_screen.dart';
import 'package:akunt/view/memo/memo_screen.dart';

import 'package:akunt/view/po/data_po_screen.dart';
import 'package:akunt/view/pon/data_pon_screen.dart';
import 'package:akunt/view/beli/data_beli_screen.dart';

import 'package:akunt/view/lap_sp/index_lapsp_screen.dart';
import 'package:akunt/view/lap_pon/lappon_screen.dart';

import 'package:akunt/view/home/bar_chart.dart';
import 'package:akunt/view/home/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:akunt/view/home/periode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false).baca_periodePrefs();
  }

  @override
  Widget build(BuildContext context) {
    var scafoldKey = GlobalKey<ScaffoldState>();
    return Consumer<HomeController>(builder: (context, homeController, child) {
      return Scaffold(
        key: scafoldKey,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                onTap: () =>
                    // homeController.baca_allData(0);
                    scafoldKey.currentState.openDrawer(),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    "assets/images/ic_home.png",
                    height: 30,
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                config.nama_perusahaan,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(children: [
                      Image.asset(
                        "assets/images/ic_tanggal.png",
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Periode : " + HomeController.perx.toString(),
                        style: GoogleFonts.poppins(
                            wordSpacing: 5,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: PopupMenuButton(
                      offset: const Offset(65, 55),
                      color: Colors.white,
                      tooltip: "Operasional",
                      child: Container(
                        width: 160,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_ongkir.png",
                              height: 30,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Operasional",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      elevation: 2,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Master",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_staff.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Master"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Bahan"),
                                      ],
                                    ),
                                    value: 101,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Supplier"),
                                      ],
                                    ),
                                    value: 102,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Barang"),
                                      ],
                                    ),
                                    value: 103,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Customer"),
                                      ],
                                    ),
                                    value: 104,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Currency"),
                                      ],
                                    ),
                                    value: 105,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Toko"),
                                      ],
                                    ),
                                    value: 106,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("User"),
                                      ],
                                    ),
                                    value: 107,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("HS"),
                                      ],
                                    ),
                                    value: 108,
                                  ),
                                ];
                              },
                              onSelected: (value) async {
                                if (value == 101) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataBahanScreen()));
                                } else if (value == 102) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataSupplierScreen()));
                                } else if (value == 103) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataBrgScreen()));
                                } else if (value == 104) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataCustomerScreen()));
                                } else if (value == 105) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataCurrencyScreen()));
                                } else if (value == 106) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataTokoScreen()));
                                } else if (value == 107) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataUserScreen()));
                                } else if (value == 108) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DataHsScreen()));
                                }
                              },
                            ),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Transaksi",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_pembelian.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Transaksi"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: PopupMenuButton(
                                      offset: const Offset(0, 50),
                                      color: Colors.white,
                                      tooltip: "Pembelian",
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_penjualan.png",
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 16,
                                              height: 50,
                                            ),
                                            Text("Pembelian"),
                                          ],
                                        ),
                                      ),
                                      elevation: 5,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("PO Bahan Lokal"),
                                              ],
                                            ),
                                            value: 201,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("PO Bahan Import"),
                                              ],
                                            ),
                                            value: 202,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("PO Barang Lokal"),
                                              ],
                                            ),
                                            value: 203,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("PO Barang Import"),
                                              ],
                                            ),
                                            value: 204,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Transaksi Pembelian"),
                                              ],
                                            ),
                                            value: 205,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Transaksi Hutang"),
                                              ],
                                            ),
                                            value: 206,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Pembayaran Hutang"),
                                              ],
                                            ),
                                            value: 207,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Koreksi Stok Bahan"),
                                              ],
                                            ),
                                            value: 208,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Pemakaian Bahan"),
                                              ],
                                            ),
                                            value: 209,
                                          ),
                                        ];
                                      },
                                      onSelected: (value) async {
                                        if (value == 201) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataPobahanlokalScreen()));
                                        } else if (value == 202) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataPobahanimportScreen()));
                                        } else if (value == 203) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataPobaranglokalScreen()));
                                        } else if (value == 204) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataPobarangimportScreen()));
                                        } else if (value == 205) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataBelibahanScreen()));
                                        } else if (value == 206) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataThutbahanScreen()));
                                        } else if (value == 207) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataHutbahanScreen()));
                                        } else if (value == 208) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      StockbhnScreen()));
                                        } else if (value == 209) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      PakaibhnScreen()));
                                        }
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: PopupMenuButton(
                                      offset: const Offset(0, 50),
                                      color: Colors.white,
                                      tooltip: "Penjualan",
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_penjualan.png",
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 16,
                                              height: 50,
                                            ),
                                            Text("Penjualan"),
                                          ],
                                        ),
                                      ),
                                      elevation: 5,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Sales Order"),
                                              ],
                                            ),
                                            value: 201,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Surat Jalan"),
                                              ],
                                            ),
                                            value: 202,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Transaksi Penjualan"),
                                              ],
                                            ),
                                            value: 203,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Transaksi Piutang"),
                                              ],
                                            ),
                                            value: 204,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Pembayaran Hutang"),
                                              ],
                                            ),
                                            value: 205,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Koreksi Stok Barang"),
                                              ],
                                            ),
                                            value: 206,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Penerimaan Barang"),
                                              ],
                                            ),
                                            value: 207,
                                          ),
                                        ];
                                      },
                                      onSelected: (value) async {
                                        if (value == 201) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataSoScreen()));
                                        } else if (value == 202) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataSuratScreen()));
                                        } else if (value == 203) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataJualScreen()));
                                        } else if (value == 204) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataTpiuScreen()));
                                        } else if (value == 205) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DataPiuScreen()));
                                        } else if (value == 206) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      MutasibrgScreen()));
                                        } else if (value == 207) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      TerimabhnScreen()));
                                        }
                                      },
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Laporan",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_print.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Laporan"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: PopupMenuButton(
                                      offset: const Offset(0, 50),
                                      color: Colors.white,
                                      tooltip: "Pembelian",
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_po.png",
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 16,
                                              height: 50,
                                            ),
                                            Text("Pembelian"),
                                          ],
                                        ),
                                      ),
                                      elevation: 5,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Purchase Order"),
                                              ],
                                            ),
                                            value: 201,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Transaksi Pembelian"),
                                              ],
                                            ),
                                            value: 202,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Transaksi Hutang"),
                                              ],
                                            ),
                                            value: 203,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Pembayaran Hutang"),
                                              ],
                                            ),
                                            value: 204,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Koreksi Stok Bahan"),
                                              ],
                                            ),
                                            value: 205,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Pemakaian Bahan"),
                                              ],
                                            ),
                                            value: 206,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Kartu Hutang"),
                                              ],
                                            ),
                                            value: 207,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Perincian Hutang"),
                                              ],
                                            ),
                                            value: 208,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Kartu Stok Bahan"),
                                              ],
                                            ),
                                            value: 209,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Perincian Stok Bahan"),
                                              ],
                                            ),
                                            value: 210,
                                          ),
                                        ];
                                      },
                                      onSelected: (value) async {
                                        if (value == 201) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPobahanScreen()));
                                        } else if (value == 202) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapBelibahanScreen()));
                                        } else if (value == 203) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapThutbahanScreen()));
                                        } else if (value == 204) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapHutbahanScreen()));
                                        } else if (value == 205) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapStockaScreen()));
                                        } else if (value == 206) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPakaiScreen()));
                                        } else if (value == 207) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapKartuhutScreen()));
                                        } else if (value == 208) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPerincianhutScreen()));
                                        } else if (value == 209) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapKartustkbhnScreen()));
                                        } else if (value == 210) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPerincianstkbhnScreen()));
                                        }
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    child: PopupMenuButton(
                                      offset: const Offset(0, 50),
                                      color: Colors.white,
                                      tooltip: "Penjualan",
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_po.png",
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 16,
                                              height: 50,
                                            ),
                                            Text("Penjualan"),
                                          ],
                                        ),
                                      ),
                                      elevation: 5,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Sales Order"),
                                              ],
                                            ),
                                            value: 201,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Surat Jalan"),
                                              ],
                                            ),
                                            value: 202,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Transaksi Penjualan"),
                                              ],
                                            ),
                                            value: 203,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Transaksi Piutang Blm"),
                                              ],
                                            ),
                                            value: 204,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Pembayaran Hutang Blm"),
                                              ],
                                            ),
                                            value: 205,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Koreksi Stok Barang"),
                                              ],
                                            ),
                                            value: 206,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Penerimaan Barang"),
                                              ],
                                            ),
                                            value: 207,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Kartu Piutang"),
                                              ],
                                            ),
                                            value: 208,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Perincian Piutang"),
                                              ],
                                            ),
                                            value: 209,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("Lap. Kartu Stok Barang"),
                                              ],
                                            ),
                                            value: 210,
                                          ),
                                          PopupMenuItem(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_list.png",
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                    "Lap. Perincian Stok Barang"),
                                              ],
                                            ),
                                            value: 211,
                                          ),
                                        ];
                                      },
                                      onSelected: (value) async {
                                        if (value == 201) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapSoScreen()));
                                        } else if (value == 202) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapSjScreen()));
                                        } else if (value == 203) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapJualScreen()));
                                        } else if (value == 204) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapThutbahanScreen()));
                                        } else if (value == 205) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapHutbahanScreen()));
                                        } else if (value == 206) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapStockbScreen()));
                                        } else if (value == 207) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapTerimaScreen()));
                                        } else if (value == 208) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapKartupiuScreen()));
                                        } else if (value == 209) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPerincianpiuScreen()));
                                        } else if (value == 210) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapKartustkbrgScreen()));
                                        } else if (value == 211) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      LapPerincianstkbrgScreen()));
                                        }
                                      },
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: PopupMenuButton(
                      offset: const Offset(65, 55),
                      color: Colors.white,
                      tooltip: "Finansial",
                      child: Container(
                        width: 160,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_po.png",
                              height: 30,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Finansial",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      elevation: 2,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Master",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_staff.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Master"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_user_warna.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Account"),
                                      ],
                                    ),
                                    value: 101,
                                  ),
                                ];
                              },
                              onSelected: (value) async {
                                if (value == 101) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DataAccountScreen()));
                                  // } else if (value == 102) {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (_) =>
                                  //               DataSupplierScreen()));

                                }
                              },
                            ),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Transaksi",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_pembelian.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Transaksi"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Jurnal Kas Masuk"),
                                      ],
                                    ),
                                    value: 101,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Jurnal Kas Keluar"),
                                      ],
                                    ),
                                    value: 102,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Jurnal Bank Masuk"),
                                      ],
                                    ),
                                    value: 103,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Jurnal Bank Keluar"),
                                      ],
                                    ),
                                    value: 104,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Jurnal Memorial"),
                                      ],
                                    ),
                                    value: 105,
                                  ),
                                ];
                              },
                              onSelected: (value) async {
                                if (value == 101) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => KasMasukScreen()));
                                } else if (value == 102) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => KasKeluarScreen()));
                                } else if (value == 103) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BankMasukScreen()));
                                } else if (value == 104) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BankKeluarScreen()));
                                } else if (value == 105) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MemoScreen()));
                                }
                              },
                            ),
                          ),
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: PopupMenuButton(
                              offset: const Offset(0, 50),
                              color: Colors.white,
                              tooltip: "Laporan",
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ic_print.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 16,
                                      height: 50,
                                    ),
                                    Text("Laporan"),
                                  ],
                                ),
                              ),
                              elevation: 5,
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Lap. Laba Rugi"),
                                      ],
                                    ),
                                    value: 101,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Lap. Neraca Percobaan"),
                                      ],
                                    ),
                                    value: 102,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Lap. Buku Besar (BELUM)"),
                                      ],
                                    ),
                                    value: 103,
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_po.png",
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text("Lap. Perincian Neraca"),
                                      ],
                                    ),
                                    value: 104,
                                  ),
                                ];
                              },
                              onSelected: (value) async {
                                if (value == 101) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LapRlScreen()));
                                } else if (value == 102) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LapNeraScreen()));
                                } else if (value == 103) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              LapBukubesarScreen()));
                                } else if (value == 104) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              LapPerincianneraScreen()));
                                }
                              },
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: AssetImage("assets/images/ic_user_warna.png"),
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    LoginController.akun_staff.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: HijauColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: PopupMenuButton(
                tooltip: "Option Menu",
                elevation: 1,
                icon: Image(
                  image: AssetImage("assets/images/ic_setting.png"),
                  height: 30,
                ),
                iconSize: 30,
                itemBuilder: (context) {
                  return [
                    if (Provider.of<LoginController>(context, listen: false)
                            .role_staff !=
                        1)
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ic_staff.png",
                              height: 20,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text("Profil"),
                          ],
                        ),
                        value: 7,
                      ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_tanggal.png",
                            height: 20,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text("Periode"),
                        ],
                      ),
                      value: 6,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_logout.png",
                            height: 20,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text("Logout"),
                        ],
                      ),
                      value: 7,
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 6) {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => SettingPeriode()));
                    Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SettingPeriode()))
                        .then((value) {
                      setState(() {
                        Provider.of<HomeController>(context, listen: false)
                            .baca_periodePrefs();
                      });
                    });
                  } else if (value == 7) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  }
                },
              ),
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                menu_utama(),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    // Expanded(
                    //   flex: 6,
                    //   child: BarChartWidget(),
                    // ),
                    Expanded(
                      child: PieChartWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // drawer: Drawer(
        //     child: ListView(
        //   children: <Widget>[
        //     UserAccountsDrawerHeader(
        //       accountName: Text(
        //           Provider.of<LoginController>(context, listen: false)
        //               .nama_staff),
        //       accountEmail: Text(
        //           Provider.of<LoginController>(context, listen: false)
        //               .email_staff),
        //       currentAccountPicture: CircleAvatar(
        //         backgroundColor:
        //             Theme.of(context).platform == TargetPlatform.android
        //                 ? Colors.white
        //                 : Colors.blue,
        //         child: Text(
        //           Provider.of<LoginController>(context, listen: false)
        //               .nama_staff
        //               .substring(0, 1)
        //               .toUpperCase(),
        //           style: TextStyle(fontSize: 40.0),
        //         ),
        //       ),
        //     ),
        //   ],
        // )),
      );
    });
  }

  void _kePeriode(BuildContext context) async {
    final per = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingPeriode()),
    );
    HomeController.perx = per;
  }

  Widget menu_utama() {
    double size = (MediaQuery.of(context).size.width - 160) / 4;
    return Consumer<HomeController>(builder: (context, homeController, child) {
      return Row(
        children: [
          SizedBox(
            width: 32,
          ),

          //TRANSAKSI STOK
          OnHoverButton(
            child: InkWell(
              // onTap: () {
              //   if (Provider.of<LoginController>(context, listen: false)
              //           .ROLE !=
              //       2) {
              //   Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => DataStokScreen()))
              //       .then((value) {
              //     if (Provider.of<LoginController>(context, listen: false)
              //             .ROLE ==
              //         2) {
              //       homeController.baca_allData(3);
              //     }
              //   });
              //   } else {
              //     Toast("No Access", "Hanya bisa diakses Manajer & Staff PJL",
              //         false);
              //   }
              // },
              child: Container(
                width: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AbuColor),
                  boxShadow: [
                    BoxShadow(
                      color: GreyColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        "assets/images/ic_po.png",
                        height: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Sales Order",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        SoController.home_so_list.length.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Increased 0%",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AbuColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
          ),

          //TRANSAKSI PO
          OnHoverButton(
            child: InkWell(
              child: Container(
                width: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AbuColor),
                  boxShadow: [
                    BoxShadow(
                      color: GreyColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        "assets/images/ic_tax.png",
                        height: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Purchase Order",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        PobahanlokalController.home_pobahan_list.length
                            .toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Increased 0%",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AbuColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
          ),

          //TRANSAKSI PENERIMAAN
          OnHoverButton(
            child: InkWell(
              // onTap: () {
              //   if (Provider.of<LoginController>(context, listen: false)
              //           .ROLE !=
              //       2) {
              //   Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => PenerimaanScreen()))
              //       .then((value) {
              //     if (Provider.of<LoginController>(context, listen: false)
              //             .ROLE ==
              //         2) {
              //       homeController.baca_allData(3);
              //     }
              //   });
              //   } else {
              //     Toast("No Access", "Hanya bisa diakses Manajer & Staff PJL",
              //         false);
              //   }
              // },
              child: Container(
                width: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AbuColor),
                  boxShadow: [
                    BoxShadow(
                      color: GreyColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        "assets/images/ic_pembelian.png",
                        height: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Pembelian",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        BelibahanController.home_belibahan_list.length
                            .toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Increased 0%",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AbuColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
          ),

          //KAS MASUK
          OnHoverButton(
            child: InkWell(
              // onTap: () {
              //   if (Provider.of<LoginController>(context, listen: false)
              //           .ROLE !=
              //       2) {
              //   Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => KasMasukScreen()))
              //       .then((value) {
              //     if (Provider.of<LoginController>(context, listen: false)
              //             .ROLE ==
              //         3) {
              //       homeController.baca_allData(2);
              //     }
              //   });
              //   } else {
              //     Toast("No Access", "Hanya bisa diakses Manajer & Staff PJL",
              //         false);
              //   }
              // },
              child: Container(
                width: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AbuColor),
                  boxShadow: [
                    BoxShadow(
                      color: GreyColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Image.asset(
                        "assets/images/ic_penjualan.png",
                        height: 50,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Penjualan",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        JualController.home_jual_list.length.toString(),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Increased 0%",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AbuColor),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 32,
          ),
        ],
      );
    });
  }
}
