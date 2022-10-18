'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI BELI INVOICE ///========================///
exports.beliinvoice_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from hutangh where FLAG<>'UM' and TYP='I' and GOL='A' and (KODES like ? or NAMAS like ? LIMIT ?, ?)", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_beliinvoicepaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from hutangh where FLAG<>'UM' and TYP='I' and GOL='A' and (KODES like ? or NAMAS like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderbeliinvoice = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var FLAG = req.body.FLAG;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var TOTALHTG = req.body.TOTALHTG;
    var TOTALINV = req.body.TOTALINV;
    var JUMLAHRP = req.body.JUMLAHRP;
    var TYP = req.body.TYP;
    var BYR = req.body.BYR;

    connection.query("INSERT INTO hutangh (NO_BUKTI,TGL,KODES,NAMAS,FLAG,CURR,CURRNM,TOTALHTG,TOTALINV,JUMLAHRP,TYP,BYR) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI,TGL,KODES,NAMAS,FLAG,CURR,CURRNM,TOTALHTG,TOTALINV,JUMLAHRP,TYP,BYR],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil !!!', res);

            }
        });
};

///DETAIL
exports.tambahdetailbeliinvoice = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var FLAG = req.body.FLAG;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var ACNO = req.body.ACNO;
    var NACNO = req.body.NACNO;
    var NOUP = req.body.NOUP;
    var JUMLAHRP = req.body.JUMLAHRP;
    var TYP = req.body.TYP;
    var BYR = req.body.BYR;
    var NOTES = req.body.NOTES;
    var RATE = req.body.RATE;

    connection.query("INSERT INTO hutang (NO_BUKTI, REC, TGL, KODES, NAMAS, FLAG, CURR, CURRNM, NETT, SISA, ACNO, NACNO, NOUP, JUMLAHRP, TYP, BYR, NOTES, RATE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE hutangh, hutang SET hutang.ID = hutangh.NO_ID WHERE hutang.NO_BUKTI = hutangh.NO_BUKTI;", [NO_BUKTI, REC, TGL, KODES, NAMAS, FLAG, CURR, CURRNM, NETT, SISA, ACNO, NACNO, NOUP, JUMLAHRP, TYP, BYR, NOTES, RATE],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil !!!', res);

            }
        });
};

exports.tampilbeliinvoice = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("SELECT * FROM hutangh WHERE IF(?<>'',NO_BUKTI LIKE ?,TRUE) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND PER=? AND TYP='I' AND GOL='A' AND INVOICEX<>'' AND INVOICE<>''", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbeliinvoice = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var FLAG = req.body.FLAG;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var TOTALHTG = req.body.TOTALHTG;
    var TOTALINV = req.body.TOTALINV;
    var JUMLAHRP = req.body.JUMLAHRP;
    var TYP = req.body.TYP;
    var BYR = req.body.BYR;

    connection.query("UPDATE hutangh SET TGL=?, KODES=?, NAMAS=?, FLAG=?, CURR=?, CURRNM=?, TOTALHTG=?, TOTALINV=?, JUMLAHRP=?, TYP=?, BYR=?  WHERE NO_BUKTI=?", [TGL, KODES, NAMAS, FLAG, CURR, CURRNM, TOTALHTG, TOTALINV, JUMLAHRP, TYP, BYR, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil !!!', res);

            }
        });
};

exports.modalbeliinvoice = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from hutangh where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from hutangh order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caribeliinvoice = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from hutangh where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='BL' and NO_BUKTI IN (SELECT NO_BUKTI FROM hutang WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusbeliinvoice = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from hutangh where NO_BUKTI=?; DELETE from hutang where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilbeliinvoicedetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from hutangh where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}