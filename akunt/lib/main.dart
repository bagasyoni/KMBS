import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:akunt/controller/dragonpo_controller.dart';

///////////////////////MASTER///////////////////////
import 'package:akunt/controller/brg_controller.dart';
import 'package:akunt/controller/gudang_controller.dart';
import 'package:akunt/controller/emkl_controller.dart';
import 'package:akunt/controller/customer_controller.dart';
import 'package:akunt/controller/supplier_controller.dart';
import 'package:akunt/controller/account_controller.dart';
import 'package:akunt/controller/currency_controller.dart';
import 'package:akunt/controller/toko_controller.dart';
import 'package:akunt/controller/peg_controller.dart';
import 'package:akunt/controller/bhn_controller.dart';
import 'package:akunt/controller/sparepart_controller.dart';
import 'package:akunt/controller/mesin_controller.dart';
import 'package:akunt/controller/bahan_controller.dart';
import 'package:akunt/controller/nonbahan_controller.dart';
import 'package:akunt/controller/bagas_controller.dart';
import 'package:akunt/controller/bank_controller.dart';
import 'package:akunt/controller/periode_controller.dart';

///////////////////////TRANSAKSI///////////////////////
import 'package:akunt/controller/pobahanlokal_controller.dart';
import 'package:akunt/controller/pobahanimport_controller.dart';
import 'package:akunt/controller/pobaranglokal_controller.dart';
import 'package:akunt/controller/pobarangimport_controller.dart';
import 'package:akunt/controller/pononbahan_controller.dart';
import 'package:akunt/controller/poimport_controller.dart';
import 'package:akunt/controller/pomesin_controller.dart';
import 'package:akunt/controller/posparepart_controller.dart';
import 'package:akunt/controller/belibahan_controller.dart';
import 'package:akunt/controller/belinonbahan_controller.dart';
import 'package:akunt/controller/beliimport_controller.dart';
import 'package:akunt/controller/belimesin_controller.dart';
import 'package:akunt/controller/belisparepart_controller.dart';
import 'package:akunt/controller/thutbahan_controller.dart';
import 'package:akunt/controller/thutnonbahan_controller.dart';
import 'package:akunt/controller/thutimport_controller.dart';
import 'package:akunt/controller/thutmesin_controller.dart';
import 'package:akunt/controller/thutsparepart_controller.dart';
import 'package:akunt/controller/hutbahan_controller.dart';
import 'package:akunt/controller/pakaibhn_controller.dart';
import 'package:akunt/controller/terima_controller.dart';
import 'package:akunt/controller/stockbhn_controller.dart';
import 'package:akunt/controller/mutasibrg_controller.dart';
import 'package:akunt/controller/so_controller.dart';
import 'package:akunt/controller/surat_controller.dart';
import 'package:akunt/controller/jual_controller.dart';
import 'package:akunt/controller/tpiu_controller.dart';
import 'package:akunt/controller/piu_controller.dart';

//////////////////////LAPORAN///////////////////////////
import 'package:akunt/controller/laporan_pobahan_controller.dart';
import 'package:akunt/controller/laporan_belibahan_controller.dart';
import 'package:akunt/controller/laporan_thutbahan_controller.dart';
import 'package:akunt/controller/laporan_hutbahan_controller.dart';
import 'package:akunt/controller/laporan_so_controller.dart';
import 'package:akunt/controller/laporan_sj_controller.dart';
import 'package:akunt/controller/laporan_jual_controller.dart';
import 'package:akunt/controller/laporan_kas_controller.dart';
import 'package:akunt/controller/laporan_bank_controller.dart';
import 'package:akunt/controller/laporan_memo_controller.dart';
import 'package:akunt/controller/laporan_stocka_controller.dart';
import 'package:akunt/controller/laporan_stockb_controller.dart';
import 'package:akunt/controller/laporan_pakai_controller.dart';
import 'package:akunt/controller/laporan_terima_controller.dart';
import 'package:akunt/controller/laporan_perincianstk_bhn_controller.dart';
import 'package:akunt/controller/laporan_perincianstk_brg_controller.dart';
import 'package:akunt/controller/laporan_perincian_hut_controller.dart';
import 'package:akunt/controller/laporan_perincian_piu_controller.dart';
import 'package:akunt/controller/laporan_perincian_nera_controller.dart';
import 'package:akunt/controller/laporan_kartustk_bhn_controller.dart';
import 'package:akunt/controller/laporan_kartustk_brg_controller.dart';
import 'package:akunt/controller/laporan_kartu_hut_controller.dart';
import 'package:akunt/controller/laporan_kartu_piu_controller.dart';
import 'package:akunt/controller/laporan_buku_besar_controller.dart';
import 'package:akunt/controller/laporan_nera_controller.dart';
import 'package:akunt/controller/laporan_rl_controller.dart';

