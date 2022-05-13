'use strict';

var response = require('./res');
var connection = require('./koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///=================/// TRANSAKSI PO BAHAN LOKAL ///=================///
exports.pobahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pobahanpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where KODES like ? or NAMAS like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
///HEADER
exports.tambahheaderpo = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into po (NO_BUKTI,DR,KODES,NAMAS,TGL,JTEMPO,KOTA,ALAMAT,KURS,RATE,PROD,JENIS,SUBDIV,AN,NOTESBL,NOTESKRM,KET,PKP,TOTAL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpo = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var KD_BRG = req.body.kode_barang;
    var NA_BRG = req.body.nama_barang;
    var SATUAN_PPC = req.body.satuan_ppc;
    var QTY_PPC = req.body.qty_ppc;
    var SATUAN = req.body.satuan;
    var HARGA = req.body.harga;
    var TOTAL = Number(req.body.total);
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into pod (REC,NO_BUKTI,PER,KD_BHN,NA_BHN,SATUANPP,QTYPP,SATUAN,HARGA,TOTAL,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, KD_BRG, NA_BRG, SATUAN_PPC, QTY_PPC, SATUAN, HARGA, TOTAL, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpo = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND TYPE='BBM'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpo = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE po set DR=?, KODES=?, NAMAS=?, TGL=?, JTEMPO=?, KOTA=?,ALAMAT=?, KURS=?, RATE=?, PROD=?, JENIS=?, SUBDIV=?, AN=?, NOTESBL=?, NOTESKRM=?, KET=?, PKP=?, TOTAL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

///TRANSAKSI HEADER DETAIL PO BAHAN
///HEADER
exports.tambahheaderpobahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
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
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;
    connection.query("insert into po (NO_BUKTI,TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, BRAND, rateks, ACNO1, ACNO1_NM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Po Bahan Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpobahan = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var NO_PP = req.body.NO_PP;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var QTY = req.body.QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var KET = req.body.KET;
    var HARGA1 = req.body.HARGA1;
    var TOTAL1 = req.body.TOTAL1;
    var ID = req.body.ID;
    var BLT = req.body.BLT;
    var DISC = req.body.DISC;
    var RPDISC = req.body.RPDISC;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var SIZ = req.body.SIZ;
    var KD = req.body.KD;
    var KODECAB = req.body.KODECAB;
    var WARNA = req.body.WARNA;
    var PRODUK = req.body.PRODUK;
    var GRP = req.body.GRP;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;

    connection.query("insert into pod (REC, NO_BUKTI, PER, FLAG, NO_PP, KD_BHN, NA_BHN, SATUAN, QTY, SISA_QTY, HARGA, TOTAL, KET, HARGA1, TOTAL1, ID, BLT, DISC, RPDISC, TYP, GOL, SIZ, KD, KODECAB, WARNA, PRODUK, GRP, ACNO, ACNO_NM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, FLAG, NO_PP, KD_BHN, NA_BHN, SATUAN, QTY, SISA_QTY, HARGA, TOTAL, KET, HARGA1, TOTAL1, ID, BLT, DISC, RPDISC, TYP, GOL, SIZ, KD, KODECAB, WARNA, PRODUK, GRP, ACNO, ACNO_NM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpobahan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PO' AND PER=?", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpobahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = (req.body.SISA_QTY)-(req.body.KIRIM);
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = (req.body.NETT)-(req.body.BAYAR);
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("UPDATE po set TGL=?, JTEMPO=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, SISA_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP WHERE NO_BUKTI=?", [TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRNM,TG_SMP,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

exports.modalpobahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripobahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PO' and NO_BUKTI IN (SELECT NO_BUKTI FROM pod WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspobahan = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from po where NO_BUKTI=?; DELETE from pod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}