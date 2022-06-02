'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER BAHAN ///========================///
//paginate
exports.bahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_bahanpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bhn where KD_BHN like ? or NA_BHN like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari bahan
exports.caribahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilbahan = function (req, res) {
    connection.query("select * from bhn", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal bahan
exports.modalbahanstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? order by KD_BHN", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bhn order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data
exports.tambahbahan = function (req, res) {
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("insert into bhn (KD_BHN,NA_BHN,SATUAN,ACNO,ACNO_NM,USRNM,TG_SMP) values (?,?,?,?,?,?,?); CALL bhndins(?);", [KD_BHN,NA_BHN,SATUAN,ACNO,ACNO_NM,USRNM,TG_SMP,KD_BHN],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahbahan = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var ACNO = req.body.ACNO;
    var ACNO_NM = req.body.ACNO_NM;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE bhn SET KD_BHN=?,NA_BHN=?,SATUAN=?,ACNO=?,ACNO_NM=?,USRNM=?,TG_SMP=? where NO_ID=?", [KD_BHN,NA_BHN,SATUAN,ACNO,ACNO_NM,USRNM,TG_SMP,NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};

exports.hapusbahan = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM bhn WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};