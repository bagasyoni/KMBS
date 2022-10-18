'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI BTB BARANG IMPORT ///========================///
exports.btbbarangimport_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where TYP='I' and GOL='B' and (KODES like ? or NAMAS like ? LIMIT ?, ?)", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_btbbarangimportpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where TYP='I' and GOL='B' and (KODES like ? or NAMAS like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderbtbbarangimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var SISA = req.body.SISA;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var NO_SJ = req.body.NO_SJ;
    var TGL_SJ = req.body.TGL_SJ;
    var INVOICE = req.body.INVOICE;
    var NO_FP = req.body.NO_FP;
    var TGL_FP = req.body.TGL_FP;
    var RATEKS = req.body.RATEKS;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;
    var NO_PO = req.body.NO_PO;
    var KODE = req.body.KODE;
    var TOTALBTB = req.body.TOTALBTB;

    connection.query("INSERT INTO beli (NO_BUKTI,TGL,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL1,DISC,PPN,NETT1,SISA,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,NO_SJ,TGL_SJ,INVOICE,NO_FP,TGL_FP,RATEKS,ACNO1,ACNO1_NM,NO_PO,KODE,TOTALBTB) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL,CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL1, DISC, PPN, NETT1, SISA, DISC1, PPN1,PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, NO_SJ,TGL_SJ, INVOICE, NO_FP, TGL_FP, RATEKS, ACNO1, ACNO1_NM, NO_PO, KODE, TOTALBTB],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Bukti Terima Barang Import Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbtbbarangimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var REC = req.body.REC;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var NO_PO = req.body.NO_PO;
    var QTYPO = req.body.QTYPO;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var QTY = req.body.QTY;
    var SATUANBL = req.body.SATUANBL;
    var QTYBL = req.body.QTYBL;
    var HARGA1 = req.body.HARGA1;
    var TOTAL1 = req.body.TOTAL1;
    var KET = req.body.KET;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var BLT = req.body.BLT;
    var DISC = req.body.DISC;
    var RPDISC = req.body.RPDISC;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var HTG = req.body.HTG;
    var SIZ = req.body.SIZ;
    var KD = req.body.KD;
    var KODECAB = req.body.KODECAB;
    var WARNA = req.body.WARNA;
    var PRODUK = req.body.PRODUK;
    var GRP = req.body.GRP;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;

    connection.query("INSERT INTO belid (NO_BUKTI, REC, PER, FLAG, NO_PO, QTYPO, KD_BRG, NA_BRG, SATUAN, QTY, SATUANBL, QTYBL, HARGA1, TOTAL1, KET, HARGA, TOTAL, BLT, DISC, RPDISC, TYP, GOL, HTG, SIZ, KD, KODECAB, WARNA, PRODUK, GRP, ACNO, ACNO_NM) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE beli, belid SET belid.ID = beli.NO_ID WHERE belid.NO_BUKTI = beli.NO_BUKTI;", [NO_BUKTI, REC, PER, FLAG, NO_PO, QTYPO, KD_BRG, NA_BRG, SATUAN, QTY, SATUANBL, QTYBL, HARGA1, TOTAL1, KET, HARGA, TOTAL, BLT, DISC, RPDISC, TYP, GOL, HTG, SIZ, KD, KODECAB, WARNA, PRODUK, GRP, ACNO, ACNO_NM],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Bukti Terima Barang Import Detail', res);

            }
        });
};

exports.tampilbtbbarangimport = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("SELECT * FROM beli WHERE IF(?<>'',NO_BUKTI LIKE ?,TRUE) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND PER=? AND TYP='I' AND GOL='B'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbtbbarangimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var SISA = req.body.SISA;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var NO_SJ = req.body.NO_SJ;
    var TGL_SJ = req.body.TGL_SJ;
    var INVOICE = req.body.INVOICE;
    var NO_FP = req.body.NO_FP;
    var TGL_FP = req.body.TGL_FP;
    var RATEKS = req.body.RATEKS;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;
    var NO_PO = req.body.NO_PO;
    var KODE = req.body.KODE;
    var TOTALBTB = req.body.TOTALBTB;

    connection.query("UPDATE beli SET TGL=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, SISA=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRIN=?, TG_IN=?, FLAG=?, PER=?, TYP=?, GOL=?, NO_SJ=?,TGL_SJ=?, INVOICE=?, NO_FP=?, TGL_FP=?, RATEKS=?, ACNO1=?, ACNO1_NM=?, NO_PO=?, KODE=?, TOTALBTB=? WHERE NO_BUKTI=?", [TGL,CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL1, DISC, PPN, NETT1, SISA, DISC1, PPN1,PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, NO_SJ,TGL_SJ, INVOICE, NO_FP, TGL_FP, RATEKS, ACNO1, ACNO1_NM, NO_PO, KODE, TOTALBTB, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Bukti Terima Barang Import Header', res);

            }
        });
};

exports.modalbtbbarangimport = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caribtbbarangimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='BL' and NO_BUKTI IN (SELECT NO_BUKTI FROM belid WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusbtbbarangimport = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from beli where NO_BUKTI=?; DELETE from belid where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilbtbdetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from beli where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}