///OPERASIONAL///
import 'package:akunt/controller/po_controller.dart';
import 'package:akunt/controller/pon_controller.dart';
import 'package:akunt/controller/so_controller.dart';
import 'package:akunt/controller/beli_controller.dart';
import 'package:akunt/controller/stok_controller.dart';

///FINANSIAL///
import 'package:akunt/controller/bankmasuk_controller.dart';
import 'package:akunt/controller/bankkeluar_controller.dart';
import 'package:akunt/controller/kasmasuk_controller.dart';
import 'package:akunt/controller/kaskeluar_controller.dart';
import 'package:akunt/controller/memo_controller.dart';

///////////////////////LAPORAN///////////////////////
///OPERASIONAL///
import 'package:akunt/controller/laporan_po_controller.dart';
import 'package:akunt/controller/laporan_pon_controller.dart';
import 'package:akunt/controller/laporan_so_controller.dart';
import 'package:akunt/controller/lapbeli_controller.dart';

///FINANSISAL///

///LAIN///

///////////////////////LAPORAN///////////////////////
///UTILITY///
import 'package:akunt/controller/db_controller.dart';
import 'package:akunt/controller/home_controller.dart';
import 'package:akunt/controller/login_controller.dart';
import 'package:akunt/controller/register_controller.dart';
import 'package:akunt/view/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Provider
  sl.registerFactory(() => DragonpoController());
  // sl.registerFactory(() => DragonsbeliController());

  sl.registerFactory(() => HomeController());
  sl.registerFactory(() => LapPoController());
  sl.registerFactory(() => LapPonController());
  sl.registerFactory(() => BeliController());
  sl.registerFactory(() => LapBeliController());
  sl.registerFactory(() => PonController());
  sl.registerFactory(() => PoController());
  sl.registerFactory(() => EmklController());
  sl.registerFactory(() => GudangController());
  sl.registerFactory(() => CustomerController());
  sl.registerFactory(() => PegController());
  sl.registerFactory(() => BhnController());
  sl.registerFactory(() => StokController());
  sl.registerFactory(() => LoginController());
  sl.registerFactory(() => RegisterController());
  sl.registerFactory(() => db_controller());
  sl.registerFactory(() => KasmasukController());
  sl.registerFactory(() => KaskeluarController());
  sl.registerFactory(() => BankmasukController());
  sl.registerFactory(() => BankkeluarController());
  sl.registerFactory(() => MemoController());
  sl.registerFactory(() => BrgController());

  ///MASTER///
  sl.registerFactory(() => AccountController());
  sl.registerFactory(() => CurrencyController());
  sl.registerFactory(() => TokoController());
  sl.registerFactory(() => SupplierController());
  sl.registerFactory(() => BahanController());
  sl.registerFactory(() => NonbahanController());
  sl.registerFactory(() => MesinController());
  sl.registerFactory(() => SparepartController());
  sl.registerFactory(() => BagasController());
  sl.registerFactory(() => BankController());
  sl.registerFactory(() => PeriodeController());

  ///TRANSAKSI///
  sl.registerFactory(() => PobahanlokalController());
  sl.registerFactory(() => PobahanimportController());
  sl.registerFactory(() => PobaranglokalController());
  sl.registerFactory(() => PobarangimportController());
  sl.registerFactory(() => PononbahanController());
  sl.registerFactory(() => PoimportController());
  sl.registerFactory(() => PomesinController());
  sl.registerFactory(() => PosparepartController());
  sl.registerFactory(() => BelibahanController());
  sl.registerFactory(() => BelinonbahanController());
  sl.registerFactory(() => BeliimportController());
  sl.registerFactory(() => BelimesinController());
  sl.registerFactory(() => BelisparepartController());
  sl.registerFactory(() => ThutbahanController());
  sl.registerFactory(() => ThutnonbahanController());
  sl.registerFactory(() => ThutimportController());
  sl.registerFactory(() => ThutmesinController());
  sl.registerFactory(() => ThutsparepartController());
  sl.registerFactory(() => HutbahanController());
  sl.registerFactory(() => StockbhnController());
  sl.registerFactory(() => MutasibrgController());
  sl.registerFactory(() => PakaibhnController());
  sl.registerFactory(() => TerimabhnController());
  sl.registerFactory(() => SoController());
  sl.registerFactory(() => SuratController());
  sl.registerFactory(() => JualController());
  sl.registerFactory(() => TpiuController());
  sl.registerFactory(() => PiuController());

  ///LAPORAN///
  sl.registerFactory(() => LapPobahanController());
  sl.registerFactory(() => LapBelibahanController());
  sl.registerFactory(() => LapThutbahanController());
  sl.registerFactory(() => LapHutbahanController());
  sl.registerFactory(() => LapSoController());
  sl.registerFactory(() => LapSjController());
  sl.registerFactory(() => LapJualController());
  sl.registerFactory(() => LapKasController());
  sl.registerFactory(() => LapBankController());
  sl.registerFactory(() => LapMemoController());
  sl.registerFactory(() => LapStockaController());
  sl.registerFactory(() => LapStockbController());
  sl.registerFactory(() => LapPakaiController());
  sl.registerFactory(() => LapTerimaController());
  sl.registerFactory(() => LapPerincianstkbhnController());
  sl.registerFactory(() => LapPerincianstkbrgController());
  sl.registerFactory(() => LapPerincianhutController());
  sl.registerFactory(() => LapPerincianpiuController());
  sl.registerFactory(() => LapPerincianneraController());
  sl.registerFactory(() => LapKartustkbhnController());
  sl.registerFactory(() => LapKartustkbrgController());
  sl.registerFactory(() => LapKartuhutController());
  sl.registerFactory(() => LapKartupiuController());
  sl.registerFactory(() => LapBukubesarController());
  sl.registerFactory(() => LapNeraController());
  sl.registerFactory(() => LapRlController());
}

