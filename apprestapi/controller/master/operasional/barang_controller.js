'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER BARANG ///========================///
///paginate
exports.brg_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from brg where KD_BRG like ? or NA_BRG like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_brgpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from brg where KD_BRG like ? or NA_BRG like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

//menampilkan cari barang
exports.caribrg = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from brg where KD_BRG like ? or NA_BRG like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilbrg = function (req, res) {
    connection.query("select * from brg", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal barang
exports.modalbrgstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from brg where KD_BRG like ? or NA_BRG like ? order by KD_BRG", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from brg order by KD_BRG",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data barang
exports.tambahbrg = function (req, res) {
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;
    var PRODUK = req.body.PRODUK;
    var SIZ = req.body.SIZ;
    var WARNA = req.body.WARNA;
    var JENIS = req.body.JENIS;
    var NOTES = req.body.NOTES;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    
    connection.query("insert into brg (KD_BRG, NA_BRG, SATUAN, ACNO, ACNO_NM, PRODUK, SIZ, WARNA, JENIS, NOTES, USRNM, TG_SMP) values (?,?,?,?,?,?,?,?,?,?,?,?); CALL brgdins(?);", [KD_BRG, NA_BRG, SATUAN, ACNO, ACNO_NM, PRODUK, SIZ, WARNA, JENIS, NOTES, USRNM, TG_SMP, KD_BRG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//edit data barang
exports.ubahbrg = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;
    var PRODUK = req.body.PRODUK;
    var SIZ = req.body.SIZ;
    var WARNA = req.body.WARNA;
    var JENIS = req.body.JENIS;
    var NOTES = req.body.NOTES;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE brg SET KD_BRG=?, NA_BRG=?, SATUAN=?, ACNO=?, ACNO_NM=?, PRODUK=?, SIZ=?, WARNA=?, JENIS=?, NOTES=?, USRNM=?, TG_SMP=? where NO_ID=?;", [KD_BRG, NA_BRG, SATUAN, ACNO, ACNO_NM, PRODUK, SIZ, WARNA, JENIS, NOTES, USRNM, TG_SMP, NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//hapus data barang
exports.hapusbrg = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("delete from brg where NO_ID = ? ", [NO_ID],

        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};