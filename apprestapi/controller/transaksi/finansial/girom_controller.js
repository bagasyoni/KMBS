'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI GIRO MASUK ///========================///
exports.girom_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from giro where NO_BUKTI like ? or BACNO like ? or BNAMA like ? or KODE like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_girompaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from giro where TYPE='BGM' and (NO_BUKTI like ? or BACNO like ? or BNAMA like ? or FLAG='G')", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheadergirom = function (req, res) {
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
    var JUMLAH1 = req.body.JUMLAH1;
    var JUMLAH = req.body.JUMLAH;
    var USRIN = req.body.USRIN;
    var PER = req.body.PER;
    var TG_IN = req.body.TG_IN;
    var BG = req.body.BG;
    var JTEMPO = req.body.JTEMPO;
    var FLAG = req.body.FLAG;

    connection.query("INSERT INTO giro (NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, JUMLAH1, JUMLAH, USRIN, PER, TG_IN, BG, JTEMPO, FLAG) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, JUMLAH1, JUMLAH, USRIN, PER, TG_IN, BG, JTEMPO, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Giro Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailgirom = function (req, res) {
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

    connection.query("INSERT INTO girod (REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE giro, girod SET girod.ID = giro.NO_ID WHERE girod.NO_BUKTI = giro.NO_BUKTI;", [REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, NO_FAKTUR, URAIAN, JUMLAHINV, JUMLAH,JUMLAH1, FLAG, UM, CURRD, RATED, NOINV],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Giro Detail', res);

            }
        });
};

exports.tampilgirom = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from giro where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='G' AND PER=? AND TYPE='BGM'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheadergirom = function (req, res) {
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
    var JUMLAH1 = req.body.JUMLAH1;
    var JUMLAH = req.body.JUMLAH;
    var USRIN = req.body.USRIN;
    var PER = req.body.PER;
    var TG_IN = req.body.TG_IN;
    var BG = req.body.BG;
    var JTEMPO = req.body.JTEMPO;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE giro set TGL=?, TYPE=?, BACNO=?, BNAMA=?, CURR=?, CURRNM=?, RATE=?, KODE=?, NAMA=?, KET=?, JUMLAH1=?, JUMLAH=?, USRIN=?, PER=?, TG_IN=?, BG=?, JTEMPO=?, FLAG=? WHERE NO_BUKTI=?", [TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KODE, NAMA, KET, JUMLAH1, JUMLAH, USRIN, PER, TG_IN, BG, JTEMPO, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Giro Header', res);

            }
        });
};

exports.modalgirom = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from giro where BACNO like ? or BNAMA like ? order by BACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from giro order by BACNO",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.carigirom = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from giro where (BACNO like ? or BNAMA like ? or KODE like ? or NAMA like ?) and FLAG='G' and TYPE='BGM'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusgirom = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from giro where NO_BUKTI=?; DELETE from girod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilgiromdetail = function (req, res) {
    var nobukti = req.body.cari;
    connection.query("SELECT * from giro where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}