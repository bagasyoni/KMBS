'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER TOKO ///========================///
//paginate
exports.toko_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from toko where KODE like ? or NAMA like ? or ALAMAT like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_tokopaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from toko where KODE like ? or NAMA like ? or ALAMAT like ? order by KODE", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

//menampilkan cari toko
exports.caritoko = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from toko where KODE like ? or NAMA like ? or ALAMAT like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data toko
exports.tampiltoko = function (req, res) {
    connection.query("select * from toko order by kode", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data toko
exports.modaltoko = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from toko where KODE like ? or NAMA like ? order by KODE", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from toko order by KODE",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data toko
exports.tambahtoko = function (req, res) {
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON = req.body.TELPON;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("insert into toko (KODE, NAMA, ALAMAT, KOTA, TELPON, USRNM, TG_SMP) values (?,?,?,?,?,?,?)", [KODE, NAMA, ALAMAT, KOTA, TELPON, USRNM, TG_SMP],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahtoko = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON = req.body.TELPON;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE toko SET KODE=?, NAMA=?, ALAMAT=?, KOTA=?, TELPON=?, USRNM=?, TG_SMP=? where NO_ID = ? ", [KODE, NAMA, ALAMAT, KOTA, TELPON, USRNM, TG_SMP, NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data toko
exports.hapustoko = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM toko WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};