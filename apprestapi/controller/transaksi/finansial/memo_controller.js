'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// TRANSAKSI MEMO ///========================///
exports.memo_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from memo where NO_BUKTI like ? or BACNO like ? or BNAMA like ? or  LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_memopaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from memo where TYP='' and (NO_BUKTI like ? or BACNO like ? or BNAMA like ? or FLAG='M')", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheadermemo = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var TYPE = req.body.TYPE;
    var BACNO = req.body.BACNO;
    var BNAMA = req.body.BNAMA;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var DEBET = req.body.DEBET;
    var KREDIT = req.body.KREDIT;
    var DEBET1 = req.body.DEBET11;
    var KREDIT1 = req.body.KREDIT1;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;

    connection.query("INSERT INTO memo (NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KET, PER, DEBET, KREDIT, DEBET1, KREDIT1, USRIN, TG_IN, FLAG) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KET, PER, DEBET, KREDIT, DEBET1, KREDIT1, USRIN, TG_IN, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailmemo = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var REC = req.body.REC;
    var PER = req.body.PER;
    var TYPE = req.body.TYPE;
    var ACNO = req.body.ACNO;
    var NACNO = req.body.NACNO;
    var ACNOB = req.body.ACNOB;
    var NACNOB = req.body.NACNOB;
    var URAIAN = req.body.URAIAN;
    var DEBET = req.body.DEBET;
    var DEBET1 = req.body.DEBET1;
    var KREDIT = req.body.KREDIT;
    var KREDIT1 = req.body.KREDIT1;
    var JUMLAH = req.body.JUMLAH;
    var JUMLAH1 = req.body.JUMLAH1;
    var FLAG = req.body.FLAG;

    connection.query("INSERT INTO memod (REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, ACNOB, NACNOB, URAIAN, DEBET, DEBET1, KREDIT, KREDIT1, JUMLAH, JUMLAH1, FLAG) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE memo, memod SET memod.ID = memo.NO_ID WHERE memod.NO_BUKTI = memo.NO_BUKTI;", [REC, NO_BUKTI, PER, TYPE, ACNO, NACNO, ACNOB, NACNOB, URAIAN, DEBET, DEBET1, KREDIT, KREDIT1, JUMLAH, JUMLAH1, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Detail', res);

            }
        });
};

exports.tampilmemo = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from memo where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='M' AND PER=? AND TYP=''", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheadermemo = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var TYPE = req.body.TYPE;
    var BACNO = req.body.BACNO;
    var BNAMA = req.body.BNAMA;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var DEBET = req.body.DEBET;
    var KREDIT = req.body.KREDIT;
    var DEBET1 = req.body.DEBET11;
    var KREDIT1 = req.body.KREDIT1;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE memo set TGL=?, TYPE=?, BACNO=?, BNAMA=?, CURR=?, CURRNM=?, RATE=?, KET=?, PER=?, DEBET=?, KREDIT=?, DEBET1=?, KREDIT1=?, USRIN=?, TG_IN=?, FLAG=? WHERE NO_BUKTI=?", [TGL, TYPE, BACNO, BNAMA, CURR, CURRNM, RATE, KET, PER, DEBET, KREDIT, DEBET1, KREDIT1, USRIN, TG_IN, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Memo Header', res);

            }
        });
};

exports.modalmemo = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from memo where BACNO like ? or BNAMA like ? order by BACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from memo order by BACNO",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.carimemo = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from memo where (BACNO like ? or BNAMA like ? or KODE like ? or NAMA like ?) and FLAG='M' and TYPE=''", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusmemo = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from memo where NO_BUKTI=?; DELETE from memod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilmemodetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from memo where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}