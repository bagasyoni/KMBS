'use strict';

module.exports = function (app) {
    var jsonku = require('./controller');

    ///======================== MASTER CONTROLLER ========================///
    // var jsonku = require('./controller/master/account_controller');
    // var jsonku = require('./controller/master/barang_controller');
    // var jsonku = require('./controller/master/bahan_controller');
    // var jsonku = require('./controller/master/customer_controller');
    // var jsonku = require('./controller/master/supplier_controller');


    ///======================== TRANSAKSI CONTROLLER ========================///
    // var jsonku = require('./controller/transaksi/po_controller');
    // var jsonku = require('./controller/transaksi/beli_controller');
    // var jsonku = require('./controller/transaksi/hut_controller');
    // var jsonku = require('./controller/transaksi/pakai_controller');
    // var jsonku = require('./controller/transaksi/stocka_controller');


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

    app.route('/accpaginate')
        .post(jsonku.acc_paginate);
    app.route('/countaccpaginate')
        .post(jsonku.count_accpaginate);
    app.route('/cariacc')
        .post(jsonku.cariacc);
    app.route('/tampilacc')
        .post(jsonku.tampilacc);
    app.route('/modal_acc_stok')
        .post(jsonku.modalaccstok);
    app.route('/tambahacc')
        .post(jsonku.tambahacc);
    app.route('/ubahacc')
        .post(jsonku.ubahacc);
    app.route('/hapusacc')
        .post(jsonku.hapusacc);

    app.route('/currpaginate')
        .post(jsonku.curr_paginate);
    app.route('/countcurrpaginate')
        .post(jsonku.count_currpaginate);
    app.route('/caricurr')
        .post(jsonku.caricurr);
    app.route('/tampilcurr')
        .post(jsonku.tampilcurr);
    app.route('/modal_curr')
        .post(jsonku.modalcurr);
    app.route('/tambahcurr')
        .post(jsonku.tambahcurr);
    app.route('/ubahcurr')
        .post(jsonku.ubahcurr);
    app.route('/hapuscurr')
        .post(jsonku.hapuscurr);

    app.route('/brgpaginate')
        .post(jsonku.brg_paginate);
    app.route('/countbrgpaginate')
        .post(jsonku.count_brgpaginate);
    app.route('/caribrg')
        .post(jsonku.caribrg);
    app.route('/tampilbrg')
        .post(jsonku.tampilbrg);
    app.route('/modal_brg_stok')
        .post(jsonku.modalbrgstok);
    app.route('/tambahbrg')
        .post(jsonku.tambahbrg);
    app.route('/ubahbrg')
        .post(jsonku.ubahbrg);
    app.route('/hapusbrg')
        .post(jsonku.hapusbrg);

    app.route('/cuspaginate')
        .post(jsonku.cus_paginate);
    app.route('/countcuspaginate')
        .post(jsonku.count_cuspaginate);
    app.route('/caricus')
        .post(jsonku.caricus);
    app.route('/tampilcus')
        .post(jsonku.tampilcus);
    app.route('/modal_cus_stok')
        .post(jsonku.modalcusstok);
    app.route('/tambahcus')
        .post(jsonku.tambahcus);
    app.route('/ubahcus')
        .post(jsonku.ubahcus);
    app.route('/hapuscus')
        .post(jsonku.hapuscus);

    app.route('/suppaginate')
        .post(jsonku.sup_paginate);
    app.route('/countsuppaginate')
        .post(jsonku.count_suppaginate);
    app.route('/carisup')
        .post(jsonku.carisup);
    app.route('/tampilsup')
        .post(jsonku.tampilsup);
    app.route('/modal_sup_stok')
        .post(jsonku.modalsupstok);
    app.route('/tambahsup')
        .post(jsonku.tambahsup);
    app.route('/ubahsup')
        .post(jsonku.ubahsup);
    app.route('/hapussup')
        .post(jsonku.hapussup);

    app.route('/bahanpaginate')
        .post(jsonku.bahan_paginate);
    app.route('/countbahanpaginate')
        .post(jsonku.count_bahanpaginate);
    app.route('/caribahan')
        .post(jsonku.caribahan);
    app.route('/tampilbahan')
        .post(jsonku.tampilbahan);
    app.route('/modal_bahan_stok')
        .post(jsonku.modalbahanstok);
    app.route('/tambahbahan')
        .post(jsonku.tambahbahan);
    app.route('/ubahbahan')
        .post(jsonku.ubahbahan);
    app.route('/hapusbahan')
        .post(jsonku.hapusbahan);

    app.route('/nonbahanpaginate')
        .post(jsonku.nonbahan_paginate);
    app.route('/countnonbahanpaginate')
        .post(jsonku.count_nonbahanpaginate);
    app.route('/carinonbahan')
        .post(jsonku.carinonbahan);
    app.route('/tampilnonbahan')
        .post(jsonku.tampilnonbahan);
    app.route('/modal_nonbahan')
        .post(jsonku.modalnonbahan);

    app.route('/mesinpaginate')
        .post(jsonku.mesin_paginate);
    app.route('/countmesinpaginate')
        .post(jsonku.count_mesinpaginate);
    app.route('/carimesin')
        .post(jsonku.carimesin);
    app.route('/tampilmesin')
        .post(jsonku.tampilmesin);
    app.route('/modal_mesin')
        .post(jsonku.modalmesin);

    app.route('/sparepartpaginate')
        .post(jsonku.sparepart_paginate);
    app.route('/countsparepartpaginate')
        .post(jsonku.count_sparepartpaginate);
    app.route('/carisparepart')
        .post(jsonku.carisparepart);
    app.route('/tampilsparepart')
        .post(jsonku.tampilsparepart);
    app.route('/modal_sparepart')
        .post(jsonku.modalsparepart);
    app.route('/tambahsparepart')
        .post(jsonku.tambahsparepart);
    app.route('/ubahsparepart')
        .post(jsonku.ubahsparepart);
    app.route('/hapussparepart')
        .post(jsonku.hapussparepart);

    app.route('/gudpaginate')
        .post(jsonku.gud_paginate);
    app.route('/countgudpaginate')
        .post(jsonku.count_gudpaginate);
    app.route('/carigud')
        .post(jsonku.carigud);
    app.route('/tampilgud')
        .post(jsonku.tampilgud);
    app.route('/tambahgud')
        .post(jsonku.tambahgud);
    app.route('/ubahgud')
        .post(jsonku.ubahgud);
    app.route('/hapusgud')
        .post(jsonku.hapusgud);


    app.route('/emklpaginate')
        .post(jsonku.emkl_paginate);
    app.route('/countemklpaginate')
        .post(jsonku.count_emklpaginate);
    app.route('/cariemkl')
        .post(jsonku.cariemkl);
    app.route('/tampilemkl')
        .post(jsonku.tampilemkl);
    app.route('/tambahemkl')
        .post(jsonku.tambahemkl);
    app.route('/ubahemkl')
        .post(jsonku.ubahemkl);
    app.route('/hapusemkl')
        .post(jsonku.hapusemkl);

    ///TRANSAKSI///
    ///====================/// PO BAHAN LOKAL ///====================///
    app.route('/pobahanlokalpaginate')
        .post(jsonku.pobahanlokal_paginate);
    app.route('/countpobahanlokalpaginate')
        .post(jsonku.count_pobahanlokalpaginate);
    app.route('/tambah_header_po_bahan_lokal')
        .post(jsonku.tambahheaderpobahanlokal);
    app.route('/tambah_detail_po_bahan_lokal')
        .post(jsonku.tambahdetailpobahanlokal);
    app.route('/tampil_po_bahan_lokal')
        .post(jsonku.tampilpobahanlokal);
    app.route('/edit_header_po_bahan_lokal')
        .post(jsonku.editheaderpobahanlokal);
    app.route('/modal_po_bahan_lokal')
        .post(jsonku.modalpobahanlokal);
    app.route('/cari_po_bahan_lokal')
        .post(jsonku.caripobahanlokal);
    app.route('/ambil_po_detail')
        .post(jsonku.ambilpodetail);
    app.route('/hapus_po_bahanlokal')
        .post(jsonku.hapuspobahanlokal);

    ///====================/// PO BAHAN IMPORT ///====================///
    app.route('/pobahanimportpaginate')
        .post(jsonku.pobahanimport_paginate);
    app.route('/countpobahanimportpaginate')
        .post(jsonku.count_pobahanimportpaginate);
    app.route('/tambah_header_po_bahan_import')
        .post(jsonku.tambahheaderpobahanimport);
    app.route('/tambah_detail_po_bahan_import')
        .post(jsonku.tambahdetailpobahanimport);
    app.route('/tampil_po_bahan_import')
        .post(jsonku.tampilpobahanimport);
    app.route('/edit_header_po_bahan_import')
        .post(jsonku.editheaderpobahanimport);
    app.route('/modal_po_bahan_import')
        .post(jsonku.modalpobahanimport);
    app.route('/cari_po_bahan_import')
        .post(jsonku.caripobahanimport);
    app.route('/ambil_po_detail')
        .post(jsonku.ambilpodetail);
    app.route('/hapus_po_bahanimport')
        .post(jsonku.hapuspobahanimport);

    app.route('/sopaginate')
        .post(jsonku.so_paginate);
    app.route('/countsopaginate')
        .post(jsonku.count_sopaginate);
    app.route('/tambah_header_so')
        .post(jsonku.tambahheaderso);
    app.route('/tambah_detail_so')
        .post(jsonku.tambahdetailso);
    app.route('/tampil_so')
        .post(jsonku.tampilso);
    app.route('/edit_header_so')
        .post(jsonku.editheaderso);
    app.route('/modal_so')
        .post(jsonku.modalso);
    app.route('/cari_so')
        .post(jsonku.cariso);
    app.route('/ambil_so_detail')
        .post(jsonku.ambilsodetail);
    app.route('/hapus_so')
        .post(jsonku.hapusso);

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


    app.route('/cari_so')
        .post(jsonku.cariso);
    app.route('/tambah_so')
        .post(jsonku.tambahso);
    app.route('/ubah_so')
        .post(jsonku.ubahso);
    app.route('/hapus_so')
        .post(jsonku.hapusso);


    app.route('/cari_koreksi_stok')
        .post(jsonku.carikoreksistok);
    app.route('/tambah_koreksi_stok')
        .post(jsonku.tambahkoreksistok);
    app.route('/ubah_koreksi_stok')
        .post(jsonku.ubahkoreksistok);
    app.route('/hapus_koreksi_stok')
        .post(jsonku.hapuskoreksistok);


    ///TRANSAKSI HEADER DETAIL KAS
    app.route('/tambah_header_kas')
        .post(jsonku.tambahheaderkas);
    app.route('/tambah_detail_kas')
        .post(jsonku.tambahdetailkas);
    app.route('/tampil_kas_masuk')
        .post(jsonku.tampilkasmasuk);
    app.route('/tampil_kas_keluar')
        .post(jsonku.tampilkaskeluar);
    app.route('/edit_header_kas')
        .post(jsonku.editheaderkas);


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

    ///TRANSAKSI HEADER DETAIL STOCKA
    app.route('/tambah_header_mutasibhn')
        .post(jsonku.tambahheadermutasibhn);
    app.route('/tambah_detail_mutasibhn')
        .post(jsonku.tambahdetailmutasibhn);
    app.route('/tampil_mutasibhn')
        .post(jsonku.tampilmutasibhn);
    app.route('/edit_header_mutasibhn')
        .post(jsonku.editheadermutasibhn);
    app.route('/hapus_mutasibhn')
        .post(jsonku.hapusmutasibhn);

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

    ///TRANSAKSI HEADER DETAIL PAKAI
    app.route('/tambah_header_pakaibahan')
        .post(jsonku.tambahheaderpakaibahan);
    app.route('/tambah_detail_pakaibahan')
        .post(jsonku.tambahdetailpakaibahan);
    app.route('/tampil_pakaibahan')
        .post(jsonku.tampilpakaibahan);
    app.route('/edit_header_pakaibahan')
        .post(jsonku.editheaderpakaibahan);
    app.route('/hapus_pakaibahan')
        .post(jsonku.hapuspakaibahan);

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