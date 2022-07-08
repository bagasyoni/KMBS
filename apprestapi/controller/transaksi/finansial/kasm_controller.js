'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI KAS MASUK ///========================///
exports.kasm_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from kas where NO_BUKTI like ? or BACNO like ? or BNAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_kasmpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from kas where TYPE='BKM' and (NO_BUKTI like ? or BACNO like ? or BNAMA like ?)", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderkasm = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var TYPE = req.body.TYPE;
    var BACNO = req.body.BACNO;
    var BNAMA = req.body.BNAMA;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var JUMLAH1 = req.body.JUMLAH1;
    var JUMLAH = req.body.JUMLAH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var UM = req.body.UM;
    var KODECAB = req.body.KODECAB;
    var NAMACAB = req.body.NAMACAB;
    var BRAND = req.body.BRAND;
    var TC = req.body.TC;
    var FLAG = req.body.FLAG;

    connection.query("INSERT INTO kas (NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, KODECAB, NAMACAB, BRAND, TC, FLAG) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, KODECAB, NAMACAB, BRAND, TC, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailkasm = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var REC = req.body.REC;
    var PER = req.body.PER;
    var TYPE = req.body.TYPE;
    var ACNO = req.body.ACNO;
    var NACNO = req.body.NACNO;
    var NO_FAKTUR = req.body.NO_FAKTUR;
    var URAIAN = req.body.URAIAN;
    var JUMLAHINV = req.body.JUMLAHINV;
    var JUMLAH = req.body.JUMLAH;
    var JUMLAH1 = req.body.JUMLAH1;
    var FLAG = req.body.FLAG;
    var UM = req.body.UM;
    var CURRD = req.body.CURRD;
    var RATED = req.body.RATED;
    var NOINV = req.body.NOINV;

    connection.query("INSERT INTO kasd (REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE kas, kasd SET kasd.ID = kas.NO_ID WHERE kasd.NO_BUKTI = kas.NO_BUKTI;", [REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Detail', res);

            }
        });
};

exports.tampilkasm = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from kas where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND PER=? AND TYPE='BKM'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderkasm = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var TYPE = req.body.TYPE;
    var BACNO = req.body.BACNO;
    var BNAMA = req.body.BNAMA;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var JUMLAH1 = req.body.JUMLAH1;
    var JUMLAH = req.body.JUMLAH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var UM = req.body.UM;
    var KODECAB = req.body.KODECAB;
    var NAMACAB = req.body.NAMACAB;
    var BRAND = req.body.BRAND;
    var TC = req.body.TC;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE kas set TGL=?, TYPE=?, BACNO=?, BNAMA=?, CURR=?, CURRNM=?, RATE=?, KODE=?, NAMA=?, KET=?, PER=?, JUMLAH1=?, JUMLAH=?, USRIN=?, TG_IN=?, UM=?, KODECAB=?, NAMACAB=?, BRAND=?, TC=?, FLAG=? WHERE NO_BUKTI=?", [TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, KODECAB, NAMACAB, BRAND, TC, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Kas Header', res);

            }
        });
};

exports.modalkasm = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from kas where BACNO like ? or BNAMA like ? order by BACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from kas order by BACNO",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.carikasm = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from kas where (BACNO like ? or BNAMA like ? or KODE like ? or NAMA like ?) and TYPE='BKM'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuskasm = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from kas where NO_BUKTI=?; DELETE from kasd where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilkasmdetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from kas where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

exports.caripiutang = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("SELECT * FROM (SELECT piu.NO_BUKTI, piu.TGL, piu.KODEC, piu.NAMAC, piud.ACNO, account.NAMA AS NACNO, SUM(piud.HSISA) AS SISA, ROUND(SUM((HSISA/HTOTAL) * JUMLAHRP),4) AS JUMLAHRP, CONCAT(TRIM(piud.NO_BUKTI), TRIM(piud.ACNO)) AS INFO, piu.FLAG, piu.CURR, piu.RATE, '' AS NOINV FROM piu, piud, account WHERE piu.NO_BUKTI=piud.NO_BUKTI AND piud.HSISA<>0 AND piud.ACNO=account.ACNO GROUP BY piu.NO_BUKTI, piud.ACNO UNION ALL SELECT piutang.NO_BUKTI, piutang.TGL, piutang.KODEC, piutang.NAMAC, piutang.ACNO, account.NAMA AS NACNO, SUM(piutang.SISA) AS SISA, ROUND(SUM((SISA/NETT)*JUMLAHRP),4) AS JUMLAHRP, CONCAT (TRIM(piutang.NO_BUKTI), TRIM(piutang.ACNO)) AS INFO, piutang.FLAG, piutang.CURR, piutang.RATE, '' AS NOINV FROM piutang, account WHERE piutang.ACNO=account.ACNO AND piutang.flag='UM' AND piutang.SISA<>0 GROUP BY piutang.NO_BUKTI, piutang.ACNO) AS BBB WHERE NO_BUKTI<>'' AND (NO_BUKTI LIKE ? OR ACNO LIKE ? OR NACNO LIKE ?)", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}