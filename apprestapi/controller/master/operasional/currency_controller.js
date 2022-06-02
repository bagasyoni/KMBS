'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER CURRENCY ///========================///
//paginate
exports.curr_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from curr where KODE like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_currpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from curr where KODE like ? or NAMA like ? order by KODE", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

//menampilkan cari currency
exports.caricurr = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from curr where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data currency
exports.tampilcurr = function (req, res) {
    connection.query("select * from curr order by kode", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data currency
exports.modalcurr = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from curr where KODE like ? or NAMA like ? order by KODE", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from curr order by KODE",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data currency
exports.tambahcurr = function (req, res) {
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var RATE = req.body.RATE;
    var RATE_BYR = req.body.RATE_BYR;
    var TGL = req.body.TGL;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("insert into curr (KODE, NAMA, RATE, RATE_BYR, TGL, USRNM, TG_SMP) values (?,?,?,?,?,?,?); CALL currddins(?);", [KODE, NAMA, RATE, RATE_BYR, TGL, USRNM, TG_SMP, KODE],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahcurr = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var RATE = req.body.RATE;
    var RATE_BYR = req.body.RATE_BYR;
    var TGL = req.body.TGL;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE curr SET KODE=?, NAMA=?, RATE=?, RATE_BYR=?, TGL=?, USRNM=?, TG_SMP=? where NO_ID = ? ", [KODE, NAMA, RATE, RATE_BYR, TGL, USRNM, TG_SMP, NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data curr
exports.hapuscurr = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM curr WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};