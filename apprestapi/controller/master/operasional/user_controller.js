'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER USER ///========================///
//paginate
exports.user_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from users where username like ? or status like ? or notes like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_userpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from users where username like ? or status like ? or notes like ? order by username", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

//menampilkan cari user
exports.cariuser = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from users where username like ? or status like ? or notes like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data user
exports.tampiluser = function (req, res) {
    connection.query("select * from users order by kode", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data user
exports.modaluser = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from users where username like ? or status like ? order by users", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from users order by username",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data user
exports.tambahuser = function (req, res) {
    var USERNAME = req.body.USERNAME;
    var PASSWORD = req.body.PASSWORD;
    var STATUS = req.body.STATUS;
    var NOTES = req.body.NOTES;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("insert into users (USERNAME, PASSWORD, STATUS, NOTES, USRIN, TG_IN, USRNM, TG_SMP) values (?,?,?,?,?,?,?,?)", [USERNAME, PASSWORD, STATUS, NOTES, USRIN, TG_IN, USRNM, TG_SMP],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahuser = function (req, res) {
    var USERNAME = req.body.USERNAME;
    var PASSWORD = req.body.PASSWORD;
    var STATUS = req.body.STATUS;
    var NOTES = req.body.NOTES;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;

    connection.query("UPDATE users SET PASSWORD=?, STATUS=?, NOTES=?, USRIN=?, TG_IN=?, USRNM=?, TG_SMP=? where USERNAME=? ", [PASSWORD, STATUS, NOTES, USRIN, TG_IN, USRNM, TG_SMP, USERNAME],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data user
exports.hapususer = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM users WHERE Username = ? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};
///check username
exports.checkusername = function (req, res) {
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