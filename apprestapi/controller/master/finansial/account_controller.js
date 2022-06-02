'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER ACCOUNT ///========================///
exports.acc_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from account where ACNO like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_accpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from account where ACNO like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari acc
exports.cariacc = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from account where ACNO like ? or NAMA like ? or NAMA_KEL like ? or NM_GRUP like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data account
exports.tampilacc = function (req, res) {
    connection.query("select * from account", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data account
exports.modalaccstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from acc where ACNO like ? or NAMA like ? order by NM_GRUP", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from account order by ACNO",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data supp
exports.tambahacc = function (req, res) {
    var ACNO = req.body.ACNO;
    var NAMA = req.body.NAMA;
    var HD = req.body.HD;
    var GRUP = req.body.GRUP;
    var NM_GRUP = req.body.NM_GRUP;
    var KEL = req.body.KEL;
    var NAMA_KEL = req.body.NAMA_KEL;
    var BNK = req.body.BNK;
    var POS1 = req.body.POS1;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var NON = req.body.NON;

    connection.query("insert into account (ACNO,NAMA,HD,GRUP,NM_GRUP,KEL,NAMA_KEL,BNK,POS1,USRNM,TG_SMP,NON) values (?,?,?,?,?,?,?,?,?,?,?,?); CALL accountdins(?);", [ACNO,NAMA,HD,GRUP,NM_GRUP,KEL,NAMA_KEL,BNK,POS1,USRNM,TG_SMP,NON,ACNO],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahacc = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var ACNO = req.body.ACNO;
    var NAMA = req.body.NAMA;
    var HD = req.body.HD;
    var GRUP = req.body.GRUP;
    var NM_GRUP = req.body.NM_GRUP;
    var KEL = req.body.KEL;
    var NAMA_KEL = req.body.NAMA_KEL;
    var BNK = req.body.BNK;
    var POS1 = req.body.POS1;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var NON = req.body.NON;

    connection.query("UPDATE account SET ACNO=?,NAMA=?,HD=?,GRUP=?,NM_GRUP=?,KEL=?,NAMA_KEL=?,BNK=?,POS1=?,USRNM=?,TG_SMP=?,NON=? where NO_ID=?", [ACNO,NAMA,HD,GRUP,NM_GRUP,KEL,NAMA_KEL,BNK,POS1,USRNM,TG_SMP,NON,NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data account
exports.hapusacc = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM account WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};