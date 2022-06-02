'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER CUSTOMER ///========================///
//paginate
exports.cus_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from cust where KODEC like ? or NAMAC like ? or ALAMAT like ? or KOTA like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_cuspaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from cust where KODEC like ? or NAMAC like ? or ALAMAT like ? or KOTA like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan data id      kodes like '%?%'",[dk]
exports.caricus = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from cust where KODEC like ? or NAMAC like ? or ALAMAT like ? or KOTA like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data customer
exports.tampilcus = function (req, res) {
    connection.query("select * from cust", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data customer
exports.modalcusstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from cust where KODEC like ? or NAMAC like ? order by KODEC", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from cust order by KODEC",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data customer
exports.tambahcus = function (req, res) {
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON1 = req.body.TELPON1;
    var HP = req.body.HP;
    var FAX = req.body.FAX;
    var KONTAK = req.body.KONTAK;
    var EMAIL = req.body.EMAIL;
    var BANK = req.body.BANK;
    var BANK_NAMA = req.body.BANK_NAMA;
    var BANK_REK = req.body.BANK_REK;
    var BANK_CAB = req.body.BANK_CAB;
    var BANK_KOTA = req.body.BANK_KOTA;
    var PKP = req.body.PKP;
    var NPWP = req.body.NPWP;
    var BARANG = req.body.BARANG;
    var DISKON = req.body.DISKON;
    var HARGA = req.body.HARGA;
    var AKT = req.body.AKT;

    connection.query("insert into cust (KODEC,NAMAC,ALAMAT,KOTA,TELPON1,HP,FAX,KONTAK,EMAIL,BANK,BANK_NAMA,BANK_REK,BANK_CAB,BANK_KOTA,PKP,NPWP,BARANG,DISKON,HARGA,AKT) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); CALL custdins(?);", [KODEC, NAMAC, ALAMAT, KOTA, TELPON1, HP, FAX, KONTAK, EMAIL, BANK, BANK_NAMA, BANK_REK, BANK_CAB, BANK_KOTA, PKP, NPWP, BARANG, DISKON, HARGA, AKT, KODEC],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data customer
exports.ubahcus = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var TELPON1 = req.body.TELPON1;
    var HP = req.body.HP;
    var FAX = req.body.FAX;
    var KONTAK = req.body.KONTAK;
    var EMAIL = req.body.EMAIL;
    var BANK = req.body.BANK;
    var BANK_NAMA = req.body.BANK_NAMA;
    var BANK_REK = req.body.BANK_REK;
    var BANK_CAB = req.body.BANK_CAB;
    var BANK_KOTA = req.body.BANK_KOTA;
    var PKP = req.body.PKP;
    var NPWP = req.body.NPWP;
    var BARANG = req.body.BARANG;
    var DISKON = req.body.DISKON;
    var HARGA = req.body.HARGA;
    var AKT = req.body.AKT;

    connection.query("UPDATE cust SET KODEC=? ,NAMAC=? ,ALAMAT=? ,KOTA=? ,TELPON1=? ,HP=? ,FAX=? ,KONTAK=? ,EMAIL=? ,BANK=? ,BANK_NAMA=? ,BANK_REK=? ,BANK_CAB=? ,BANK_KOTA=? ,PKP=? ,NPWP=? ,BARANG=? ,DISKON=? ,HARGA=? ,AKT=? where NO_ID = ? ", [KODEC, NAMAC, ALAMAT, KOTA, TELPON1, HP, FAX, KONTAK, EMAIL, BANK, BANK_NAMA, BANK_REK, BANK_CAB, BANK_KOTA, PKP, NPWP, BARANG, DISKON, HARGA, AKT, NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });

};
//delete data customer
exports.hapuscus = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM cust WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data Customer', res);

            }
        });
};