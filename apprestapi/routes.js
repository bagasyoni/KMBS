'use strict';

module.exports = function (app) {
    var jsonku = require('./controller');

    ///======================== MASTER CONTROLLER ========================///
    ///=====>>> START FINANSIAL
    var accjs = require('../apprestapi/controller/master/finansial/account_controller');
    ///===== END FINANSIAL

    ///===== START OPERASIONAL
    var brgjs = require('../apprestapi/controller/master/operasional/barang_controller');
    var bhnjs = require('../apprestapi/controller/master/operasional/bahan_controller');
    var currjs = require('../apprestapi/controller/master/operasional/currency_controller');
    var custjs = require('../apprestapi/controller/master/operasional/customer_controller');
    var supjs = require('../apprestapi/controller/master/operasional/supplier_controller');
    var tokojs = require('../apprestapi/controller/master/operasional/toko_controller');
    var userjs = require('../apprestapi/controller/master/operasional/user_controller');
    var hsjs = require('../apprestapi/controller/master/operasional/hs_controller');
    var brandjs = require('../apprestapi/controller/master/operasional/brand_controller');
    ///=====>>> END OPERASIONAL


    ///======================== TRANSAKSI CONTROLLER ========================///
    ///=====>>> START FINANSIAL
    var kasmjs = require('../apprestapi/controller/transaksi/finansial/kasm_controller');
    var kaskjs = require('../apprestapi/controller/transaksi/finansial/kask_controller');
    var bankmjs = require('../apprestapi/controller/transaksi/finansial/bankm_controller');
    var bankkjs = require('../apprestapi/controller/transaksi/finansial/bankk_controller');
    var girokjs = require('../apprestapi/controller/transaksi/finansial/girok_controller');
    var giromjs = require('../apprestapi/controller/transaksi/finansial/girom_controller');
    var memojs = require('../apprestapi/controller/transaksi/finansial/memo_controller');
    ///=====>>> END FINANSIAL

    ///=====>>> START OPERASIONAL
    var pobhn_lokaljs = require('../apprestapi/controller/transaksi/operasional/pobhn_lokal_controller');
    var pobhn_importjs = require('../apprestapi/controller/transaksi/operasional/pobhn_import_controller');
    var pobrg_lokaljs = require('../apprestapi/controller/transaksi/operasional/pobrg_lokal_controller');
    var pobrg_importjs = require('../apprestapi/controller/transaksi/operasional/pobrg_import_controller');
    var sojs = require('../apprestapi/controller/transaksi/operasional/so_controller');
    ///=====>>> END OPERASIONAL

    ///======================== LAPORAN CONTROLLER ========================///

    app.route('/')
        .get(jsonku.index);



    ///MODAL
    app.route('/tampil_perid')
        .post(jsonku.tampilperid);

    ///=================================/// MENU MASTER ///=================================///
    app.route('/bagaspaginate')
        .post(jsonku.bagas_paginate);
    app.route('/countbagaspaginate')
        .post(jsonku.count_bagaspaginate);
    app.route('/caribagas')
        .post(jsonku.caribagas);
    app.route('/tampilbagas')
        .post(jsonku.tampilbagas);
    app.route('/modal_bagas_stok')
        .post(jsonku.modalbagasstok);
    app.route('/tambahbagas')
        .post(jsonku.tambahbagas);
    app.route('/ubahbagas')
        .post(jsonku.ubahbagas);
    app.route('/hapusbagas')
        .post(jsonku.hapusbagas);

     ///========================/// START MASTER ACCOUNTING ///========================///
    app.route('/accpaginate')
        .post(accjs.acc_paginate);
    app.route('/countaccpaginate')
        .post(accjs.count_accpaginate);
    app.route('/cariacc')
        .post(accjs.cariacc);
    app.route('/tampilacc')
        .post(accjs.tampilacc);
    app.route('/modal_acc_stok')
        .post(accjs.modalaccstok);
    app.route('/tambahacc')
        .post(accjs.tambahacc);
    app.route('/ubahacc')
        .post(accjs.ubahacc);
    app.route('/hapusacc')
        .post(accjs.hapusacc);
    ///========================/// END MASTER ACCOUNTING ///========================///

    ///========================/// START MASTER CURRENCY ///========================///
    app.route('/currpaginate')
        .post(currjs.curr_paginate);
    app.route('/countcurrpaginate')
        .post(currjs.count_currpaginate);
    app.route('/caricurr')
        .post(currjs.caricurr);
    app.route('/tampilcurr')
        .post(currjs.tampilcurr);
    app.route('/modal_curr')
        .post(currjs.modalcurr);
    app.route('/tambahcurr')
        .post(currjs.tambahcurr);
    app.route('/ubahcurr')
        .post(currjs.ubahcurr);
    app.route('/hapuscurr')
        .post(currjs.hapuscurr);
    ///========================/// END MASTER CURRENCY ///========================///

    ///========================/// START MASTER TOKO ///========================///
    app.route('/tokopaginate')
        .post(tokojs.toko_paginate);
    app.route('/counttokopaginate')
        .post(tokojs.count_tokopaginate);
    app.route('/caritoko')
        .post(tokojs.caritoko);
    app.route('/tampiltoko')
        .post(tokojs.tampiltoko);
    app.route('/modal_toko')
        .post(tokojs.modaltoko);
    app.route('/tambahtoko')
        .post(tokojs.tambahtoko);
    app.route('/ubahtoko')
        .post(tokojs.ubahtoko);
    app.route('/hapustoko')
        .post(tokojs.hapustoko);
    ///========================/// END MASTER TOKO ///========================///

    ///========================/// START MASTER USER ///========================///
    app.route('/userpaginate')
        .post(userjs.user_paginate);
    app.route('/countuserpaginate')
        .post(userjs.count_userpaginate);
    app.route('/cariuser')
        .post(userjs.cariuser);
    app.route('/tampiluser')
        .post(userjs.tampiluser);
    app.route('/modal_user')
        .post(userjs.modaluser);
    app.route('/tambahuser')
        .post(userjs.tambahuser);
    app.route('/ubahuser')
        .post(userjs.ubahuser);
    app.route('/hapususer')
        .post(userjs.hapususer);
    app.route('/check_username')
        .post(userjs.checkusername);
    ///========================/// END MASTER USER ///========================///

    ///========================/// START MASTER HS ///========================///
    app.route('/hspaginate')
        .post(hsjs.hs_paginate);
    app.route('/counthspaginate')
        .post(hsjs.count_hspaginate);
    app.route('/carihs')
        .post(hsjs.carihs);
    app.route('/tampilhs')
        .post(hsjs.tampilhs);
    app.route('/modal_hs')
        .post(hsjs.modalhs);
    app.route('/tambahhs')
        .post(hsjs.tambahhs);
    app.route('/ubahhs')
        .post(hsjs.ubahhs);
    app.route('/hapushs')
        .post(hsjs.hapushs);
    app.route('/check_hs')
        .post(hsjs.checkhs);
    ///========================/// END MASTER HS ///========================///

    ///========================/// START MASTER BARANG ///========================///
    app.route('/brgpaginate')
        .post(brgjs.brg_paginate);
    app.route('/countbrgpaginate')
        .post(brgjs.count_brgpaginate);
    app.route('/caribrg')
        .post(brgjs.caribrg);
    app.route('/tampilbrg')
        .post(brgjs.tampilbrg);
    app.route('/modal_brg_stok')
        .post(brgjs.modalbrgstok);
    app.route('/tambahbrg')
        .post(brgjs.tambahbrg);
    app.route('/ubahbrg')
        .post(brgjs.ubahbrg);
    app.route('/hapusbrg')
        .post(brgjs.hapusbrg);
    ///========================/// END MASTER BARANG ///========================///

    ///========================/// START MASTER CUSTOMER ///========================///
    app.route('/cuspaginate')
        .post(custjs.cus_paginate);
    app.route('/countcuspaginate')
        .post(custjs.count_cuspaginate);
    app.route('/caricus')
        .post(custjs.caricus);
    app.route('/tampilcus')
        .post(custjs.tampilcus);
    app.route('/modal_cus_stok')
        .post(custjs.modalcusstok);
    app.route('/tambahcus')
        .post(custjs.tambahcus);
    app.route('/ubahcus')
        .post(custjs.ubahcus);
    app.route('/hapuscus')
        .post(custjs.hapuscus);
    ///========================/// END MASTER CUSTOMER ///========================///

    ///========================/// START MASTER SUPPLIER ///========================///
    app.route('/suppaginate')
        .post(supjs.sup_paginate);
    app.route('/countsuppaginate')
        .post(supjs.count_suppaginate);
    app.route('/carisup')
        .post(supjs.carisup);
    app.route('/tampilsup')
        .post(supjs.tampilsup);
    app.route('/modal_sup_stok')
        .post(supjs.modalsupstok);
    app.route('/tambahsup')
        .post(supjs.tambahsup);
    app.route('/ubahsup')
        .post(supjs.ubahsup);
    app.route('/hapussup')
        .post(supjs.hapussup);
    ///========================/// END MASTER SUPPLIER ///========================///

    ///========================/// START MASTER BAHAN ///========================///
    app.route('/bahanpaginate')
        .post(bhnjs.bahan_paginate);
    app.route('/countbahanpaginate')
        .post(bhnjs.count_bahanpaginate);
    app.route('/caribahan')
        .post(bhnjs.caribahan);
    app.route('/tampilbahan')
        .post(bhnjs.tampilbahan);
    app.route('/modal_bahan_stok')
        .post(bhnjs.modalbahanstok);
    app.route('/tambahbahan')
        .post(bhnjs.tambahbahan);
    app.route('/ubahbahan')
        .post(bhnjs.ubahbahan);
    app.route('/hapusbahan')
        .post(bhnjs.hapusbahan);
    ///========================/// END MASTER BAHAN ///========================///

    ///========================/// START MASTER BRAND ///========================///
    app.route('/tampilbrand')
        .post(brandjs.tampilbrand);
    app.route('/modal_brand')
        .post(brandjs.modal_brand);
    ///========================/// END MASTER BRAND ///========================///

    ///TRANSAKSI FINANSIAL///
    ///====================/// KAS MASUK ///====================///
    app.route('/kasmpaginate')
        .post(kasmjs.kasm_paginate);
    app.route('/countkasmpaginate')
        .post(kasmjs.count_kasmpaginate);
    app.route('/tambah_header_kasm')
        .post(kasmjs.tambahheaderkasm);
    app.route('/tambah_detail_kasm')
        .post(kasmjs.tambahdetailkasm);
    app.route('/tampil_kasm')
        .post(kasmjs.tampilkasm);
    app.route('/edit_header_kasm')
        .post(kasmjs.editheaderkasm);
    app.route('/modal_kasm')
        .post(kasmjs.modalkasm);
    app.route('/cari_kasm')
        .post(kasmjs.carikasm);
    app.route('/ambil_kasm_detail')
        .post(kasmjs.ambilkasmdetail);
    app.route('/hapus_kasm')
        .post(kasmjs.hapuskasm);
    app.route('/cari_piutang_kas')
        .post(kasmjs.caripiutang)

    ///====================/// KAS KELUAR ///====================///
    app.route('/kaskpaginate')
        .post(kaskjs.kask_paginate);
    app.route('/countkaskpaginate')
        .post(kaskjs.count_kaskpaginate);
    app.route('/tambah_header_kask')
        .post(kaskjs.tambahheaderkask);
    app.route('/tambah_detail_kask')
        .post(kaskjs.tambahdetailkask);
    app.route('/tampil_kask')
        .post(kaskjs.tampilkask);
    app.route('/edit_header_kask')
        .post(kaskjs.editheaderkask);
    app.route('/modal_kask')
        .post(kaskjs.modalkask);
    app.route('/cari_kask')
        .post(kaskjs.carikask);
    app.route('/ambil_kask_detail')
        .post(kaskjs.ambilkaskdetail);
    app.route('/hapus_kask')
        .post(kaskjs.hapuskask);
    app.route('/cari_hutang_kas')
        .post(kaskjs.carihutang);

    ///====================/// BANK MASUK ///====================///
    app.route('/bankmpaginate')
        .post(bankmjs.bankm_paginate);
    app.route('/countbankmpaginate')
        .post(bankmjs.count_bankmpaginate);
    app.route('/tambah_header_bankm')
        .post(bankmjs.tambahheaderbankm);
    app.route('/tambah_detail_bankm')
        .post(bankmjs.tambahdetailbankm);
    app.route('/tampil_bankm')
        .post(bankmjs.tampilbankm);
    app.route('/edit_header_bankm')
        .post(bankmjs.editheaderbankm);
    app.route('/modal_bankm')
        .post(bankmjs.modalbankm);
    app.route('/cari_bankm')
        .post(bankmjs.caribankm);
    app.route('/ambil_bankm_detail')
        .post(bankmjs.ambilbankmdetail);
    app.route('/hapus_bankm')
        .post(bankmjs.hapusbankm);
    app.route('/cari_piutang_bank')
        .post(bankmjs.caripiutang);

    ///====================/// BANK KELUAR ///====================///
    app.route('/bankkpaginate')
        .post(bankkjs.bankk_paginate);
    app.route('/countbankkpaginate')
        .post(bankkjs.count_bankkpaginate);
    app.route('/tambah_header_bankk')
        .post(bankkjs.tambahheaderbankk);
    app.route('/tambah_detail_bankk')
        .post(bankkjs.tambahdetailbankk);
    app.route('/tampil_bankk')
        .post(bankkjs.tampilbankk);
    app.route('/edit_header_bankk')
        .post(bankkjs.editheaderbankk);
    app.route('/modal_bankk')
        .post(bankkjs.modalbankk);
    app.route('/cari_bankk')
        .post(bankkjs.caribankk);
    app.route('/ambil_bankk_detail')
        .post(bankkjs.ambilbankkdetail);
    app.route('/hapus_bankk')
        .post(bankkjs.hapusbankk);
    app.route('/cari_hutang_bank')
        .post(bankkjs.carihutang);

    ///====================/// GIRO KELUAR ///====================///
    app.route('/girompaginate')
        .post(giromjs.girom_paginate);
    app.route('/countgirompaginate')
        .post(giromjs.count_girompaginate);
    app.route('/tambah_header_girom')
        .post(giromjs.tambahheadergirom);
    app.route('/tambah_detail_girom')
        .post(giromjs.tambahdetailgirom);
    app.route('/tampil_girom')
        .post(giromjs.tampilgirom);
    app.route('/edit_header_girom')
        .post(giromjs.editheadergirom);
    app.route('/modal_girom')
        .post(giromjs.modalgirom);
    app.route('/cari_girom')
        .post(giromjs.carigirom);
    app.route('/ambil_girom_detail')
        .post(giromjs.ambilgiromdetail);
    app.route('/hapus_girom')
        .post(giromjs.hapusgirom);
    app.route('/cari_piutang_giro')
        .post(giromjs.caripiutang);

    ///====================/// GIRO MASUK ///====================///
    app.route('/girokpaginate')
        .post(girokjs.girok_paginate);
    app.route('/countgirokpaginate')
        .post(girokjs.count_girokpaginate);
    app.route('/tambah_header_girok')
        .post(girokjs.tambahheadergirok);
    app.route('/tambah_detail_girok')
        .post(girokjs.tambahdetailgirok);
    app.route('/tampil_girok')
        .post(girokjs.tampilgirok);
    app.route('/edit_header_girok')
        .post(girokjs.editheadergirok);
    app.route('/modal_girok')
        .post(girokjs.modalgirok);
    app.route('/cari_girok')
        .post(girokjs.carigirok);
    app.route('/ambil_girok_detail')
        .post(girokjs.ambilgirokdetail);
    app.route('/hapus_girok')
        .post(girokjs.hapusgirok);
    app.route('/cari_hutang_giro')
        .post(girokjs.carihutang);

    ///====================/// MEMORIAL ///====================///
    app.route('/memopaginate')
        .post(memojs.memo_paginate);
    app.route('/countmemopaginate')
        .post(memojs.count_memopaginate);
    app.route('/tambah_header_memo')
        .post(memojs.tambahheadermemo);
    app.route('/tambah_detail_memo')
        .post(memojs.tambahdetailmemo);
    app.route('/tampil_memo')
        .post(memojs.tampilmemo);
    app.route('/edit_header_memo')
        .post(memojs.editheadermemo);
    app.route('/modal_memo')
        .post(memojs.modalmemo);
    app.route('/cari_memo')
        .post(memojs.carimemo);
    app.route('/ambil_memo_detail')
        .post(memojs.ambilmemodetail);
    app.route('/hapus_memo')
        .post(memojs.hapusmemo);
    app.route('/cari_account')
        .post(memojs.cariaccount);

    ///TRANSAKSI OPERASIONAL///
    ///====================/// PO BAHAN LOKAL ///====================///
    app.route('/pobahanlokalpaginate')
        .post(pobhn_lokaljs.pobahanlokal_paginate);
    app.route('/countpobahanlokalpaginate')
        .post(pobhn_lokaljs.count_pobahanlokalpaginate);
    app.route('/tambah_header_po_bahan_lokal')
        .post(pobhn_lokaljs.tambahheaderpobahanlokal);
    app.route('/tambah_detail_po_bahan_lokal')
        .post(pobhn_lokaljs.tambahdetailpobahanlokal);
    app.route('/tampil_po_bahan_lokal')
        .post(pobhn_lokaljs.tampilpobahanlokal);
    app.route('/edit_header_po_bahan_lokal')
        .post(pobhn_lokaljs.editheaderpobahanlokal);
    app.route('/modal_po_bahan_lokal')
        .post(pobhn_lokaljs.modalpobahanlokal);
    app.route('/cari_po_bahan_lokal')
        .post(pobhn_lokaljs.caripobahanlokal);
    app.route('/ambil_po_detail')
        .post(pobhn_lokaljs.ambilpodetail);
    app.route('/hapus_po_bahanlokal')
        .post(pobhn_lokaljs.hapuspobahanlokal);

    ///====================/// PO BAHAN IMPORT ///====================///
    app.route('/pobahanimportpaginate')
        .post(pobhn_importjs.pobahanimport_paginate);
    app.route('/countpobahanimportpaginate')
        .post(pobhn_importjs.count_pobahanimportpaginate);
    app.route('/tambah_header_po_bahan_import')
        .post(pobhn_importjs.tambahheaderpobahanimport);
    app.route('/tambah_detail_po_bahan_import')
        .post(pobhn_importjs.tambahdetailpobahanimport);
    app.route('/tampil_po_bahan_import')
        .post(pobhn_importjs.tampilpobahanimport);
    app.route('/edit_header_po_bahan_import')
        .post(pobhn_importjs.editheaderpobahanimport);
    app.route('/modal_po_bahan_import')
        .post(pobhn_importjs.modalpobahanimport);
    app.route('/cari_po_bahan_import')
        .post(pobhn_importjs.caripobahanimport);
    app.route('/ambil_po_detail')
        .post(pobhn_importjs.ambilpodetail);
    app.route('/hapus_po_bahanimport')
        .post(pobhn_importjs.hapuspobahanimport);

    ///====================/// PO BARANG LOKAL ///====================///
    app.route('/pobaranglokalpaginate')
        .post(pobrg_lokaljs.pobaranglokal_paginate);
    app.route('/countpobaranglokalpaginate')
        .post(pobrg_lokaljs.count_pobaranglokalpaginate);
    app.route('/tambah_header_po_barang_lokal')
        .post(pobrg_lokaljs.tambahheaderpobaranglokal);
    app.route('/tambah_detail_po_barang_lokal')
        .post(pobrg_lokaljs.tambahdetailpobaranglokal);
    app.route('/tampil_po_barang_lokal')
        .post(pobrg_lokaljs.tampilpobaranglokal);
    app.route('/edit_header_po_barang_lokal')
        .post(pobrg_lokaljs.editheaderpobaranglokal);
    app.route('/modal_po_barang_lokal')
        .post(pobrg_lokaljs.modalpobaranglokal);
    app.route('/cari_po_barang_lokal')
        .post(pobrg_lokaljs.caripobaranglokal);
    app.route('/ambil_po_detail')
        .post(pobrg_lokaljs.ambilpodetail);
    app.route('/hapus_po_baranglokal')
        .post(pobrg_lokaljs.hapuspobaranglokal);

    ///====================/// PO BARANG IMPORT ///====================///
    app.route('/pobarangimportpaginate')
        .post(pobrg_importjs.pobarangimport_paginate);
    app.route('/countpobarangimportpaginate')
        .post(pobrg_importjs.count_pobarangimportpaginate);
    app.route('/tambah_header_po_barang_import')
        .post(pobrg_importjs.tambahheaderpobarangimport);
    app.route('/tambah_detail_po_barang_import')
        .post(pobrg_importjs.tambahdetailpobarangimport);
    app.route('/tampil_po_barang_import')
        .post(pobrg_importjs.tampilpobarangimport);
    app.route('/edit_header_po_barang_import')
        .post(pobrg_importjs.editheaderpobarangimport);
    app.route('/modal_po_barang_import')
        .post(pobrg_importjs.modalpobarangimport);
    app.route('/cari_po_barang_import')
        .post(pobrg_importjs.caripobarangimport);
    app.route('/ambil_po_detail')
        .post(pobrg_importjs.ambilpodetail);
    app.route('/hapus_po_barangimport')
        .post(pobrg_importjs.hapuspobarangimport);

    ///====================/// SO ///====================///
    app.route('/sopaginate')
        .post(sojs.so_paginate);
    app.route('/countsopaginate')
        .post(sojs.count_sopaginate);
    app.route('/tambah_header_so')
        .post(sojs.tambahheaderso);
    app.route('/tambah_detail_so')
        .post(sojs.tambahdetailso);
    app.route('/tampil_so')
        .post(sojs.tampilso);
    app.route('/edit_header_so')
        .post(sojs.editheaderso);
    app.route('/modal_so')
        .post(sojs.modalso);
    app.route('/cari_so')
        .post(sojs.cariso);
    app.route('/ambil_so_detail')
        .post(sojs.ambilsodetail);
    app.route('/hapus_so')
        .post(sojs.hapusso);

    app.route('/tambah_header_surat_jalan')
        .post(jsonku.tambahheadersuratjalan);
    app.route('/tambah_detail_surat_jalan')
        .post(jsonku.tambahdetailsuratjalan);
    app.route('/tampil_surat_jalan')
        .post(jsonku.tampilsuratjalan);
    app.route('/edit_header_surat_jalan')
        .post(jsonku.editheadersuratjalan);
    app.route('/modal_surat_jalan')
        .post(jsonku.modalsuratjalan);
    app.route('/cari_surat_jalan')
        .post(jsonku.carisuratjalan);
    ///cari untuk detail penjualan
    app.route('/cari_surat_jalan_jual')
        .post(jsonku.carisuratjalanjual);
    ///
    app.route('/hapus_surat_jalan')
        .post(jsonku.hapussuratjalan);

    app.route('/tambah_header_jual')
        .post(jsonku.tambahheaderjual);
    app.route('/tambah_detail_jual')
        .post(jsonku.tambahdetailjual);
    app.route('/tampil_jual')
        .post(jsonku.tampiljual);
    app.route('/edit_header_jual')
        .post(jsonku.editheaderjual);
    app.route('/modal_jual')
        .post(jsonku.modaljual);
    app.route('/cari_jual')
        .post(jsonku.carijual);
    ///cari untuk detail jual piu
    app.route('/cari_jual_piu')
        .post(jsonku.carijualpiu);
    ///
    app.route('/hapus_jual')
        .post(jsonku.hapusjual);

    app.route('/tambah_header_po_nonbahan')
        .post(jsonku.tambahheaderpononbahan);
    app.route('/tambah_detail_po_nonbahan')
        .post(jsonku.tambahdetailpononbahan);
    app.route('/tampil_po_nonbahan')
        .post(jsonku.tampilpononbahan);
    app.route('/edit_header_po_nonbahan')
        .post(jsonku.editheaderpononbahan);
    app.route('/modal_po_nonbahan')
        .post(jsonku.modalpononbahan);
    app.route('/cari_po_nonbahan')
        .post(jsonku.caripononbahan);

    app.route('/tambah_header_po_import')
        .post(jsonku.tambahheaderpoimport);
    app.route('/tambah_detail_po_import')
        .post(jsonku.tambahdetailpoimport);
    app.route('/tampil_po_import')
        .post(jsonku.tampilpoimport);
    app.route('/edit_header_po_import')
        .post(jsonku.editheaderpoimport);
    app.route('/modal_po_import')
        .post(jsonku.modalpoimport);
    app.route('/cari_po_import')
        .post(jsonku.caripoimport);

    app.route('/tambah_header_po_mesin')
        .post(jsonku.tambahheaderpomesin);
    app.route('/tambah_detail_po_mesin')
        .post(jsonku.tambahdetailpomesin);
    app.route('/tampil_po_mesin')
        .post(jsonku.tampilpomesin);
    app.route('/edit_header_po_mesin')
        .post(jsonku.editheaderpomesin);
    app.route('/modal_po_mesin')
        .post(jsonku.modalpomesin);
    app.route('/cari_po_mesin')
        .post(jsonku.caripomesin);

    app.route('/tambah_header_po_sparepart')
        .post(jsonku.tambahheaderposparepart);
    app.route('/tambah_detail_po_sparepart')
        .post(jsonku.tambahdetailposparepart);
    app.route('/tampil_po_sparepart')
        .post(jsonku.tampilposparepart);
    app.route('/edit_header_po_sparepart')
        .post(jsonku.editheaderposparepart);
    app.route('/modal_po_sparepart')
        .post(jsonku.modalposparepart);
    app.route('/cari_po_sparepart')
        .post(jsonku.cariposparepart);

    ///====================/// PEMBELIAN BAHAN ///====================///
    app.route('/belibahanpaginate')
        .post(jsonku.belibahan_paginate);
    app.route('/countbelibahanpaginate')
        .post(jsonku.count_belibahanpaginate);
    app.route('/tambah_header_beli_bahan')
        .post(jsonku.tambahheaderbelibahan);
    app.route('/tambah_detail_beli_bahan')
        .post(jsonku.tambahdetailbelibahan);
    app.route('/tampil_beli_bahan')
        .post(jsonku.tampilbelibahan);
    app.route('/edit_header_beli_bahan')
        .post(jsonku.editheaderbelibahan);
    app.route('/modal_beli_bahan')
        .post(jsonku.modalbelibahan);
    app.route('/cari_beli_bahan')
        .post(jsonku.caribelibahan);
    ///cari untuk detail beli hut
    app.route('/cari_beli_bahan_hut')
        .post(jsonku.caribelibahanhut);
    ///
    app.route('/hapus_beli_bahan')
        .post(jsonku.hapusbelibahan);

    app.route('/tambah_header_beli_nonbahan')
        .post(jsonku.tambahheaderbelinonbahan);
    app.route('/tambah_detail_beli_nonbahan')
        .post(jsonku.tambahdetailbelinonbahan);
    app.route('/tampil_beli_nonbahan')
        .post(jsonku.tampilbelinonbahan);
    app.route('/edit_header_beli_nonbahan')
        .post(jsonku.editheaderbelinonbahan);
    app.route('/cari_beli_nonbahan')
        .post(jsonku.caribelinonbahan);

    app.route('/tambah_header_beli_import')
        .post(jsonku.tambahheaderbeliimport);
    app.route('/tambah_detail_beli_import')
        .post(jsonku.tambahdetailbeliimport);
    app.route('/tampil_beli_import')
        .post(jsonku.tampilbeliimport);
    app.route('/edit_header_beli_import')
        .post(jsonku.editheaderbeliimport);
    app.route('/cari_beli_import')
        .post(jsonku.caribeliimport);

    app.route('/tambah_header_beli_mesin')
        .post(jsonku.tambahheaderbelimesin);
    app.route('/tambah_detail_beli_mesin')
        .post(jsonku.tambahdetailbelimesin);
    app.route('/tampil_beli_mesin')
        .post(jsonku.tampilbelimesin);
    app.route('/edit_header_beli_mesin')
        .post(jsonku.editheaderbelimesin);
    app.route('/cari_beli_mesin')
        .post(jsonku.caribelimesin);

    app.route('/tambah_header_beli_sparepart')
        .post(jsonku.tambahheaderbelisparepart);
    app.route('/tambah_detail_beli_sparepart')
        .post(jsonku.tambahdetailbelisparepart);
    app.route('/tampil_beli_sparepart')
        .post(jsonku.tampilbelisparepart);
    app.route('/edit_header_beli_sparepart')
        .post(jsonku.editheaderbelisparepart);
    app.route('/cari_beli_sparepart')
        .post(jsonku.caribelisparepart);

    app.route('/hutbahanpaginate')
        .post(jsonku.hutbahan_paginate);
    app.route('/counthutbahanpaginate')
        .post(jsonku.count_hutbahanpaginate);
    app.route('/tambah_header_hut_bahan')
        .post(jsonku.tambahheaderhutbahan);
    app.route('/tambah_detail_hut_bahan')
        .post(jsonku.tambahdetailhutbahan);
    app.route('/tampil_hut_bahan')
        .post(jsonku.tampilhutbahan);
    app.route('/edit_header_hut_bahan')
        .post(jsonku.editheaderhutbahan);
    app.route('/cari_hut_bahan')
        .post(jsonku.carihutbahan);
    app.route('/ambil_hut_detail')
        .post(jsonku.ambilhutdetail);
    app.route('/hapus_hut_bahan')
        .post(jsonku.hapushutbahan);










    /// MENU TRANSAKSI HANYA HEADER
    app.route('/thut_paginate_bahan')
        .post(jsonku.thutpaginatebahan);
    app.route('/count_thutpaginate_bahan')
        .post(jsonku.countthutpaginatebahan);
    app.route('/tampil_thut_bahan')
        .post(jsonku.tampilthutbahan);
    app.route('/modal_thut_bahan')
        .post(jsonku.modalhutbahan);
    app.route('/cari_thut_bahan')
        .post(jsonku.carithutbahan);
    app.route('/tambah_thut_bahan')
        .post(jsonku.tambahthutbahan);
    app.route('/ubah_thut_bahan')
        .post(jsonku.ubahthutbahan);
    app.route('/hapus_thut_bahan')
        .post(jsonku.hapusthutbahan);

    app.route('/tpiu_paginate')
        .post(jsonku.tpiupaginate);
    app.route('/count_tpiupaginate')
        .post(jsonku.counttpiupaginate);
    app.route('/tampil_tpiu')
        .post(jsonku.tampiltpiu);
    app.route('/modal_piu')
        .post(jsonku.modalpiu);
    app.route('/cari_tpiu')
        .post(jsonku.caritpiu);
    app.route('/tambah_tpiu')
        .post(jsonku.tambahtpiu);
    app.route('/ubah_tpiu')
        .post(jsonku.ubahtpiu);
    app.route('/hapus_tpiu')
        .post(jsonku.hapustpiu);

    app.route('/tambah_header_piu')
        .post(jsonku.tambahheaderpiu);
    app.route('/tambah_detail_piu')
        .post(jsonku.tambahdetailpiu);
    app.route('/tampil_piu')
        .post(jsonku.tampilpiu);
    app.route('/edit_header_piu')
        .post(jsonku.editheaderpiu);
    app.route('/cari_piu')
        .post(jsonku.caripiu);
    app.route('/ambil_piu_detail')
        .post(jsonku.ambilpiudetail);
    app.route('/hapus_piu')
        .post(jsonku.hapuspiu);

    app.route('/thut_paginate_nonbahan')
        .post(jsonku.thutpaginatenonbahan);
    app.route('/count_thutpaginate_nonbahan')
        .post(jsonku.countthutpaginatenonbahan);
    app.route('/tampil_thut_nonbahan')
        .post(jsonku.tampilthutnonbahan);
    app.route('/modal_thut_nonbahan')
        .post(jsonku.modalthutnonbahan);
    app.route('/cari_thut_nonbahan')
        .post(jsonku.carithutnonbahan);
    app.route('/tambah_thut_nonbahan')
        .post(jsonku.tambahthutnonbahan);
    app.route('/ubah_thut_nonbahan')
        .post(jsonku.ubahthutnonbahan);
    app.route('/hapus_thut_nonbahan')
        .post(jsonku.hapusthutnonbahan);

    app.route('/thut_paginate_import')
        .post(jsonku.thutpaginateimport);
    app.route('/count_thutpaginate_import')
        .post(jsonku.countthutpaginateimport);
    app.route('/tampil_thut_import')
        .post(jsonku.tampilthutimport);
    app.route('/modal_thut_import')
        .post(jsonku.modalthutimport);
    app.route('/cari_thut_import')
        .post(jsonku.carithutimport);
    app.route('/tambah_thut_import')
        .post(jsonku.tambahthutimport);
    app.route('/ubah_thut_import')
        .post(jsonku.ubahthutimport);
    app.route('/hapus_thut_import')
        .post(jsonku.hapusthutimport);

    app.route('/thut_paginate_mesin')
        .post(jsonku.thutpaginatemesin);
    app.route('/count_thutpaginate_mesin')
        .post(jsonku.countthutpaginatemesin);
    app.route('/tampil_thut_mesin')
        .post(jsonku.tampilthutmesin);
    app.route('/modal_thut_mesin')
        .post(jsonku.modalthutmesin);
    app.route('/cari_thut_mesin')
        .post(jsonku.carithutmesin);
    app.route('/tambah_thut_mesin')
        .post(jsonku.tambahthutmesin);
    app.route('/ubah_thut_mesin')
        .post(jsonku.ubahthutmesin);
    app.route('/hapus_thut_mesin')
        .post(jsonku.hapusthutmesin);

    app.route('/thut_paginate_sparepart')
        .post(jsonku.thutpaginatesparepart);
    app.route('/count_thutpaginate_sparepart')
        .post(jsonku.countthutpaginatesparepart);
    app.route('/tampil_thut_sparepart')
        .post(jsonku.tampilthutsparepart);
    app.route('/modal_thut_sparepart')
        .post(jsonku.modalthutsparepart);
    app.route('/cari_thut_sparepart')
        .post(jsonku.carithutsparepart);
    app.route('/tambah_thut_sparepart')
        .post(jsonku.tambahthutsparepart);
    app.route('/ubah_thut_sparepart')
        .post(jsonku.ubahthutsparepart);
    app.route('/hapus_thut_sparepart')
        .post(jsonku.hapusthutsparepart);

    app.route('/popaginate')
        .post(jsonku.po_paginate);
    app.route('/countpopaginate')
        .post(jsonku.count_popaginate);
    app.route('/tampil_po')
        .post(jsonku.tampilpo);
    app.route('/modal_po')
        .post(jsonku.modalpo);
    app.route('/cari_po')
        .post(jsonku.caripo);
    app.route('/tambah_po')
        .post(jsonku.tambahpo);
    app.route('/ubah_po')
        .post(jsonku.ubahpo);
    app.route('/hapus_po')
        .post(jsonku.hapuspo);

    app.route('/tampil_pod')
        .post(jsonku.tampilpod);
    app.route('/modal_pod')
        .post(jsonku.modalpod);
    app.route('/cari_pod')
        .post(jsonku.caripod);
    app.route('/cari_pod_bahan')
        .post(jsonku.caripodbahan);
    app.route('/cari_pod_nonbahan')
        .post(jsonku.caripodnonbahan);
    app.route('/cari_pod_import')
        .post(jsonku.caripodimport);
    app.route('/cari_pod_mesin')
        .post(jsonku.caripodmesin);
    app.route('/cari_pod_sparepart')
        .post(jsonku.caripodsparepart);

    app.route('/cari_pon')
        .post(jsonku.caripon);
    app.route('/tambah_pon')
        .post(jsonku.tambahpon);
    app.route('/ubah_pon')
        .post(jsonku.ubahpon);
    app.route('/hapus_pon')
        .post(jsonku.hapuspon);


    ///paginate
    app.route('/belipaginate')
        .post(jsonku.beli_paginate);
    app.route('/countbelipaginate')
        .post(jsonku.count_belipaginate);
    ///cari dan tampil///
    app.route('/cari_beli')
        .post(jsonku.caribeli);
    app.route('/tambah_beli')
        .post(jsonku.tambahbeli);
    app.route('/ubah_beli')
        .post(jsonku.ubahbeli);
    app.route('/hapus_beli')
        .post(jsonku.hapusbeli);

    app.route('/cari_koreksi_stok')
        .post(jsonku.carikoreksistok);
    app.route('/tambah_koreksi_stok')
        .post(jsonku.tambahkoreksistok);
    app.route('/ubah_koreksi_stok')
        .post(jsonku.ubahkoreksistok);
    app.route('/hapus_koreksi_stok')
        .post(jsonku.hapuskoreksistok);

    ///TRANSAKSI HEADER DETAIL BANK
    app.route('/tambah_header_bank')
        .post(jsonku.tambahheaderbank);
    app.route('/tambah_detail_bank')
        .post(jsonku.tambahdetailbank);
    app.route('/tampil_bank_masuk')
        .post(jsonku.tampilbankmasuk);
    app.route('/tampil_bank_keluar')
        .post(jsonku.tampilbankkeluar);
    app.route('/edit_header_bank')
        .post(jsonku.editheaderbank);

    ///TRANSAKSI HEADER DETAIL MEMO
    app.route('/tambah_header_memo')
        .post(jsonku.tambahheadermemo);
    app.route('/tambah_detail_memo')
        .post(jsonku.tambahdetailmemo);
    app.route('/tampil_memo')
        .post(jsonku.tampilmemo);
    app.route('/tampil_memo')
        .post(jsonku.tampilmemo);
    app.route('/edit_header_memo')
        .post(jsonku.editheadermemo);
    app.route('/hapus_memo')
        .post(jsonku.hapusmemo);

    ///====================/// STOCK BAHAN ///====================///
    app.route('/stockbhnpaginate')
        .post(jsonku.stockbhn_paginate);
    app.route('/countstockbhnpaginate')
        .post(jsonku.count_stockbhnpaginate);
    app.route('/tambah_header_stockbhn')
        .post(jsonku.tambahheaderstockbhn);
    app.route('/tambah_detail_stockbhn')
        .post(jsonku.tambahdetailstockbhn);
    app.route('/tampil_stockbhn')
        .post(jsonku.tampilstockbhn);
    app.route('/edit_header_stockbhn')
        .post(jsonku.editheaderstockbhn);
    app.route('/modal_stockbhn')
        .post(jsonku.modalstockbhn);
    app.route('/cari_stockbhn')
        .post(jsonku.caristockbhn);
    app.route('/hapus_stockbhn')
        .post(jsonku.hapusstockbhn);

    ///TRANSAKSI HEADER DETAIL STOCKB
    app.route('/mutasibrgpaginate')
        .post(jsonku.mutasibrg_paginate);
    app.route('/countmutasibrgpaginate')
        .post(jsonku.count_mutasibrgpaginate);
    app.route('/tambah_header_mutasibrg')
        .post(jsonku.tambahheadermutasibrg);
    app.route('/tambah_detail_mutasibrg')
        .post(jsonku.tambahdetailmutasibrg);
    app.route('/tampil_mutasibrg')
        .post(jsonku.tampilmutasibrg);
    app.route('/edit_header_mutasibrg')
        .post(jsonku.editheadermutasibrg);
    app.route('/hapus_mutasibrg')
        .post(jsonku.hapusmutasibrg);

    ///====================/// PEMAKAIAN BAHAN ///====================///
    app.route('/pakaibhnpaginate')
        .post(jsonku.pakaibhn_paginate);
    app.route('/countpakaibhnpaginate')
        .post(jsonku.count_pakaibhnpaginate);
    app.route('/tambah_header_pakaibhn')
        .post(jsonku.tambahheaderpakaibhn);
    app.route('/tambah_detail_pakaibhn')
        .post(jsonku.tambahdetailpakaibhn);
    app.route('/tampil_pakaibhn')
        .post(jsonku.tampilpakaibhn);
    app.route('/edit_header_pakaibhn')
        .post(jsonku.editheaderpakaibhn);
    app.route('/modal_pakaibhn')
        .post(jsonku.modalpakaibhn);
    app.route('/cari_pakaibhn')
        .post(jsonku.caripakaibhn);
    app.route('/hapus_pakaibhn')
        .post(jsonku.hapuspakaibhn);

    ///TRANSAKSI HEADER DETAIL TERIMA
    app.route('/tambah_header_terima')
        .post(jsonku.tambahheaderterima);
    app.route('/tambah_detail_terima')
        .post(jsonku.tambahdetailterima);
    app.route('/tampil_terima')
        .post(jsonku.tampilterima);
    app.route('/edit_header_terima')
        .post(jsonku.editheaderterima);
    app.route('/hapus_terima')
        .post(jsonku.hapusterima);


    ///TRANSAKSI HEADER DETAIL STOK
    app.route('/tambah_header_stok')
        .post(jsonku.tambahheaderstok);
    app.route('/tambah_detail_stok')
        .post(jsonku.tambahdetailstok);
    app.route('/tampil_stok')
        .post(jsonku.tampilstok);
    app.route('/edit_header_stok')
        .post(jsonku.editheaderstok);





    ///MENU LAPORAN
    app.route('/lappo')
        .post(jsonku.lappo);
    app.route('/lappon')
        .post(jsonku.lappon);
    app.route('/lap_so')
        .post(jsonku.lapso);
    app.route('/lap_sj')
        .post(jsonku.lapsj);
    app.route('/lap_pobahan')
        .post(jsonku.lappobahan);
    app.route('/lap_pobahan_lokal')
        .post(jsonku.lappobahanlokal);
    app.route('/lap_belibahan')
        .post(jsonku.lapbelibahan);
    app.route('/lap_thutbahan')
        .post(jsonku.lapthutbahan);
    app.route('/lap_hutbahan')
        .post(jsonku.laphutbahan);
    app.route('/lap_jual')
        .post(jsonku.lapjual);
    app.route('/lap_stocka')
        .post(jsonku.lapstocka);
    app.route('/lap_stockb')
        .post(jsonku.lapstockb);
    app.route('/lap_pakai')
        .post(jsonku.lappakai);
    app.route('/lap_terima')
        .post(jsonku.lapterima);
    app.route('/lap_kas')
        .post(jsonku.lapkas);
    app.route('/lap_bank')
        .post(jsonku.lapbank);
    app.route('/lap_memo')
        .post(jsonku.lapmemo);
    app.route('/lap_perincianstk_bhn')
        .post(jsonku.lapperincianstk_bhn);
    app.route('/lap_perincianstk_brg')
        .post(jsonku.lapperincianstk_brg);
    app.route('/lap_perincian_hut')
        .post(jsonku.lapperincian_hut);
    app.route('/lap_perincian_piu')
        .post(jsonku.lapperincian_piu);
    app.route('/lap_perincian_nera')
        .post(jsonku.lapperincian_nera);
    app.route('/lap_kartustk_bhn')
        .post(jsonku.lapkartustk_bhn);
    app.route('/lap_kartustk_brg')
        .post(jsonku.lapkartustk_brg);
    app.route('/lap_kartu_hut')
        .post(jsonku.lapkartu_hut);
    app.route('/lap_kartu_piu')
        .post(jsonku.lapkartu_piu);
    app.route('/lap_buku_besar')
        .post(jsonku.lapbuku_besar);
    app.route('/lap_nera')
        .post(jsonku.lapnera);
    app.route('/lap_rl')
        .post(jsonku.laprl);



















    ///==================/// MODAL ///==================///
    //modal data account header kas
    app.route('/modal_acc_kas')
        .post(jsonku.modal_acckas);
    //modal data account header bank
    app.route('/modal_acc_bank')
        .post(jsonku.modal_accbank);
    //modal data account header bank
    app.route('/modal_curr')
        .post(jsonku.modal_curr);

    //modal data master bank
    app.route('/caribank')
        .post(jsonku.caribank);
    app.route('/tampilbank')
        .post(jsonku.tampilbank);
    app.route('/modal_bank_stok')
        .post(jsonku.modalbankstok);
    app.route('/tambahbank')
        .post(jsonku.tambahbank);
    app.route('/ubahbank')
        .post(jsonku.ubahbank);
    app.route('/hapusbank')
        .post(jsonku.hapusbank);

    //modal data master periode
    app.route('/cariperiode')
        .post(jsonku.cariperiode);
    app.route('/tampilperiode')
        .post(jsonku.tampilperiode);
    app.route('/modal_periode_stok')
        .post(jsonku.modalperiodestok);
    app.route('/tambahperiode')
        .post(jsonku.tambahperiode);
    app.route('/ubahperiode')
        .post(jsonku.ubahperiode);
    app.route('/hapusperiode')
        .post(jsonku.hapusperiode);

    ///SELECT DETAIL
    app.route('/select_detail')
        .post(jsonku.selectdetail);

    ///HAPUS DETAIL
    app.route('/hapus_detail')
        .post(jsonku.hapusdetail);

    ///NO URUT
    app.route('/no_urut')
        .post(jsonku.nourut);
    app.route('/no_urut_kas')
        .post(jsonku.nourutkas);
    app.route('/no_urut_bank')
        .post(jsonku.nourutbank);
    app.route('/no_urut_memo')
        .post(jsonku.nourutmemo);

    ///CHECK NO BUKTI
    app.route('/check_nobukti')
        .post(jsonku.checknobukti);

    ///
    app.route('/login')
        .post(jsonku.login);

    ///PROCEDURE
    app.route('/jualins')
        .post(jsonku.jualins);
    app.route('/jualdel')
        .post(jsonku.jualdel);
    app.route('/tpiuins')
        .post(jsonku.tpiuins);
    app.route('/tpiudel')
        .post(jsonku.tpiudel);
    app.route('/piuins')
        .post(jsonku.piuins);
    app.route('/piudel')
        .post(jsonku.piudel);

    app.route('/beliins')
        .post(jsonku.beliins);
    app.route('/belidel')
        .post(jsonku.belidel);
    app.route('/thutins')
        .post(jsonku.thutins);
    app.route('/thutdel')
        .post(jsonku.thutdel);
    app.route('/hutins')
        .post(jsonku.hutins);
    app.route('/hutdel')
        .post(jsonku.hutdel);

    app.route('/kasins')
        .post(jsonku.kasins);
    app.route('/kasdel')
        .post(jsonku.kasdel);
    app.route('/bankins')
        .post(jsonku.bankins);
    app.route('/bankdel')
        .post(jsonku.bankdel);
    app.route('/memoins')
        .post(jsonku.memoins);
    app.route('/memodel')
        .post(jsonku.memodel);

    app.route('/stockains')
        .post(jsonku.stockains);
    app.route('/stockadel')
        .post(jsonku.stockadel);
    app.route('/stockbins')
        .post(jsonku.stockbins);
    app.route('/stockbdel')
        .post(jsonku.stockbdel);
}