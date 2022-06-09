'use strict';

var response = require('../../../res');
var connection = require('../../../koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

///========================/// MASTER BRAND ///========================///
// tampil data
exports.tampilbrand = function (req, res) {
    connection.query("SELECT * FROM mbrand", function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal brand
exports.modal_brand = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("SELECT * FROM mbrand WHERE BRAND LIKE ? OR KD_BRAND LIKE ? ORDER BY BRAND", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("SELECT * FROM mbrand ORDER BY KD_BRAND",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};