'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER HS ///========================///
//paginate
exports.hs_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from hs where NO_HS like ? or URAIAN like ? or KD_SATUAN like ? or KD_BRG like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_hspaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from hs where NO_HS like ? or URAIAN like ? or KD_SATUAN like ? or KD_BRG like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

exports.carihs = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from hs where NO_HS like ? or URAIAN like ? or KD_SATUAN like ? or KD_BRG like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data hs
exports.tampilhs = function (req, res) {
    connection.query("select * from hs", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data hs
exports.modalhs = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from hs where NO_HS like ? or URAIAN like ? order by NO_HS", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from hs order by NO_HS",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data hs
exports.tambahhs = function (req, res) {
    var NO_HS = req.body.NO_HS;
    var URAIAN = req.body.URAIAN;
    var KD_SATUAN = req.body.KD_SATUAN;
    var KD_BRG = req.body.KD_BRG;
    var KDJENIS = req.body.KDJENIS;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("insert into hs (NO_HS,URAIAN,KD_SATUAN,KD_BRG,KDJENIS,USRNM,TG_SMP) values (?,?,?,?,?,?,?)", [NO_HS,URAIAN,KD_SATUAN,KD_BRG,KDJENIS,USRNM,TG_SMP],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data hs
exports.ubahhs = function (req, res) {
    var ID_HS = req.body.ID_HS;
    var NO_HS = req.body.NO_HS;
    var URAIAN = req.body.URAIAN;
    var KD_SATUAN = req.body.KD_SATUAN;
    var KD_BRG = req.body.KD_BRG;
    var KDJENIS = req.body.KDJENIS;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE hs SET NO_HS=?, URAIAN=?, KD_SATUAN=?, KD_BRG=?, KDJENIS=?, USRNM=?, TG_SMP=? where ID_HS = ? ", [NO_HS, URAIAN, KD_SATUAN, KD_BRG, KDJENIS, USRNM, TG_SMP, ID_HS],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });

};
//delete data hs
exports.hapushs = function (req, res) {
    var ID_HS = req.body.ID_HS;
    connection.query("DELETE FROM hs WHERE ID_HS=? ", [ID_HS],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data HS', res);

            }
        });
};
///check no
exports.checkhs = function (req, res) {
    var nobukti = req.body.cari;
    var tabelx = req.body.tabel;
    var kolomx = req.body.kolom;

    connection.query("SELECT * from ?? where ??=?", [tabelx, kolomx, nobukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}