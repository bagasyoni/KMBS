'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER SUPPLIER ///========================///
//paginate
exports.sup_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from sup where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_suppaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from sup where KODES like ? or NAMAS like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari supplier      kodes like '%?%'",[dk]
exports.carisup = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from sup where KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data supplier
exports.tampilsup = function (req, res) {
    connection.query("select * from sup", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data supplier
exports.modalsupstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from sup where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from sup order by KODES",
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
exports.tambahsup = function (req, res) {
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON1 = req.body.TELPON1;
    var FAX = req.body.FAX;
    var HP = req.body.HP;
    var KONTAK = req.body.KONTAK;
    var EMAIL = req.body.EMAIL;
    var NPWP = req.body.NPWP;
    var KET = req.body.KET;
    var BLACNOA = req.body.BLACNOA;
    var BLACNOB = req.body.BLACNOB;
    var BANK = req.body.BANK;
    var BANK_CAB = req.body.BANK_CAB;
    var BANK_KOTA = req.body.BANK_KOTA;
    var BANK_NAMA = req.body.BANK_NAMA;
    var BANK_REK = req.body.BANK_REK;
    var LIM = req.body.LIM;
    var HARI = req.body.HARI;
    var TYP = req.body.TYP;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("INSERT INTO sup (KODES,NAMAS,ALAMAT,KOTA,TELPON1,FAX,HP,KONTAK,EMAIL,NPWP,KET,BLACNOA,BLACNOB,BANK,BANK_CAB,BANK_KOTA,BANK_NAMA,BANK_REK,LIM,HARI,TYP,USRNM,TG_SMP) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); CALL supdins(?);", [KODES,NAMAS,ALAMAT,KOTA,TELPON1,FAX,HP,KONTAK,EMAIL,NPWP,KET,BLACNOA,BLACNOB,BANK,BANK_CAB,BANK_KOTA,BANK_NAMA,BANK_REK,LIM,HARI,TYP,USRNM,TG_SMP,KODES],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahsup = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON1 = req.body.TELPON1;
    var FAX = req.body.FAX;
    var HP = req.body.HP;
    var KONTAK = req.body.KONTAK;
    var EMAIL = req.body.EMAIL;
    var NPWP = req.body.NPWP;
    var KET = req.body.KET;
    var BLACNOA = req.body.BLACNOA;
    var BLACNOB = req.body.BLACNOB;
    var BANK = req.body.BANK;
    var BANK_CAB = req.body.BANK_CAB;
    var BANK_KOTA = req.body.BANK_KOTA;
    var BANK_NAMA = req.body.BANK_NAMA;
    var BANK_REK = req.body.BANK_REK;
    var LIM = req.body.LIM;
    var HARI = req.body.HARI;
    var TYP = req.body.TYP;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    console.log(NO_ID,KODES);

    connection.query("UPDATE sup SET KODES=?,NAMAS=?,ALAMAT=?,KOTA=?,TELPON1=?,FAX=?,HP=?,KONTAK=?,EMAIL=?,NPWP=?,KET=?,BLACNOA=?,BLACNOB=?,BANK=?,BANK_CAB=?,BANK_KOTA=?,BANK_NAMA=?,BANK_REK=?,LIM=?,HARI=?,TYP=?,USRNM=?,TG_SMP=? where NO_ID=?", [KODES,NAMAS,ALAMAT,KOTA,TELPON1,FAX,HP,KONTAK,EMAIL,NPWP,KET,BLACNOA,BLACNOB,BANK,BANK_CAB,BANK_KOTA,BANK_NAMA,BANK_REK,LIM,HARI,TYP,USRNM,TG_SMP,NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};

exports.hapussup = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM sup WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};