Future<void> main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null).then((_) =>
      runApp(MultiProvider(
        providers: [
          ///MASTER///
          ChangeNotifierProvider(create: (context) => sl<AccountController>()),
          ChangeNotifierProvider(create: (context) => sl<CurrencyController>()),
          ChangeNotifierProvider(create: (context) => sl<TokoController>()),
          ChangeNotifierProvider(create: (context) => sl<SupplierController>()),
          ChangeNotifierProvider(create: (context) => sl<BahanController>()),
          ChangeNotifierProvider(create: (context) => sl<NonbahanController>()),
          ChangeNotifierProvider(create: (context) => sl<MesinController>()),
          ChangeNotifierProvider(
              create: (context) => sl<SparepartController>()),
          ChangeNotifierProvider(create: (context) => sl<BagasController>()),
          ChangeNotifierProvider(create: (context) => sl<BankController>()),
          ChangeNotifierProvider(create: (context) => sl<PeriodeController>()),

          ///TRANSAKSI///
          ChangeNotifierProvider(
              create: (context) => sl<PobahanlokalController>()),
          ChangeNotifierProvider(
              create: (context) => sl<PobahanimportController>()),
          ChangeNotifierProvider(
              create: (context) => sl<PobaranglokalController>()),
          ChangeNotifierProvider(
              create: (context) => sl<PobarangimportController>()),
          ChangeNotifierProvider(
              create: (context) => sl<PononbahanController>()),
          ChangeNotifierProvider(create: (context) => sl<PoimportController>()),
          ChangeNotifierProvider(create: (context) => sl<PomesinController>()),
          ChangeNotifierProvider(
              create: (context) => sl<PosparepartController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BelibahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BelinonbahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BeliimportController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BelimesinController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BelisparepartController>()),
          ChangeNotifierProvider(
              create: (context) => sl<ThutbahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<ThutnonbahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<ThutimportController>()),
          ChangeNotifierProvider(
              create: (context) => sl<ThutmesinController>()),
          ChangeNotifierProvider(
              create: (context) => sl<ThutsparepartController>()),
          ChangeNotifierProvider(create: (context) => sl<HutbahanController>()),
          ChangeNotifierProvider(create: (context) => sl<PakaibhnController>()),
          ChangeNotifierProvider(
              create: (context) => sl<TerimabhnController>()),
          ChangeNotifierProvider(create: (context) => sl<StockbhnController>()),
          ChangeNotifierProvider(
              create: (context) => sl<MutasibrgController>()),
          ChangeNotifierProvider(create: (context) => sl<SoController>()),
          ChangeNotifierProvider(create: (context) => sl<SuratController>()),
          ChangeNotifierProvider(create: (context) => sl<JualController>()),
          ChangeNotifierProvider(create: (context) => sl<TpiuController>()),
          ChangeNotifierProvider(create: (context) => sl<PiuController>()),

          ///LAPORAN///
          ChangeNotifierProvider(
              create: (context) => sl<LapPobahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapBelibahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapThutbahanController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapHutbahanController>()),
          ChangeNotifierProvider(create: (context) => sl<LapSoController>()),
          ChangeNotifierProvider(create: (context) => sl<LapSjController>()),
          ChangeNotifierProvider(create: (context) => sl<LapJualController>()),
          ChangeNotifierProvider(create: (context) => sl<LapKasController>()),
          ChangeNotifierProvider(create: (context) => sl<LapBankController>()),
          ChangeNotifierProvider(create: (context) => sl<LapMemoController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapStockaController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapStockbController>()),
          ChangeNotifierProvider(create: (context) => sl<LapPakaiController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapTerimaController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapPerincianstkbhnController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapPerincianstkbrgController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapPerincianhutController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapPerincianpiuController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapPerincianneraController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapKartustkbhnController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapKartustkbrgController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapKartuhutController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapKartupiuController>()),
          ChangeNotifierProvider(
              create: (context) => sl<LapBukubesarController>()),
          ChangeNotifierProvider(create: (context) => sl<LapNeraController>()),
          ChangeNotifierProvider(create: (context) => sl<LapRlController>()),

          ChangeNotifierProvider(create: (context) => sl<DragonpoController>()),
          ChangeNotifierProvider(create: (context) => sl<HomeController>()),
          ChangeNotifierProvider(create: (context) => sl<LapPoController>()),
          ChangeNotifierProvider(create: (context) => sl<LapBeliController>()),
          ChangeNotifierProvider(create: (context) => sl<LapPonController>()),
          ChangeNotifierProvider(create: (context) => sl<PonController>()),
          ChangeNotifierProvider(create: (context) => sl<PoController>()),
          ChangeNotifierProvider(create: (context) => sl<BeliController>()),
          ChangeNotifierProvider(create: (context) => sl<EmklController>()),
          ChangeNotifierProvider(create: (context) => sl<GudangController>()),
          ChangeNotifierProvider(create: (context) => sl<CustomerController>()),
          ChangeNotifierProvider(create: (context) => sl<PegController>()),
          ChangeNotifierProvider(create: (context) => sl<BhnController>()),
          ChangeNotifierProvider(create: (context) => sl<StokController>()),
          ChangeNotifierProvider(create: (context) => sl<LoginController>()),
          ChangeNotifierProvider(create: (context) => sl<RegisterController>()),
          ChangeNotifierProvider(create: (context) => sl<db_controller>()),

          ChangeNotifierProvider(create: (context) => sl<KasmasukController>()),
          ChangeNotifierProvider(
              create: (context) => sl<KaskeluarController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BankmasukController>()),
          ChangeNotifierProvider(
              create: (context) => sl<BankkeluarController>()),
          ChangeNotifierProvider(create: (context) => sl<MemoController>()),

          ChangeNotifierProvider(create: (context) => sl<BrgController>()),
        ],
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PT. Karyamitra Budisentosa",
      theme: theme(),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
