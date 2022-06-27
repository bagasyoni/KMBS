'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI BANK KELUAR ///========================///
exports.bankk_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bank where NO_BUKTI like ? or BACNO like ? or BNAMA like ?  LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_bankkpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bank where TYPE='BBK' and (NO_BUKTI like ? or BACNO like ? or BNAMA like ? or FLAG='B')", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderbankk = function (req, res) {
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
    var FLAG = req.body.FLAG;

    connection.query("INSERT INTO bank (NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, FLAG) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbankk = function (req, res) {
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

    connection.query("INSERT INTO bankd (REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE bank, bankd SET bankd.ID = bank.NO_ID WHERE bankd.NO_BUKTI = bank.NO_BUKTI;", [REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Detail', res);

            }
        });
};

exports.tampilbankk = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from bank where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='B' AND PER=? AND TYPE='BBK'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbankk = function (req, res) {
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
    var FLAG = req.body.FLAG;

    connection.query("UPDATE bank set TGL=?, TYPE=?, BACNO=?, BNAMA=?, CURR=?, CURRNM=?, RATE=?, KODE=?, NAMA=?, KET=?, PER=?, JUMLAH1=?, JUMLAH=?, USRIN=?, TG_IN=?, UM=?, UM=?, FLAG=? WHERE NO_BUKTI=?", [TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, PER, JUMLAH1, JUMLAH, USRIN, TG_IN, UM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Bank Header', res);

            }
        });
};

exports.modalbankk = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bank where BACNO like ? or BNAMA like ? order by BACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bank order by BACNO",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caribankk = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bank where (BACNO like ? or BNAMA like ? or KODE like ? or NAMA like ?) and FLAG='K' and TYPE='BBK'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusbankk = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from bank where NO_BUKTI=?; DELETE from bankd where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilbankkdetail = function (req, res) {
    var nobukti = req.body.cari;
    connection.query("SELECT * from bank where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}