'use strict';

var response = require('./res');
var connection = require('./koneksi');
var md5 = require('md5');

exports.index = function (req, res) {
    response.ok('aplikasi rest api berjalan', res)
};

//menampilkan data 


exports.login = function (req, res) {
    var username = req.body.username;
    var password = md5(req.body.password);
    connection.query("select * from users where Username = ? and Password = ? ", [username, password], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

///NO BUKTI OTOMATIS
exports.nourut = function (req, res) {
    var jenis = req.body.tipe;
    var tabelx = req.body.tabel;
    var kolomx = req.body.kolom;

    connection.query("SELECT lpad(right(coalesce(MAX(??),0),4)+1,4,0) as NOMOR from ?? where left(??,8)=?", [kolomx, tabelx, kolomx, jenis],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

///CHECK NO BUKTI
exports.checknobukti = function (req, res) {
    var nobukti = req.body.cari;
    var tabelx = req.body.tabel;
    var kolomx = req.body.kolom;

    connection.query("SELECT * from ?? where ??=?", [tabelx, kolomx, nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.selectdetail = function (req, res) {
    var nobukti = req.body.cari;
    var tabelx = req.body.tabel;
    var kolomx = req.body.kolom;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from ?? where ??=?", [tabelx, kolomx, nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

///SELECT DETAIL TRANSAKSI
exports.ambilpodetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from po where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}
///SELECT DETAIL TRANSAKSI
exports.ambilsodetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from so where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

///HAPUS DETAIL TRANSAKSI
exports.hapusdetail = function (req, res) {
    var nobukti = req.body.no_bukti;
    var tabelx = req.body.tabel;
    var kolomx = req.body.kolom;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("DELETE from ?? where ??=?", [tabelx, kolomx, nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}

///MODAL PERIODE
// tampil data
exports.tampilperid = function (req, res) {
    connection.query("select * from perid", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};


/// MASTER

///paginate
exports.brg_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from brg where KD_BRG like ? or NA_BRG like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilbrg = function (req, res) {
    connection.query("select * from brg", function (error, rows, fields) {
        if (error) {
            connection.log(error);
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
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from brg order by KD_BRG",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
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
    var JENIS = req.body.JENIS;
    var SATUAN = req.body.SATUAN;
    var TYPE = req.body.TYPE;
    var KODEV = req.body.KODEV;
    var KD_BRGLM = req.body.KD_BRGLM;
    var NA_BRGLM = req.body.NA_BRGLM;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("insert into brg (KD_BRG, NA_BRG, JENIS, SATUAN, TYPE, KODEV, KD_BRGLM, NA_BRGLM, KODE, NAMA) values (?,?,?,?,?,?,?,?,?,?); CALL brgdins(?);", [KD_BRG, NA_BRG, JENIS, SATUAN, TYPE, KODEV, KD_BRGLM, NA_BRGLM, KODE, NAMA, KD_BRG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
    var JENIS = req.body.JENIS;
    var SATUAN = req.body.SATUAN;
    var TYPE = req.body.TYPE;
    var KODEV = req.body.KODEV;
    var KD_BRGLM = req.body.KD_BRGLM;
    var NA_BRGLM = req.body.NA_BRGLM;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("UPDATE brg SET KD_BRG=? ,NA_BRG=? ,JENIS=? ,SATUAN=? ,TYPE=? ,KODEV=? ,KD_BRGLM=? ,NA_BRGLM=? ,KODE=? ,NAMA=? where NO_ID = ? ", [KD_BRG, NA_BRG, JENIS, SATUAN, TYPE, KODEV, KD_BRGLM, NA_BRGLM, KODE, NAMA, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

//paginate
exports.curr_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from curr where KODE like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_currpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from curr where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data currency
exports.tampilcurr = function (req, res) {
    connection.query("select * from curr", function (error, rows, fields) {
        if (error) {
            connection.log(error);
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
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from curr order by KODE",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data currency
exports.tambahcurr = function (req, res) {
    var ACNO = req.body.ACNO;
    var NAMA = req.body.NAMA;
    var NAMA_KEL = req.body.NAMA_KEL;
    var NM_GRUP = req.body.NM_GRUP;

    connection.query("insert into account (ACNO,NAMA,NAMA_KEL,NM_GRUP) values (?,?,?,?); CALL accountdins(?);", [ACNO, NAMA, NAMA_KEL, NM_GRUP, ACNO],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahcurr = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var ACNO = req.body.ACNO;
    var NAMA = req.body.NAMA;
    var NAMA_KEL = req.body.NAMA_KEL;
    var NM_GRUP = req.body.NM_GRUP;

    connection.query("UPDATE account SET ACNO = ?, NAMA = ?, NAMA_KEL = ?, NM_GRUP = ? where NO_ID = ? ", [ACNO, NAMA, NAMA_KEL, NM_GRUP, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapuscurr = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM curr WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};


//paginate
exports.bagas_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bagas where KD_BGS like ? or NA_BGS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_bagaspaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bagas where KD_BGS like ? or NA_BGS like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari supplier      kodes like '%?%'",[dk]
exports.caribagas = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bagas where KD_BGS like ? or NA_BGS like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data supplier
exports.tampilbagas = function (req, res) {
    connection.query("select * from bagas", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data supplier
exports.modalbagasstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bagas where KD_BGS like ? or NA_BGS like ? order by KD_BGS", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from account order by KD_BGS",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data supp
exports.tambahbagas = function (req, res) {
    var KD_BGS = req.body.KD_BGS;
    var NA_BGS = req.body.NA_BGS;
    var SATUAN = req.body.SATUAN;

    connection.query("insert into bagas (KD_BGS,NA_BGS,SATUAN) values (?,?,?)", [KD_BGS, NA_BGS, SATUAN],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahbagas = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KD_BGS = req.body.KD_BGS;
    var NA_BGS = req.body.NA_BGS;
    var SATUAN = req.body.SATUAN;

    connection.query("UPDATE bagas SET KD_BGS = ?, NA_BGS = ?, SATUAN = ? where NO_ID = ? ", [KD_BGS, NA_BGS, SATUAN, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapusbagas = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM bagas WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

///paginate
exports.acc_suppaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from account where ACNO like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari acc      kodes like '%?%'",[dk]
exports.cariacc = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from account where ACNO like ? or NAMA like ? or NAMA_KEL like ? or NM_GRUP like ?", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data supplier
exports.tampilacc = function (req, res) {
    connection.query("select * from account", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data supplier
exports.modalaccstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from acc where ACNO like ? or NAMA like ? order by NM_GRUP", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from account order by ACNO",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
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
    var NAMA_KEL = req.body.NAMA_KEL;
    var NM_GRUP = req.body.NM_GRUP;

    connection.query("insert into account (ACNO,NAMA,NAMA_KEL,NM_GRUP) values (?,?,?,?); CALL accountdins(?);", [ACNO, NAMA, NAMA_KEL, NM_GRUP, ACNO],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
    var NAMA_KEL = req.body.NAMA_KEL;
    var NM_GRUP = req.body.NM_GRUP;

    connection.query("UPDATE account SET ACNO = ?, NAMA = ?, NAMA_KEL = ?, NM_GRUP = ? where NO_ID = ? ", [ACNO, NAMA, NAMA_KEL, NM_GRUP, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapusacc = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM account WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

//paginate
exports.sup_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from sup where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data supplier
exports.tampilsup = function (req, res) {
    connection.query("select * from sup", function (error, rows, fields) {
        if (error) {
            connection.log(error);
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
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from sup order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
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

    connection.query("insert into sup (KODES,NAMAS,ALAMAT,KOTA,TELPON1,HP,FAX,KONTAK,EMAIL,BANK,BANK_NAMA,BANK_REK,BANK_CAB,BANK_KOTA,PKP,NPWP,BARANG,DISKON,HARGA,AKT) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); CALL supdins(?);", [KODES, NAMAS, ALAMAT, KOTA, TELPON1, HP, FAX, KONTAK, EMAIL, BANK, BANK_NAMA, BANK_REK, BANK_CAB, BANK_KOTA, PKP, NPWP, BARANG, DISKON, HARGA, AKT, KODES],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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

    connection.query("UPDATE sup SET KODES=? ,NAMAS=? ,ALAMAT=? ,KOTA=? ,TELPON1=? ,HP=? ,FAX=? ,KONTAK=? ,EMAIL=? ,BANK=? ,BANK_NAMA=? ,BANK_REK=? ,BANK_CAB=? ,BANK_KOTA=? ,PKP=? ,NPWP=? ,BARANG=? ,DISKON=? ,HARGA=? ,AKT=? where NO_ID = ? ", [KODES, NAMAS, ALAMAT, KOTA, TELPON1, HP, FAX, KONTAK, EMAIL, BANK, BANK_NAMA, BANK_REK, BANK_CAB, BANK_KOTA, PKP, NPWP, BARANG, DISKON, HARGA, AKT, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapussup = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM sup WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

//paginate
exports.bahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilbahan = function (req, res) {
    connection.query("select * from bhn", function (error, rows, fields) {
        if (error) {
            connection.log(error);
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
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bhn order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
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
    var JENIS = req.body.JENIS;
    var SATUAN = req.body.SATUAN;
    var TYPE = req.body.TYPE;
    var KODEV = req.body.KODEV;
    var KD_BHNLM = req.body.KD_BHNLM;
    var NA_BHNLM = req.body.NA_BHNLM;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("insert into bhn (KD_BHN,NA_BHN,JENIS,SATUAN,TYPE,KODEV,KD_BHNLM,NA_BHNLM,KODE,NAMA) values (?,?,?,?,?,?,?,?,?,?); CALL bhndins(?);", [KD_BHN, NA_BHN, JENIS, SATUAN, TYPE, KODEV, KD_BHNLM, NA_BHNLM, KODE, NAMA, KD_BHN],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
    var JENIS = req.body.JENIS;
    var SATUAN = req.body.SATUAN;
    var TYPE = req.body.TYPE;
    var KODEV = req.body.KODEV;
    var KD_BHNLM = req.body.KD_BHNLM;
    var NA_BHNLM = req.body.NA_BHNLM;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("UPDATE bhn SET KD_BHN=? ,NA_BHN=? ,JENIS=? ,SATUAN=? ,TYPE=? ,KODEV=? ,KD_BHNLM=? ,NA_BHNLM=? ,KODE=? ,NAMA=? where NO_ID = ? ", [KD_BHN, NA_BHN, JENIS, SATUAN, TYPE, KODEV, KD_BHNLM, NA_BHNLM, KODE, NAMA, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data
exports.hapusbahan = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM bhn WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

//paginate
exports.nonbahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_nonbahanpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bhn where KD_BHN like ? or NA_BHN like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari
exports.carinonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilnonbahan = function (req, res) {
    connection.query("select * from bhn", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal
exports.modalnonbahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? order by KD_BHN", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bhn order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};


//paginate
exports.mesin_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_mesinpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bhn where KD_BHN like ? or NA_BHN like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari
exports.carimesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilmesin = function (req, res) {
    connection.query("select * from bhn", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal
exports.modalmesin = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? order by KD_BHN", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bhn order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};


//paginate
exports.sparepart_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_sparepartpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from bhn where KD_BHN like ? or NA_BHN like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan cari
exports.carisparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? or SATUAN like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data
exports.tampilsparepart = function (req, res) {
    connection.query("select * from bhn", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// modal
exports.modalsparepart = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from bhn where KD_BHN like ? or NA_BHN like ? order by KD_BHN", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from bhn order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data
exports.tambahsparepart = function (req, res) {
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;

    connection.query("insert into bhn (KD_BHN,NA_BHN,SATUAN) values (?,?,?)", [KD_BHN, NA_BHN, SATUAN],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahsparepart = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;

    connection.query("UPDATE bhn SET KD_BHN=?,NA_BHN=?,SATUAN=? where NO_ID = ? ", [KD_BHN, NA_BHN, SATUAN, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data
exports.hapussparepart = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM bhn WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};





//paginate
exports.acc_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from account where ACNO like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
// modal data account header kas
exports.modal_acckas = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from account where BNK='1' and (ACNO like ? or NAMA like ?) order by ACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from account order by ACNO",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
// modal data account header bank
exports.modal_accbank = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from account where BNK='2' and (ACNO like ? or NAMA like ?) order by ACNO", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from account order by ACNO",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
// modal data currency
exports.modal_curr = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from curr order by KODE", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from curr order by KODE",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

//paginate
exports.cus_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from cust where KODEC like ? or NAMAC like ? or ALAMAT like ? or KOTA like ? LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data customer
exports.tampilcus = function (req, res) {
    connection.query("select * from cust", function (error, rows, fields) {
        if (error) {
            connection.log(error);
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
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from cust order by KODEC",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
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
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data Customer', res);

            }
        });
};

//cari bank
exports.caribank = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from master_bank where KD_BANK like ? or NA_BANK like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data bank
exports.tampilbank = function (req, res) {
    connection.query("select * from master_bank", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data bank
exports.modalbankstok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from master_bank where KD_BANK like ? or NA_BANK like ? order by NA_BANK", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from master_bank order by NA_BANK",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data bank
exports.tambahbank = function (req, res) {
    var KD_BANK = req.body.KD_BANK;
    var NA_BANK = req.body.NA_BANK;

    connection.query("insert into master_bank (KD_BANK,NA_BANK) values (?,?)", [KD_BANK, NA_BANK],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data bank
exports.ubahbank = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KD_BANK = req.body.KD_BANK;
    var NA_BANK = req.body.NA_BANK;

    connection.query("UPDATE master_bank SET KD_BANK=? ,NA_BANK=? where NO_ID = ? ", [KD_BANK, NA_BANK, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });

};
//delete data bank
exports.hapusbank = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM master_bank WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data Bank', res);

            }
        });
};

//cari perid
exports.cariperiode = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from perid where PERIO like ? or YER like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data perid
exports.tampilperiode = function (req, res) {
    connection.query("select * from perid", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
// tampil data periode
exports.modalperiodestok = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from perid where PERIO like ? or YER like ? order by PERIOD", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from perid order by PERIO",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
//tambah data periode
exports.tambahperiode = function (req, res) {
    var PERIOD = req.body.PERIOD;
    var YER = req.body.YER;

    connection.query("insert into perid (PERIO,YER) values (?,?)", [PERIOD, YER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data periode
exports.ubahperiode = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var PERIOD = req.body.PERIOD;
    var YER = req.body.YER;

    connection.query("UPDATE perid SET PERIO=? ,YER=? where NO_ID = ? ", [PERIOD, YER, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });

};
//delete data periode
exports.hapusperiode = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM perid WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data Bank', res);

            }
        });
};



//paginate
exports.gud_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from gdg where KODE like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_gudpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from gdg where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan data id      kodes like '%?%'",[dk]
exports.carigud = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from gdg where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data gudang
exports.tampilgud = function (req, res) {
    connection.query("select * from gdg", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
//tambah data gudang
exports.tambahgud = function (req, res) {
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("insert into gdg (KODE,NAMA) values (?,?)", [KODE, NAMA],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data 
exports.ubahgud = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("UPDATE gdg SET KODE=?, NAMA=? where NO_ID = ? ", [KODE, NAMA, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapusgud = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM gdg WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};



//paginate
exports.emkl_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from mkl where KODE like ? or NAMA like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_emklpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from mkl where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
//menampilkan data id      kodes like '%?%'",[dk]
exports.cariemkl = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from mkl where KODE like ? or NAMA like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// tampil data emkl
exports.tampilemkl = function (req, res) {
    connection.query("select * from mkl", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
//tambah data emkl
exports.tambahemkl = function (req, res) {
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("insert into mkl (KODE,NAMA) values (?,?)", [KODE, NAMA],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data emkl
exports.ubahemkl = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var KODE = req.body.KODE;
    var NAMA = req.body.NAMA;

    connection.query("UPDATE mkl SET KODE=?, NAMA=? where NO_ID = ? ", [KODE, NAMA, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
//delete data supplier
exports.hapusemkl = function (req, res) {
    var NO_ID = req.body.NO_ID;
    connection.query("DELETE FROM mkl WHERE NO_ID=? ", [NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};




/// TRANSAKSI
// tampil data hutang
exports.modalhutbahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from hut where NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from hut order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.thutpaginatebahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.countthutpaginatebahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilthutbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.carithutbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahthutbahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var TOTAL = Number(req.body.TOTAL);
    var NETT = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into beli (NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, TOTAL, NETT, NOTES, FLAG, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, TOTAL, NETT, NOTES, FLAG, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahthutbahan = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE beli SET NO_BUKTI=?,TGL=?,NO_BELI=?,KODES=?,NAMAS=?,TOTAL=?,NETT=?,NOTES=?,FLAG=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, TOTAL, NETT, NOTES, FLAG, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusthutbahan = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

// tampil data hutang
exports.modalpiu = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from piu where NO_BUKTI like ? or TGL like ? or NO_JUAL like ? or KODEC like ? or NAMAC like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from hut order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.tpiupaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from jual where (NO_BUKTI like ? or TGL like ? or NO_JUAL like ? or KODEC like ? or NAMAC like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.counttpiupaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from jual where (NO_BUKTI like ? or TGL like ? or NO_JUAL like ? or KODEC like ? or NAMAC like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampiltpiu = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from jual where (NO_BUKTI like ? or KODEC like ? or NAMAC like ?) and FLAG='PT'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.caritpiu = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from jual where (NO_BUKTI like ? or KODEC like ? or NAMAC like ?) and FLAG='PT'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahtpiu = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_JUAL = req.body.NO_JUAL;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var TOTAL = Number(req.body.TOTAL);
    var NETT = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into jual (NO_BUKTI, TGL, NO_JUAL, KODEC, NAMAC, TOTAL, NETT, NOTES, FLAG, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_JUAL, KODEC, NAMAC, TOTAL, NETT, NOTES, FLAG, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahtpiu = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_JUAL = req.body.NO_JUAL;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE jual SET NO_BUKTI=?,TGL=?,NO_JUAL=?,KODEC=?,NAMAC=?,TOTAL=?,NETT=?,NOTES=?,FLAG=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_JUAL, KODEC, NAMAC, TOTAL, NETT, NOTES, FLAG, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapustpiu = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM jual WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

///TRANSAKSI HEADER PIUTANG
///HEADER
exports.tambahheaderpiu = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var PER = req.body.PER;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var BAYAR = req.body.BAYAR;
    var TOTAL = Number(req.body.TOTAL);
    var FLAG = req.body.FLAG;
    var USRNM = req.body.USRNM;

    connection.query("insert into piu (NO_BUKTI, TGL, PER, KODEC, NAMAC, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, PER, KODEC, NAMAC, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi piu Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpiu = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var NO_FAKTUR = req.body.NO_JUAL;
    var URAIAN = req.body.NOTES;
    var TOTAL = req.body.TOTAL;
    var BAYAR = req.body.BAYAR;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;

    connection.query("insert into piud (REC,NO_BUKTI,NO_FAKTUR,URAIAN,TOTAL,BAYAR,FLAG,PER) values (?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, NO_FAKTUR, URAIAN, TOTAL, BAYAR, FLAG, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Pembayaran Piutang Detail', res);

            }
        });
};

exports.tampilpiu = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from piu where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PP'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpiu = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var PER = req.body.PER;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var BAYAR = req.body.BAYAR;
    var TOTAL = Number(req.body.TOTAL);
    var FLAG = req.body.FLAG;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE piu set TGL=?, PER=?, KODEC=?, NAMAC=?, ALAMAT=?, KOTA=?, NOTES=?, BAYAR=?, TOTAL=?, FLAG=?, USRNM=? WHERE NO_BUKTI=?", [TGL, PER, KODEC, NAMAC, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Pembayaran Piutang Header', res);

            }
        });
};
exports.caripiu = function (req, res) {
    connection.query("select * from piu where FLAG='PP'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
exports.ambilpiudetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from piu where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}
exports.hapuspiu = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from piu where NO_BUKTI=?; DELETE from piud where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.modalthutnonbahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.thutpaginatenonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.countthutpaginatenonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilthutnonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='NB'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.carithutnonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='NB'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahthutnonbahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into beli (NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahthutnonbahan = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE beli SET NO_BUKTI=?,TGL=?,NO_BELI=?,KODES=?,NAMAS=?,DR=?,TOTAL=?,NOTES=?,FLAG=?,FLAG2=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusthutnonbahan = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

exports.modalthutimport = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.thutpaginateimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.countthutpaginateimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilthutimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='IMP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.carithutimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='IMP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahthutimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into beli (NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahthutimport = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE beli SET NO_BUKTI=?,TGL=?,NO_BELI=?,KODES=?,NAMAS=?,DR=?,TOTAL=?,NOTES=?,FLAG=?,FLAG2=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusthutimport = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

exports.modalthutmesin = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.thutpaginatemesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.countthutpaginatemesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilthutmesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='IM'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.carithutmesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='IM'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahthutmesin = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into beli (NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahthutmesin = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE beli SET NO_BUKTI=?,TGL=?,NO_BELI=?,KODES=?,NAMAS=?,DR=?,TOTAL=?,NOTES=?,FLAG=?,FLAG2=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusthutmesin = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

exports.modalthutsparepart = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.thutpaginatesparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?) LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.countthutpaginatesparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or TGL like ? or NO_BELI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilthutsparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='SP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.carithutsparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG='HT' and FLAG2='SP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahthutsparepart = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = Number(req.body.TOTAL);
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    connection.query("insert into beli (NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahthutsparepart = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_BELI = req.body.NO_BELI;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var DR = req.body.DR;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var FLAG = req.body.FLAG;
    var FLAG2 = req.body.FLAG2;
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE beli SET NO_BUKTI=?,TGL=?,NO_BELI=?,KODES=?,NAMAS=?,DR=?,TOTAL=?,NOTES=?,FLAG=?,FLAG2=?,PER=?,USRNM=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_BELI, KODES, NAMAS, DR, TOTAL, NOTES, FLAG, FLAG2, PER, USRNM, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusthutsparepart = function (req, res) {
    var NOID = req.body.NO_ID;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

// tampil data po
exports.modalpo = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where NO_PO like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ? order by NO_PO", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
///paginate
exports.po_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where (NO_PO like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ?) AND GOL='Y' LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_popaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where (NO_PO like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ?) AND GOL='Y' ", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.tampilpo = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ?", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
exports.caripo = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (NO_BUKTI like ? or KODES like ? or NAMAS like ?)", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahpo = function (req, res) {
    var NO_PO = req.body.NO_PO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPTOTAL = req.body.RPTOTAL;


    connection.query("insert into po (NO_PO,TGL,JTEMPO,KODES,NAMAS,KD_BRG,NA_BRG,KG,HARGA,TOTAL,NOTES,RPRATE,RPHARGA,RPTOTAL,GOL) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Y')", [NO_PO, TGL, JTEMPO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES, RPRATE, RPHARGA, RPTOTAL],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahpo = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_PO = req.body.NO_PO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPTOTAL = req.body.RPTOTAL;

    connection.query("UPDATE po SET NO_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KD_BRG=?, NA_BRG=?, KG=?, HARGA=?, TOTAL=?, NOTES=?, RPRATE=?, RPHARGA=?, RPTOTAL=? where NO_ID = ? ", [NO_PO, TGL, JTEMPO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES, RPRATE, RPHARGA, RPTOTAL, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapuspo = function (req, res) {
    var NOID = req.body.noid;
    connection.query("DELETE FROM po WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};

///tampil data pod
exports.modalpod = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from pod where NO_BUKTI like ? or KODES like ? or NAMAS like ? or KD_BHN like ? or NA_BHN like ? order by NO_BUKTI", [cari, cari, cari, cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from pod order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};
exports.tampilpod = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from pod where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ?", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
exports.caripod = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where NO_BUKTI like ? or KODES like ? or NAMAS like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.caripodbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG2='BH'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.caripodnonbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG2='NB'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.caripodimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG2='IMP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.caripodmesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG2='IM'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.caripodsparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pod where (NO_BUKTI like ? or KODES like ? or NAMAS like ?) and FLAG2='SP'", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}




/// TRANSAKSI
exports.caripon = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where ( NO_PO like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ? ) AND GOL='Z' ", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahpon = function (req, res) {
    var NO_PO = req.body.NO_PO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPTOTAL = req.body.RPTOTAL;

    connection.query("insert into po (NO_PO,TGL,JTEMPO,KODES,NAMAS,KD_BRG,NA_BRG,KG,HARGA,TOTAL,NOTES,RPRATE,RPHARGA,RPTOTAL,GOL) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Z')", [NO_PO, TGL, JTEMPO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES, RPRATE, RPHARGA, RPTOTAL],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahpon = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_PO = req.body.NO_PO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPTOTAL = req.body.RPTOTAL;

    connection.query("UPDATE po SET NO_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KD_BRG=?, NA_BRG=?, KG=?, HARGA=?, TOTAL=?, NOTES=?, RPRATE=?, RPHARGA=?, RPTOTAL=? where NO_ID = ? ", [NO_PO, TGL, JTEMPO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES, RPRATE, RPHARGA, RPTOTAL, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapuspon = function (req, res) {
    var NOID = req.body.noid;
    connection.query("DELETE FROM po WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};


///paginate
exports.beli_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ?) AND GOL='Y' LIMIT ?, ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
///paginate
exports.count_belipaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ?) AND GOL='Y' ", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
exports.caribeli = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (NO_BUKTI like ? or KODES like ? or NAMAS like ? or KD_BRG like ? or NA_BRG like ?) AND GOL='Y' ", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahbeli = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_PO = req.body.NO_PO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var LAIN = req.body.LAIN;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPLAIN = req.body.RPLAIN;
    var RPTOTAL = req.body.RPTOTAL;
    var AJU = req.body.AJU;
    var BL = req.body.BL;
    var EMKL = req.body.EMKL;
    var JCONT = req.body.JCONT;
    var HARGAT = req.body.HARGAT;
    var ACNOA = req.body.ACNOA;
    var NACNOA = req.body.NACNOA;
    var GOL = req.body.GOL;

    connection.query("insert into beli (NO_BUKTI, TGL, NO_PO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, LAIN, TOTAL, NOTES, RPRATE, RPHARGA, RPLAIN, RPTOTAL, AJU, BL, EMKL, JCONT, HARGAT, ACNOA, NACNOA, GOL) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Y')", [NO_BUKTI, TGL, NO_PO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, LAIN, TOTAL, NOTES, RPRATE, RPHARGA, RPLAIN, RPTOTAL, AJU, BL, EMKL, JCONT, HARGAT, ACNOA, NACNOA, GOL],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahbeli = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_PO = req.body.NO_PO;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var LAIN = req.body.LAIN;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;
    var RPRATE = req.body.RPRATE;
    var RPHARGA = req.body.RPHARGA;
    var RPLAIN = req.body.RPLAIN;
    var RPTOTAL = req.body.RPTOTAL;
    var AJU = req.body.AJU;
    var BL = req.body.BL;
    var EMKL = req.body.EMKL;
    var JCONT = req.body.JCONT;
    var HARGAT = req.body.HARGAT;
    var ACNOA = req.body.ACNOA;
    var NACNOA = req.body.NACNOA;

    connection.query("UPDATE beli SET NO_BUKTI=?, TGL=?, NO_PO=?, KODES=?, NAMAS=?, KD_BRG=?, NA_BRG=?, KG=?, HARGA=?, LAIN=?, TOTAL=?, NOTES=?, RPRATE=?, RPHARGA=?, RPLAIN=?, RPTOTAL=?, AJU=?, BL=?, EMKL=?, JCONT=?, HARGAT=?, ACNOA=?, NACNOA=? where NO_ID = ? ", [NO_BUKTI, TGL, NO_PO, KODES, NAMAS, KD_BRG, NA_BRG, KG, HARGA, LAIN, TOTAL, NOTES, RPRATE, RPHARGA, RPLAIN, RPTOTAL, AJU, BL, EMKL, JCONT, HARGAT, ACNOA, NACNOA, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusbeli = function (req, res) {
    var NOID = req.body.noid;
    connection.query("DELETE FROM beli WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};


/// TRANSAKSI
exports.cariso = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from so where NO_SO like ? or KODEC like ? or NAMAC like ? or KD_BRG like ? or NA_BRG like ?", [filter_cari, filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
exports.tambahso = function (req, res) {
    var NO_SO = req.body.NO_SO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var KOTA = req.body.KOTA;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;

    connection.query("insert into so (NO_SO,TGL,JTEMPO,KODEC,NAMAC,KOTA,KD_BRG,NA_BRG,KG,HARGA,TOTAL,NOTES) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_SO, TGL, JTEMPO, KODEC, NAMAC, KOTA, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
exports.ubahso = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_SO = req.body.NO_SO;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var KOTA = req.body.KOTA;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var NOTES = req.body.NOTES;

    connection.query("UPDATE so SET NO_SO=?, TGL=?, JTEMPO=?, KODEC=?, NAMAC=?, KOTA=?, KD_BRG=?, NA_BRG=?, KG=?, HARGA=?, TOTAL=?, NOTES=? where NO_ID = ? ", [NO_SO, TGL, JTEMPO, KODEC, NAMAC, KOTA, KD_BRG, NA_BRG, KG, HARGA, TOTAL, NOTES, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
exports.hapusso = function (req, res) {
    var NOID = req.body.noid;
    connection.query("DELETE FROM so WHERE NO_ID=? ", [NOID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};





exports.carikoreksistok = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from stock where NO_BUKTI like ? or KD_BRG like ? or NA_BRG like ?", [filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}
// //tambah data koreksi stok
exports.tambahkoreksistok = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var NOTES = req.body.NOTES;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;

    connection.query("insert into stock (NO_BUKTI,TGL,KD_BRG,NA_BRG,KG,NOTES,HARGA,TOTAL) values (?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, KD_BRG, NA_BRG, KG, NOTES, HARGA, TOTAL],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Data', res);

            }
        });
};
//update data koreksi stok
exports.ubahkoreksistok = function (req, res) {
    var NO_ID = req.body.NO_ID;
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KG = req.body.KG;
    var NOTES = req.body.NOTES;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;

    connection.query("UPDATE stock SET NO_BUKTI=?, TGL=?, KD_BRG=?, NA_BRG=?, KG=?, NOTES=?, HARGA=?, TOTAL=? where NO_ID = ? ", [NO_BUKTI, TGL, KD_BRG, NA_BRG, KG, NOTES, HARGA, TOTAL, NO_ID],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Ubah Data', res);

            }
        });
};
// //delete data koreksi stok
exports.hapuskoreksistok = function (req, res) {
    var NOBUKTI = req.body.nobukti;
    connection.query("DELETE FROM stock WHERE NO_BUKTI=? ", [NOBUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Hapus Data', res);

            }
        });
};


///TRANSAKSI HEADER DETAIL KAS
///HEADER
exports.tambahheaderkas = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TANGGAL = req.body.tgl;
    var PER = req.body.per;
    var TIPE = req.body.tipe;
    var KET = req.body.ket;
    var USER = req.body.user;
    var BACNO = req.body.bacno;
    var BNAMA = req.body.bnama;
    var JUMLAH = Number(req.body.jumlah);
    var FLAG = req.body.flag;
    connection.query("insert into kas (NO_BUKTI,TGL,PER,TYPE,KET,USRNM,BACNO,BNAMA,JUMLAH,FLAG) values (?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TANGGAL, PER, TIPE, KET, USER, BACNO, BNAMA, JUMLAH, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailkas = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var TIPE = req.body.tipe;
    var ACNO = req.body.acno;
    var NACNO = req.body.nacno;
    var URAIAN = req.body.uraian;
    var JUMLAH = Number(req.body.jumlah);
    var FLAG = req.body.flag;
    connection.query("insert into kasd (REC,NO_BUKTI,PER,TYPE,ACNO,NACNO,URAIAN,JUMLAH,FLAG) values (?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, TIPE, ACNO, NACNO, URAIAN, JUMLAH, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Kas Detail', res);

            }
        });
};

exports.tampilkasmasuk = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from kas where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND TYPE='BKM'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.tampilkaskeluar = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from kas where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND TYPE='BKK'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderkas = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TANGGAL = req.body.tgl;
    var KET = req.body.ket;
    var USER = req.body.user;
    var BACNO = req.body.bacno;
    var BNAMA = req.body.bnama;
    var JUMLAH = Number(req.body.jumlah);
    connection.query("UPDATE kas set TGL=?,KET=?,USRNM=?,BACNO=?,BNAMA=?,JUMLAH=? WHERE NO_BUKTI=?", [TANGGAL, KET, USER, BACNO, BNAMA, JUMLAH, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Kas Header', res);

            }
        });
};






///TRANSAKSI HEADER DETAIL BANK
///HEADER
exports.tambahheaderbank = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TANGGAL = req.body.tgl;
    var PER = req.body.per;
    var TIPE = req.body.tipe;
    var KET = req.body.ket;
    var USER = req.body.user;
    var BACNO = req.body.bacno;
    var BNAMA = req.body.bnama;
    var JUMLAH = Number(req.body.jumlah);
    var FLAG = req.body.flag;
    connection.query("insert into bank (NO_BUKTI,TGL,PER,TYPE,KET,USRNM,BACNO,BNAMA,JUMLAH,FLAG) values (?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TANGGAL, PER, TIPE, KET, USER, BACNO, BNAMA, JUMLAH, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbank = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var TIPE = req.body.tipe;
    var ACNO = req.body.acno;
    var NACNO = req.body.nacno;
    var URAIAN = req.body.uraian;
    var JUMLAH = Number(req.body.jumlah);
    var FLAG = req.body.flag;
    connection.query("insert into bankd (REC,NO_BUKTI,PER,TYPE,ACNO,NACNO,URAIAN,JUMLAH,FLAG) values (?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, TIPE, ACNO, NACNO, URAIAN, JUMLAH, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Detail', res);

            }
        });
};

exports.tampilbankmasuk = function (req, res) {
    var nobukti = req.body.cari;
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from bank where if(?<>'',NO_BUKTI=?,true) AND TGL BETWEEN ? AND ? AND TYPE='BBM'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.tampilbankkeluar = function (req, res) {
    var nobukti = req.body.cari;
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from bank where if(?<>'',NO_BUKTI=?,true) AND TGL BETWEEN ? AND ? AND TYPE='BBK'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbank = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TANGGAL = req.body.tgl;
    var KET = req.body.ket;
    var USER = req.body.user;
    var BACNO = req.body.bacno;
    var BNAMA = req.body.bnama;
    var JUMLAH = Number(req.body.jumlah);
    connection.query("UPDATE bank set TGL=?,KET=?,USRNM=?,BACNO=?,BNAMA=?,JUMLAH=? WHERE NO_BUKTI=?", [TANGGAL, KET, USER, BACNO, BNAMA, JUMLAH, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Bank Header', res);

            }
        });
};

///TRANSAKSI HEADER DETAIL MEMO
///HEADER
exports.tambahheadermemo = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KET = req.body.KET;
    var DEBET = Number(req.body.DEBET);
    var KREDIT = Number(req.body.KREDIT);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    var TYPE = req.body.TYPE;
    connection.query("insert into memo (NO_BUKTI,TGL,KET,DEBET,KREDIT,PER,USRNM,FLAG) values (?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, KET, DEBET, KREDIT, PER, USRNM, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailmemo = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var ACNO = req.body.ACNO;
    var NACNO = req.body.NACNO;
    var URAIAN = req.body.URAIAN;
    var DEBET = req.body.DEBET;
    var KREDIT = req.body.KREDIT;
    var FLAG = req.body.FLAG;
    connection.query("insert into memod (REC,NO_BUKTI,PER,ACNO,NACNO,URAIAN,DEBET,KREDIT,FLAG) values (?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, ACNO, NACNO, URAIAN, DEBET, KREDIT, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Detail', res);

            }
        });
};

exports.tampilmemo = function (req, res) {
    var nobukti = req.body.cari;
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from memo where if(?<>'',NO_BUKTI=?,true) AND TGL BETWEEN ? AND ? AND FLAG='M'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheadermemo = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var KET = req.body.KET;
    var DEBET = Number(req.body.DEBET);
    var KREDIT = Number(req.body.KREDIT);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("UPDATE memo set TGL=?,KET=?,DEBET=?,KREDIT=?,PER=?,USRNM=?,FLAG=? WHERE NO_BUKTI=?", [TGL, KET, DEBET, KREDIT, PER, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Memo Header', res);

            }
        });
};

exports.hapusmemo = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from memo where NO_BUKTI=?; DELETE from memod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI STOCK BAHAN ///========================///
exports.stockbhn_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from stocka where NO_BUKTI like ? or NOTES like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_stockbhnpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from stocka where FLAG='KA' and (NO_BUKTI like ? or NOTES like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

exports.tambahheaderstockbhn = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRIN = req.body.USRIN;
    var FLAG = req.body.FLAG;
    var TG_IN = req.body.TG_IN;
    connection.query("insert into stocka (NO_BUKTI,TGL,NOTES,TOTAL_QTY,PER,USRIN,FLAG,TG_IN) values (?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NOTES, TOTAL_QTY, PER, USRIN, FLAG, TG_IN],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Stock Bahan Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailstockbhn = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var QTY = req.body.QTY;
    var SATUAN = req.body.SATUAN;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    connection.query("insert into stockad (REC,NO_BUKTI,KD_BHN,NA_BHN,QTY,SATUAN,KET,PER,FLAG) values (?,?,?,?,?,?,?,?,?); UPDATE stocka, stockad SET stockad.ID = stocka.NO_ID WHERE stockad.NO_BUKTI = stocka.NO_BUKTI;", [REC, NO_BUKTI, KD_BHN, NA_BHN, QTY, SATUAN, KET, PER, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Stock Bahan Detail', res);

            }
        });
};

exports.tampilstockbhn = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from stocka where if(?<>'',NO_BUKTI LIKE ?,true) AND TGL BETWEEN ? AND ? AND FLAG='KA' AND PER=?", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderstockbhn = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    var TG_SMP = req.body.TG_SMP;
    connection.query("UPDATE stocka set TGL=?,NOTES=?,TOTAL_QTY=?,PER=?,USRNM=?,FLAG=?,TG_SMP=? WHERE NO_BUKTI=?", [TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG, TG_SMP, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Stock Bahan Header', res);

            }
        });
};

exports.modalstockbhn = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from stocka where NO_BUKTI like ? or NOTES like ? order by NO_BUKTI", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from stocka order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caristockbhn = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from stocka where (NO_BUKTI like ? or NOTES like ?) and FLAG='KA'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusstockbhn = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from stocka where NO_BUKTI=?; DELETE from stockad where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL MUTASI BARANG
//paginate
exports.mutasibrg_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from stockb where NO_BUKTI like ? or NOTES like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_mutasibrgpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from stockb where NO_BUKTI like ? or NOTES like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
///HEADER
exports.tambahheadermutasibrg = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("insert into stockb (NO_BUKTI,TGL,NOTES,TOTAL_QTY,PER,USRNM,FLAG) values (?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Mutasi Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailmutasibrg = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var QTY = req.body.QTY;
    var SATUAN = req.body.SATUAN;
    var STOCKR = req.body.STOCKR;
    var FISIK = req.body.FISIK;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    connection.query("insert into stockbd (REC,NO_BUKTI,KD_BRG,NA_BRG,QTY,SATUAN,STOCKR,FISIK,PER,FLAG) values (?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BRG, NA_BRG, QTY, SATUAN, STOCKR, FISIK, PER, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Mutasi Detail', res);

            }
        });
};

exports.tampilmutasibrg = function (req, res) {
    var nobukti = req.body.cari;
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from stockb where if(?<>'',NO_BUKTI=?,true) AND TGL BETWEEN ? AND ? AND FLAG='KA'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheadermutasibrg = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("UPDATE stockb set TGL=?,NOTES=?,TOTAL_QTY=?,PER=?,USRNM=?,FLAG=? WHERE NO_BUKTI=?", [TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Mutasi Header', res);

            }
        });
};

exports.hapusmutasibrg = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from stockb where NO_BUKTI=?; DELETE from stockad where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PEMAKAIAN BAHAN ///========================///
exports.pakaibhn_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from pakai where NO_BUKTI like ? or NOTES like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pakaibhnpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from pakai where FLAG='PK' and (NO_BUKTI like ? or NOTES like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

exports.tambahheaderpakaibhn = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var FLAG = req.body.FLAG;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var USRIN = req.body.USRIN;
    var PER = req.body.PER;
    var TG_IN = req.body.TG_IN;
    connection.query("insert into pakai (NO_BUKTI,TGL,NOTES,TOTAL_QTY,PER,USRIN,FLAG,TG_IN) values (?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NOTES, TOTAL_QTY, PER, USRIN, FLAG, TG_IN],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Pemakaian Bahan Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpakaibhn = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var QTY = req.body.QTY;
    var SATUAN = req.body.SATUAN;
    var KET = req.body.KET;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    connection.query("insert into pakaid (REC,NO_BUKTI,KD_BHN,NA_BHN,QTY,SATUAN,KET,PER,FLAG) values (?,?,?,?,?,?,?,?,?); UPDATE pakai, pakaid SET pakaid.ID = pakai.NO_ID WHERE pakaid.NO_BUKTI = pakai.NO_BUKTI;", [REC, NO_BUKTI, KD_BHN, NA_BHN, QTY, SATUAN, KET, PER, FLAG],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Pemakaian Bahan Detail', res);

            }
        });
};

exports.tampilpakaibhn = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from pakai where if(?<>'',NO_BUKTI LIKE ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PK' AND PER=?", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpakaibhn = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    var TG_SMP = req.body.TG_SMP;
    connection.query("UPDATE pakai set TGL=?,NOTES=?,TOTAL_QTY=?,PER=?,USRNM=?,FLAG=?,TG_SMP=? WHERE NO_BUKTI=?", [TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG, TG_SMP, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Pemakaian Bahan Header', res);

            }
        });
};

exports.modalpakaibhn = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from pakai where NO_BUKTI like ? or NOTES like ? order by NO_BUKTI", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from pakai order by NO_BUKTI",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripakaibhn = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from pakai where (NO_BUKTI like ? or NOTES like ?) and FLAG='PK'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspakaibhn = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from pakai where NO_BUKTI=?; DELETE from pakaid where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL TERIMA
///HEADER
exports.tambahheaderterima = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("insert into terima (NO_BUKTI,TGL,NOTES,TOTAL_QTY,PER,USRNM,FLAG) values (?,?,?,?,?,?,?)", [NO_BUKTI, TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Terima Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailterima = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var KET = req.body.KET;
    var SATUAN = req.body.SATUAN;
    var QTY = req.body.QTY;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    connection.query("insert into terimad (REC,NO_BUKTI,KD_BRG,NA_BRG,KET,SATUAN,QTY,PER,FLAG) values (?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BRG, NA_BRG, KET, SATUAN, QTY, PER, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Terima Detail', res);

            }
        });
};

exports.tampilterima = function (req, res) {
    var nobukti = req.body.cari;
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from terima where if(?<>'',NO_BUKTI=?,true) AND TGL BETWEEN ? AND ? AND FLAG='TR'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderterima = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = Number(req.body.TOTAL_QTY);
    var PER = req.body.PER;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("UPDATE terima set TGL=?,NOTES=?,TOTAL_QTY=?,PER=?,USRNM=?,FLAG=? WHERE NO_BUKTI=?", [TGL, NOTES, TOTAL_QTY, PER, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Terima Header', res);

            }
        });
};

exports.hapusterima = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from terima where NO_BUKTI=?; DELETE from terimad where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PO BAHAN LOKAL ///========================///
exports.pobahanlokal_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pobahanlokalpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where TYP='L' and (KODES like ? or NAMAS like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderpobahanlokal = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var RATEKS = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("INSERT INTO po (NO_BUKTI,TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, BRAND, RATEKS, ACNO1, ACNO1_NM],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Po Bahan Lokal Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpobahanlokal = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var QTY = Number(req.body.QTY);
    var HARGA = Number(req.body.HARGA);
    var TOTAL = Number(req.body.TOTAL);
    var KET = req.body.KET;

    connection.query("INSERT INTO pod (REC, NO_BUKTI, PER, FLAG, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET) VALUES (?,?,?,?,?,?,?,?,?,?,?); UPDATE po, pod SET pod.ID = po.NO_ID WHERE pod.NO_BUKTI = po.NO_BUKTI;", [REC, NO_BUKTI, PER, FLAG, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpobahanlokal = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PO' AND PER=? AND TYP='L' AND GOL='A'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpobahanlokal = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("UPDATE po set TGL=?, JTEMPO=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, SISA_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP=?, FLAG=?, PER=?, TYP=?, GOL=?, BRAND=?, rateks=?, ACNO1=?, ACNO1_NM=? WHERE NO_BUKTI=?", [TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRNM, TG_SMP, FLAG, PER, TYP, GOL, BRAND, rateks, ACNO1, ACNO1_NM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

exports.modalpobahanlokal = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripobahanlokal = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PO' and NO_BUKTI IN (SELECT NO_BUKTI FROM pod WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspobahanlokal = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from po where NO_BUKTI=?; DELETE from pod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PO BAHAN IMPORT ///========================///
exports.pobahanimport_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pobahanimportpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where TYP='I' and (KODES like ? or NAMAS like ?) or GOL='A'", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderpobahanimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var RATEKS = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("INSERT INTO po (NO_BUKTI,TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, BRAND, RATEKS, ACNO1, ACNO1_NM],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Po Bahan Import Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpobahanimport = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var QTY = Number(req.body.QTY);
    var HARGA = Number(req.body.HARGA);
    var TOTAL = Number(req.body.TOTAL);
    var KET = req.body.KET;

    connection.query("INSERT INTO pod (REC, NO_BUKTI, PER, FLAG, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET) VALUES (?,?,?,?,?,?,?,?,?,?,?); UPDATE po, pod SET pod.ID = po.NO_ID WHERE pod.NO_BUKTI = po.NO_BUKTI;", [REC, NO_BUKTI, PER, FLAG, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah PO Bahan Import Detail', res);

            }
        });
};

exports.tampilpobahanimport = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PO' AND PER=? AND TYP='I' AND GOL='A'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpobahanimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("UPDATE po set TGL=?, JTEMPO=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, SISA_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP=?, FLAG=?, PER=?, TYP=?, GOL=?, BRAND=?, rateks=?, ACNO1=?, ACNO1_NM=? WHERE NO_BUKTI=?", [TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRNM, TG_SMP, FLAG, PER, TYP, GOL, BRAND, rateks, ACNO1, ACNO1_NM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

exports.modalpobahanimport = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripobahanimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PO' and NO_BUKTI IN (SELECT NO_BUKTI FROM pod WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspobahanimport = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from po where NO_BUKTI=?; DELETE from pod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PO BARANG LOKAL ///========================///
exports.pobaranglokal_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pobaranglokalpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where TYP='L' and (KODES like ? or NAMAS like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderpobaranglokal = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var RATEKS = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("INSERT INTO po (NO_BUKTI,TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, BRAND, RATEKS, ACNO1, ACNO1_NM],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Po Barang Lokal Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpobaranglokal = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var QTY = Number(req.body.QTY);
    var HARGA = Number(req.body.HARGA);
    var TOTAL = Number(req.body.TOTAL);
    var KET = req.body.KET;

    connection.query("INSERT INTO pod (REC, NO_BUKTI, PER, FLAG, KD_BRG, NA_BRG, SATUAN, QTY, HARGA, TOTAL, KET) VALUES (?,?,?,?,?,?,?,?,?,?,?); UPDATE po, pod SET pod.ID = po.NO_ID WHERE pod.NO_BUKTI = po.NO_BUKTI;", [REC, NO_BUKTI, PER, FLAG, KD_BRG, NA_BRG, SATUAN, QTY, HARGA, TOTAL, KET],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpobaranglokal = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PO' AND PER=? AND TYP='L' AND GOL='B'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpobaranglokal = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("UPDATE po set TGL=?, JTEMPO=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, SISA_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP=?, FLAG=?, PER=?, TYP=?, GOL=?, BRAND=?, rateks=?, ACNO1=?, ACNO1_NM=? WHERE NO_BUKTI=?", [TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRNM, TG_SMP, FLAG, PER, TYP, GOL, BRAND, rateks, ACNO1, ACNO1_NM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

exports.modalpobaranglokal = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripobaranglokal = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PO' and NO_BUKTI IN (SELECT NO_BUKTI FROM pod WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspobaranglokal = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from po where NO_BUKTI=?; DELETE from pod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PO BARANG IMPORT ///========================///
exports.pobarangimport_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from po where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.count_pobarangimportpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from po where TYP='I' and (KODES like ? or NAMAS like ?) or GOL='B'", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}

///HEADER
exports.tambahheaderpobarangimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRIN = req.body.USRIN;
    var TG_IN = req.body.TG_IN;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var RATEKS = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("INSERT INTO po (NO_BUKTI,TGL,JTEMPO,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,SISA_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,BRAND,rateks,ACNO1,ACNO1_NM) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRIN, TG_IN, FLAG, PER, TYP, GOL, BRAND, RATEKS, ACNO1, ACNO1_NM],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Po Barang Import Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpobarangimport = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var QTY = Number(req.body.QTY);
    var HARGA = Number(req.body.HARGA);
    var TOTAL = Number(req.body.TOTAL);
    var KET = req.body.KET;

    connection.query("INSERT INTO pod (REC, NO_BUKTI, PER, FLAG, KD_BRG, NA_BRG, SATUAN, QTY, HARGA, TOTAL, KET) VALUES (?,?,?,?,?,?,?,?,?,?,?); UPDATE po, pod SET pod.ID = po.NO_ID WHERE pod.NO_BUKTI = po.NO_BUKTI;", [REC, NO_BUKTI, PER, FLAG, KD_BRG, NA_BRG, SATUAN, QTY, HARGA, TOTAL, KET],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah PO Barang Import Detail', res);

            }
        });
};

exports.tampilpobarangimport = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PO' AND PER=? AND TYP='I' AND GOL='B'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpobarangimport = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var SISA_QTY = req.body.SISA_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var NETT1 = req.body.NETT1;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var PPH = req.body.PPH;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var NETT = req.body.NETT;
    var SISA = req.body.SISA;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var RPPPH = req.body.RPPPH;
    var USRNM = req.body.USRNM;
    var TG_SMP = req.body.TG_SMP;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var BRAND = req.body.BRAND;
    var rateks = req.body.rateks;
    var ACNO1 = req.body.ACNO1;
    var ACNO1_NM = req.body.ACNO1_NM;

    connection.query("UPDATE po set TGL=?, JTEMPO=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, SISA_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP=?, FLAG=?, PER=?, TYP=?, GOL=?, BRAND=?, rateks=?, ACNO1=?, ACNO1_NM=? WHERE NO_BUKTI=?", [TGL, JTEMPO, CURR, CURRNM, RATE, KODES, NAMAS, ALAMAT, KOTA, NOTES, TOTAL_QTY, SISA_QTY, TOTAL1, DISC, PPN, NETT1, DISC1, PPN1, PPH1, PPH, TOTAL, RPDISC, RPPPN, NETT, SISA, RPDISC1, RPPPN1, RPPPH1, RPPPH, USRNM, TG_SMP, FLAG, PER, TYP, GOL, BRAND, rateks, ACNO1, ACNO1_NM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};

exports.modalpobarangimport = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripobarangimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PO' and NO_BUKTI IN (SELECT NO_BUKTI FROM pod WHERE SISA>0)", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapuspobarangimport = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from po where NO_BUKTI=?; DELETE from pod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL SO
//paginate
exports.so_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from so where KODEC like ? or NAMAC like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_sopaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from so where KODEC like ? or NAMAC like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
///HEADER
exports.tambahheaderso = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    connection.query("insert into so (NO_BUKTI,TGL,JTEMPO,PER,KODEC,NAMAC,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL,NETT,USRNM,FLAG) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, JTEMPO, PER, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah SO Bahan Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailso = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var KET = req.body.KET;
    var HARGA = req.body.HARGA;
    var QTY = req.body.QTY;
    var TOTAL = req.body.TOTAL;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;

    connection.query("insert into sod (REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER) values (?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilso = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from so where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='SO'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderso = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE so set TGL=?, JTEMPO=?, PER=?, KODEC=?, NAMAC=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, TOTAL=?, NETT=?, USRNM=?, FLAG=? WHERE NO_BUKTI=?", [TGL, JTEMPO, PER, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit SO Header', res);

            }
        });
};

exports.modalso = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from so where KODEC like ? or NAMAC like ? order by KODEC", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from so order by KODEC",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.cariso = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from so where (KODEC like ? or NAMAC like ? or ALAMAT like ? or KOTA like ?) and FLAG='SO' and POSTED='0'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

exports.hapusso = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from so where NO_BUKTI=?; DELETE from sod where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER SURAT JALAN
///HEADER
exports.tambahheadersuratjalan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var NO_SO = req.body.NO_SO;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    var POSTED = req.body.NO_SO;
    connection.query("insert into surat (NO_BUKTI,TGL,JTEMPO,PER,NO_SO,KODEC,NAMAC,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL,NETT,USRNM,FLAG) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE so SET POSTED=1 WHERE NO_BUKTI=?", [NO_BUKTI, TGL, JTEMPO, PER, NO_SO, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG, POSTED],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Surat Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailsuratjalan = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var KET = req.body.KET;
    var HARGA = req.body.HARGA;
    var QTY = req.body.QTY;
    var TOTAL = req.body.TOTAL;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;

    connection.query("insert into suratd (REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER) values (?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Surat Detail', res);

            }
        });
};

exports.tampilsuratjalan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from surat where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='SJ'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheadersuratjalan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var NO_SO = req.body.NO_SO;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE surat set TGL=?, JTEMPO=?, PER=?, NO_SO=?, KODEC=?, NAMAC=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, TOTAL=?, NETT=?, USRNM=?, FLAG=? WHERE NO_BUKTI=?", [TGL, JTEMPO, PER, NO_SO, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};

exports.modalsuratjalan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from surat where KODEC like ? or NAMAC like ? order by KODEC", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from surat order by KODEC",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.carisuratjalanjual = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from surat where (NO_BUKTI like ? or TOTAL like ?) and FLAG='SJ'", [filter_cari, filter_cari], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.carisuratjalan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from surat where (NO_BUKTI like ? or TOTAL like ?) and FLAG='SJ'", [filter_cari, filter_cari], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.hapussuratjalan = function (req, res) {
    var no_bukti = req.body.no_bukti;
    var posted = req.body.posted;
    connection.query("DELETE from surat where NO_BUKTI=?; DELETE from suratd where NO_BUKTI=?; UPDATE po SET POSTED='0' WHERE NO_BUKTI=?", [no_bukti, no_bukti, posted],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER JUAL
///HEADER
exports.tambahheaderjual = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var NO_SJ = req.body.NO_SJ;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;
    var POSTED = req.body.NO_SJ;
    connection.query("insert into jual (NO_BUKTI,TGL,JTEMPO,PER,NO_SJ,KODEC,NAMAC,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL,NETT,USRNM,FLAG) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); UPDATE surat SET POSTED=1 WHERE NO_BUKTI=?", [NO_BUKTI, TGL, JTEMPO, PER, NO_SJ, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG, POSTED],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Jual Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailjual = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var KD_BRG = req.body.KD_BRG;
    var NA_BRG = req.body.NA_BRG;
    var SATUAN = req.body.SATUAN;
    var KET = req.body.KET;
    var HARGA = req.body.HARGA;
    var QTY = req.body.QTY;
    var TOTAL = req.body.TOTAL;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;

    connection.query("insert into juald (REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER) values (?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BRG, NA_BRG, SATUAN, KET, HARGA, QTY, TOTAL, FLAG, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Surat Detail', res);

            }
        });
};

exports.tampiljual = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from jual where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='JL'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderjual = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var JTEMPO = req.body.JTEMPO;
    var PER = req.body.PER;
    var NO_SJ = req.body.NO_SJ;
    var KODEC = req.body.KODEC;
    var NAMAC = req.body.NAMAC;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL = req.body.TOTAL;
    var NETT = req.body.TOTAL;
    var USRNM = req.body.USRNM;
    var FLAG = req.body.FLAG;

    connection.query("UPDATE jual set TGL=?, JTEMPO=?, PER=?, NO_SJ=?, KODEC=?, NAMAC=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, TOTAL=?, NETT=?, USRNM=?, FLAG=? WHERE NO_BUKTI=?", [TGL, JTEMPO, PER, NO_SJ, KODEC, NAMAC, ALAMAT, KOTA, NOTES, TOTAL_QTY, TOTAL, NETT, USRNM, FLAG, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Jual Header', res);

            }
        });
};

exports.modaljual = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from jual where KODEC like ? or NAMAC like ? order by KODEC", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from jual order by KODEC",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.carijualpiu = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from jual where (NO_BUKTI like ? or NAMAC like ?) and FLAG='JL'", [filter_cari, filter_cari], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.carijual = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from jual where (NO_BUKTI like ? or TOTAL like ?) and FLAG='JL' and KODEC like ?", [filter_cari, filter_cari, filter_cari], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.hapusjual = function (req, res) {
    var no_bukti = req.body.no_bukti;
    var posted = req.body.posted;
    connection.query("DELETE from jual where NO_BUKTI=?; DELETE from juald where NO_BUKTI=?; UPDATE po SET POSTED='0' WHERE NO_BUKTI=?", [no_bukti, no_bukti, posted],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL PO NONBAHAN
///HEADER
exports.tambahheaderpononbahan = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into po (NO_BUKTI,DR,KODES,NAMAS,TGL,JTEMPO,KOTA,ALAMAT,KURS,RATE,PROD,JENIS,SUBDIV,AN,NOTESBL,NOTESKRM,KET,PKP,TOTAL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpononbahan = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var KD_BRG = req.body.kode_barang;
    var NA_BRG = req.body.nama_barang;
    var SATUAN_PPC = req.body.satuan_ppc;
    var QTY_PPC = Number(req.body.qty_ppc);
    var SATUAN = req.body.satuan;
    var HARGA = Number(req.body.harga);
    var QTY = Number(req.body.qty);
    var TOTAL = Number(req.body.total);
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into pod (REC,NO_BUKTI,PER,KD_BHN,NA_BHN,SATUANPP,QTYPP,SATUAN,HARGA,QTY,TOTAL,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, KD_BRG, NA_BRG, SATUAN_PPC, QTY_PPC, SATUAN, HARGA, QTY, TOTAL, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpononbahan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PB' AND FLAG2='NB'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpononbahan = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE po set DR=?, KODES=?, NAMAS=?, TGL=?, JTEMPO=?, KOTA=?,ALAMAT=?, KURS=?, RATE=?, PROD=?, JENIS=?, SUBDIV=?, AN=?, NOTESBL=?, NOTESKRM=?, KET=?, PKP=?, TOTAL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};
exports.modalpononbahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripononbahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PB' and FLAG2='NB'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL PO IMPORT
///HEADER
exports.tambahheaderpoimport = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into po (NO_BUKTI,DR,KODES,NAMAS,TGL,JTEMPO,KOTA,ALAMAT,KURS,RATE,PROD,JENIS,SUBDIV,AN,NOTESBL,NOTESKRM,KET,PKP,TOTAL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpoimport = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var KD_BRG = req.body.kode_barang;
    var NA_BRG = req.body.nama_barang;
    var SATUAN_PPC = req.body.satuan_ppc;
    var QTY_PPC = Number(req.body.qty_ppc);
    var SATUAN = req.body.satuan;
    var HARGA = Number(req.body.harga);
    var QTY = Number(req.body.qty);
    var TOTAL = Number(req.body.total);
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into pod (REC,NO_BUKTI,PER,KD_BHN,NA_BHN,SATUANPP,QTYPP,SATUAN,HARGA,QTY,TOTAL,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, KD_BRG, NA_BRG, SATUAN_PPC, QTY_PPC, SATUAN, HARGA, QTY, TOTAL, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpoimport = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PB' AND FLAG2='IMP'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpoimport = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE po set DR=?, KODES=?, NAMAS=?, TGL=?, JTEMPO=?, KOTA=?,ALAMAT=?, KURS=?, RATE=?, PROD=?, JENIS=?, SUBDIV=?, AN=?, NOTESBL=?, NOTESKRM=?, KET=?, PKP=?, TOTAL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};
exports.modalpoimport = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripoimport = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PB' and FLAG2='IMP'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL MESIN
///HEADER
exports.tambahheaderpomesin = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into po (NO_BUKTI,DR,KODES,NAMAS,TGL,JTEMPO,KOTA,ALAMAT,KURS,RATE,PROD,JENIS,SUBDIV,AN,NOTESBL,NOTESKRM,KET,PKP,TOTAL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailpomesin = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var KD_BRG = req.body.kode_barang;
    var NA_BRG = req.body.nama_barang;
    var SATUAN_PPC = req.body.satuan_ppc;
    var QTY_PPC = Number(req.body.qty_ppc);
    var SATUAN = req.body.satuan;
    var HARGA = Number(req.body.harga);
    var QTY = Number(req.body.qty);
    var TOTAL = Number(req.body.total);
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into pod (REC,NO_BUKTI,PER,KD_BHN,NA_BHN,SATUANPP,QTYPP,SATUAN,HARGA,QTY,TOTAL,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, KD_BRG, NA_BRG, SATUAN_PPC, QTY_PPC, SATUAN, HARGA, QTY, TOTAL, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilpomesin = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PB' AND FLAG2='IM'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderpomesin = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE po set DR=?, KODES=?, NAMAS=?, TGL=?, JTEMPO=?, KOTA=?,ALAMAT=?, KURS=?, RATE=?, PROD=?, JENIS=?, SUBDIV=?, AN=?, NOTESBL=?, NOTESKRM=?, KET=?, PKP=?, TOTAL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};
exports.modalpomesin = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caripomesin = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PB' and FLAG2='IM'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL SPAREPART
///HEADER
exports.tambahheaderposparepart = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into po (NO_BUKTI,DR,KODES,NAMAS,TGL,JTEMPO,KOTA,ALAMAT,KURS,RATE,PROD,JENIS,SUBDIV,AN,NOTESBL,NOTESKRM,KET,PKP,TOTAL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Bank Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailposparepart = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var PER = req.body.per;
    var KD_BRG = req.body.kode_barang;
    var NA_BRG = req.body.nama_barang;
    var SATUAN_PPC = req.body.satuan_ppc;
    var QTY_PPC = Number(req.body.qty_ppc);
    var SATUAN = req.body.satuan;
    var HARGA = Number(req.body.harga);
    var QTY = Number(req.body.qty);
    var TOTAL = Number(req.body.total);
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into pod (REC,NO_BUKTI,PER,KD_BHN,NA_BHN,SATUANPP,QTYPP,SATUAN,HARGA,QTY,TOTAL,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, PER, KD_BRG, NA_BRG, SATUAN_PPC, QTY_PPC, SATUAN, HARGA, QTY, TOTAL, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah PO Detail', res);

            }
        });
};

exports.tampilposparepart = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from po where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PB' AND FLAG2='SP'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderposparepart = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DRAGON = req.body.dragon;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var TANGGAL = req.body.tanggal;
    var JTEMPO = req.body.jtempo;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var MATAUANG = req.body.matauang;
    var KURS = req.body.kurs;
    var PRODUK = req.body.produk;
    var JENIS = req.body.jenis;
    var SUBDIV = req.body.subdiv;
    var AN = req.body.an;
    var NOTABAYAR = req.body.notabayar;
    var NOTAKIRIM = req.body.notakirim;
    var NOTES = req.body.notes;
    var PAJAK = req.body.pajak;
    var JUMLAH = Number(req.body.total);
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE po set DR=?, KODES=?, NAMAS=?, TGL=?, JTEMPO=?, KOTA=?,ALAMAT=?, KURS=?, RATE=?, PROD=?, JENIS=?, SUBDIV=?, AN=?, NOTESBL=?, NOTESKRM=?, KET=?, PKP=?, TOTAL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [DRAGON, KODES, NAMAS, TANGGAL, JTEMPO, KOTA, ALAMAT, MATAUANG, KURS, PRODUK, JENIS, SUBDIV, AN, NOTABAYAR, NOTAKIRIM, NOTES, PAJAK, JUMLAH, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit PO Header', res);

            }
        });
};
exports.modalposparepart = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from po where KODES like ? or NAMAS like ? order by KODES", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from po order by KODES",
            function (error, rows, fields) {
                if (error) {
                    connection.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.cariposparepart = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from po where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='PB' and FLAG2='SP'", [filter_cari, filter_cari, filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///========================/// TRANSAKSI PO BARANG IMPORT ///========================///
//paginate
exports.belibahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from beli where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_belibahanpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from beli where FLAG='BL' and TYP='L' and GOL='A' and (KODES like ? or NAMAS like ?)", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
///HEADER
exports.tambahheaderbelibahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_SJ = req.body.NO_SJ;
    var TGL_SJ = req.body.TGL_SJ;
    var TGL_INVOICE = req.body.TGL_INVOICE;
    var NO_FP = req.body.NO_FP;
    var TGL_FP = req.body.TGL_FP;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var PPH = req.body.PPH;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var NETT1 = req.body.NETT1;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var RPPPH = req.body.RPPPH;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var NETT = req.body.NETT;
    var FLAG = req.body.FLAG;
    var TYP = req.body.TYP;
    var USRIN = req.body.USRIN;
    var PER = req.body.PER;
    var GOL = req.body.GOL;
    var NO_PO = req.body.NO_PO;
    var SISA = req.body.SISA;
    var TG_IN = req.body.TG_IN;
    var INVOICE = req.body.INVOICE;
    var INVOICEX = req.body.INVOICEX;

    connection.query("INSERT INTO beli (NO_BUKTI,TGL,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,NO_SJ,TGL_SJ,INVOICE,INVOICEX,TGL_INVOICE,NO_FP,TGL_FP,NO_PO) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI,TGL,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRIN,TG_IN,FLAG,PER,TYP,GOL,NO_SJ,TGL_SJ,INVOICE,INVOICEX,TGL_INVOICE,NO_FP,TGL_FP,NO_PO],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbelibahan = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var QTYPO = req.body.QTYPO;
    var KD_BHN = req.body.KD_BHN;
    var NA_BHN = req.body.NA_BHN;
    var SATUAN = req.body.SATUAN;
    var QTY = req.body.QTY;
    var HARGA = req.body.HARGA;
    var TOTAL = req.body.TOTAL;
    var KET = req.body.KET;
    var HARGA1 = req.body.HARGA1;
    var TOTAL1 = req.body.TOTAL1;
    var BLT = req.body.BLT;
    var DISC = req.body.DISC;
    var RPDISC = req.body.RPDISC;
    var PER = req.body.PER;
    var FLAG = req.body.FLAG;
    var TYP = req.body.TYP;
    var GOL = req.body.GOL;
    var NO_PO = req.body.NO_PO;

    connection.query("insert into belid (REC, NO_BUKTI, QTYPO, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET, HARGA1, TOTAL1, BLT, DISC, RPDISC, PER, FLAG, TYP, GOL, NO_PO) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, QTYPO, KD_BHN, NA_BHN, SATUAN, QTY, HARGA, TOTAL, KET, HARGA1, TOTAL1, BLT, DISC, RPDISC, PER, FLAG, TYP, GOL, NO_PO],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Detail', res);

            }
        });
};

exports.tampilbelibahan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    var periode = req.body.periode;
    connection.query("select * from beli where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND PER=? AND TYP='L' AND GOL='A'", [nobukti, nobukti, tgl_awal, tgl_akhir, periode], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbelibahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var NO_SJ = req.body.NO_SJ;
    var TGL_SJ = req.body.TGL_SJ;
    var TGL_INVOICE = req.body.TGL_INVOICE;
    var NO_FP = req.body.NO_FP;
    var TGL_FP = req.body.TGL_FP;
    var CURR = req.body.CURR;
    var CURRNM = req.body.CURRNM;
    var RATE = req.body.RATE;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var TOTAL_QTY = req.body.TOTAL_QTY;
    var TOTAL1 = req.body.TOTAL1;
    var DISC = req.body.DISC;
    var PPN = req.body.PPN;
    var PPH = req.body.PPH;
    var DISC1 = req.body.DISC1;
    var PPN1 = req.body.PPN1;
    var PPH1 = req.body.PPH1;
    var NETT1 = req.body.NETT1;
    var TOTAL = req.body.TOTAL;
    var RPDISC = req.body.RPDISC;
    var RPPPN = req.body.RPPPN;
    var RPPPH = req.body.RPPPH;
    var RPDISC1 = req.body.RPDISC1;
    var RPPPN1 = req.body.RPPPN1;
    var RPPPH1 = req.body.RPPPH1;
    var NETT = req.body.NETT;
    var FLAG = req.body.FLAG;
    var TYP = req.body.TYP;
    var USRNM = req.body.USRNM;
    var PER = req.body.PER;
    var GOL = req.body.GOL;
    var NO_PO = req.body.NO_PO;
    var SISA = req.body.SISA;
    var TG_SMP = req.body.TG_SMP;
    var INVOICE = req.body.INVOICE;
    var INVOICEX = req.body.INVOICEX;

    connection.query("UPDATE beli set TGL=?, CURR=?, CURRNM=?, RATE=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, TOTAL_QTY=?, TOTAL1=?, DISC=?, PPN=?, NETT1=?, DISC1=?, PPN1=?, PPH1=?, PPH=?, TOTAL=?, RPDISC=?, RPPPN=?, NETT=?, SISA=?, RPDISC1=?, RPPPN1=?, RPPPH1=?, RPPPH=?, USRNM=?, TG_SMP=?, FLAG=?, PER=?, TYP=?, GOL=?, NO_SJ=?, TGL_SJ=?, INVOICE=?,INVOICEX=?, TGL_INVOICE=?, NO_FP=?, TGL_FP=?, NO_PO=? WHERE NO_BUKTI=?", [NO_BUKTI,TGL,CURR,CURRNM,RATE,KODES,NAMAS,ALAMAT,KOTA,NOTES,TOTAL_QTY,TOTAL1,DISC,PPN,NETT1,DISC1,PPN1,PPH1,PPH,TOTAL,RPDISC,RPPPN,NETT,SISA,RPDISC1,RPPPN1,RPPPH1,RPPPH,USRNM,TG_SMP,FLAG,PER,TYP,GOL,NO_SJ,TGL_SJ,INVOICE,INVOICEX,TGL_INVOICE,NO_FP,TGL_FP,NO_PO],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};

exports.modalbelibahan = function (req, res) {
    var cari = '%' + req.body.cari + '%';
    if ([cari] != '') {
        connection.query("select * from beli where KD_BHN like ? or NA_BHN like ? order by KD_BHN", [cari, cari],
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    } else {
        connection.query("select * from beli order by KD_BHN",
            function (error, rows, fields) {
                if (error) {
                    console.log(error);
                } else {

                    response.ok(rows, res);

                }
            });
    };
};

exports.caribelibahan = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select * from beli where (KODES like ? or NAMAS like ? or ALAMAT like ? or KOTA like ?) and FLAG='BL' and NO_BUKTI IN (SELECT NO_BUKTI FROM belid WHERE SISA>0)", [filter_cari, filter_cari,filter_cari, filter_cari], function (error, rows, fields) {
        if (error) {
            console.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.caribelibahanhut = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    // var namas = req.body.namas;
    if (req.body.cari != '') {
        connection.query("select * from beli where KODES like ? or NAMAS like ?", [filter_cari, filter_cari], function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
    } else {
        connection.query("select * from beli ", function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
    }
};

exports.hapusbelibahan = function (req, res) {
    var no_bukti = req.body.no_bukti;
    var posted = req.body.posted;
    connection.query("DELETE from beli where NO_BUKTI=?; DELETE from belid where NO_BUKTI=?; UPDATE po SET POSTED='0' WHERE NO_BUKTI=?", [no_bukti, no_bukti, posted],
        function (error, rows, fields) {
            if (error) {
                console.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER BELI NON BAHAN
///HEADER
exports.tambahheaderbelinonbahan = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into beli (NO_BUKTI,DR,NO_PO,TGL_PO,TGL,JTEMPO,KODES,NAMAS,KURS,KOTA,ALAMAT,TGL_FKTR,NO_FKTR,NOTES,PPN,NETT,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbelinonbahan = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kdbhn;
    var NA_BHN = req.body.nabhn;
    var DR = req.body.dr;
    var SATUANPP = req.body.satuanpp;
    var QTYPP = Number(req.body.qtypp);
    var SATUAN = req.body.satuan;
    var QTY = Number(req.body.qty);
    var HARGA = Number(req.body.harga);
    var BULAT = Number(req.body.bulat);
    var TOTAL = Number(req.body.total);
    var DISK = Number(req.body.disk);
    var VAL = req.body.val;
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into belid (REC,NO_BUKTI,KD_BHN,NA_BHN,DR,SATUANPP,QTYPP,SATUAN,QTY,HARGA,BULAT,TOTAL,DISK,VAL,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, DR, SATUANPP, QTYPP, SATUAN, QTY, HARGA, BULAT, TOTAL, DISK, VAL, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Detail', res);

            }
        });
};

exports.tampilbelinonbahan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from beli where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND FLAG2='NB'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbelinonbahan = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;
    connection.query("UPDATE beli set DR=?, NO_PO=?, TGL_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KURS=?, KOTA=?, ALAMAT=?, TGL_FKTR=?, NO_FKTR=?, NOTES=?, PPN=?, NETT=?, USRNM=?, FLAG=?, FLAG2=?, PER=? WHERE NO_BUKTI=?", [DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};
exports.caribelinonbahan = function (req, res) {
    connection.query("select * from beli where FLAG2='NB'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

///TRANSAKSI HEADER BELI IMPORT
///HEADER
exports.tambahheaderbeliimport = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into beli (NO_BUKTI,DR,NO_PO,TGL_PO,TGL,JTEMPO,KODES,NAMAS,KURS,KOTA,ALAMAT,TGL_FKTR,NO_FKTR,NOTES,PPN,NETT,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbeliimport = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kdbhn;
    var NA_BHN = req.body.nabhn;
    var DR = req.body.dr;
    var SATUANPP = req.body.satuanpp;
    var QTYPP = Number(req.body.qtypp);
    var SATUAN = req.body.satuan;
    var QTY = Number(req.body.qty);
    var HARGA = Number(req.body.harga);
    var BULAT = Number(req.body.bulat);
    var TOTAL = Number(req.body.total);
    var DISK = Number(req.body.disk);
    var VAL = req.body.val;
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into belid (REC,NO_BUKTI,KD_BHN,NA_BHN,DR,SATUANPP,QTYPP,SATUAN,QTY,HARGA,BULAT,TOTAL,DISK,VAL,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, DR, SATUANPP, QTYPP, SATUAN, QTY, HARGA, BULAT, TOTAL, DISK, VAL, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Detail', res);

            }
        });
};

exports.tampilbeliimport = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from beli where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND FLAG2='IMP'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbeliimport = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;
    connection.query("UPDATE beli set DR=?, NO_PO=?, TGL_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KURS=?, KOTA=?, ALAMAT=?, TGL_FKTR=?, NO_FKTR=?, NOTES=?, PPN=?, NETT=?, USRNM=?, FLAG=?, FLAG2=?, PER=? WHERE NO_BUKTI=?", [DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};
exports.caribeliimport = function (req, res) {
    connection.query("select * from beli where FLAG2='IMP'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

///TRANSAKSI HEADER BELI MESIN/IMPORT
///HEADER
exports.tambahheaderbelimesin = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into beli (NO_BUKTI,DR,NO_PO,TGL_PO,TGL,JTEMPO,KODES,NAMAS,KURS,KOTA,ALAMAT,TGL_FKTR,NO_FKTR,NOTES,PPN,NETT,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbelimesin = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kdbhn;
    var NA_BHN = req.body.nabhn;
    var DR = req.body.dr;
    var SATUANPP = req.body.satuanpp;
    var QTYPP = Number(req.body.qtypp);
    var SATUAN = req.body.satuan;
    var QTY = Number(req.body.qty);
    var HARGA = Number(req.body.harga);
    var BULAT = Number(req.body.bulat);
    var TOTAL = Number(req.body.total);
    var DISK = Number(req.body.disk);
    var VAL = req.body.val;
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into belid (REC,NO_BUKTI,KD_BHN,NA_BHN,DR,SATUANPP,QTYPP,SATUAN,QTY,HARGA,BULAT,TOTAL,DISK,VAL,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, DR, SATUANPP, QTYPP, SATUAN, QTY, HARGA, BULAT, TOTAL, DISK, VAL, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Detail', res);

            }
        });
};

exports.tampilbelimesin = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from beli where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND FLAG2='IM'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbelimesin = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;
    connection.query("UPDATE beli set DR=?, NO_PO=?, TGL_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KURS=?, KOTA=?, ALAMAT=?, TGL_FKTR=?, NO_FKTR=?, NOTES=?, PPN=?, NETT=?, USRNM=?, FLAG=?, FLAG2=?, PER=? WHERE NO_BUKTI=?", [DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};
exports.caribelimesin = function (req, res) {
    connection.query("select * from beli where FLAG2='IM'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

///TRANSAKSI HEADER BELI SPAREPART
///HEADER
exports.tambahheaderbelisparepart = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into beli (NO_BUKTI,DR,NO_PO,TGL_PO,TGL,JTEMPO,KODES,NAMAS,KURS,KOTA,ALAMAT,TGL_FKTR,NO_FKTR,NOTES,PPN,NETT,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailbelisparepart = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kdbhn;
    var NA_BHN = req.body.nabhn;
    var DR = req.body.dr;
    var SATUANPP = req.body.satuanpp;
    var QTYPP = Number(req.body.qtypp);
    var SATUAN = req.body.satuan;
    var QTY = Number(req.body.qty);
    var HARGA = Number(req.body.harga);
    var BULAT = Number(req.body.bulat);
    var TOTAL = Number(req.body.total);
    var DISK = Number(req.body.disk);
    var VAL = req.body.val;
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;

    connection.query("insert into belid (REC,NO_BUKTI,KD_BHN,NA_BHN,DR,SATUANPP,QTYPP,SATUAN,QTY,HARGA,BULAT,TOTAL,DISK,VAL,USRNM,FLAG,FLAG2,PER) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, DR, SATUANPP, QTYPP, SATUAN, QTY, HARGA, BULAT, TOTAL, DISK, VAL, USRNM, FLAG, FLAG2, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Beli Detail', res);

            }
        });
};

exports.tampilbelisparepart = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from beli where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='BL' AND FLAG2='SP'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderbelisparepart = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var DR = req.body.dr;
    var NO_PO = req.body.nopo;
    var TGL_PO = req.body.tglpo;
    var TGL = req.body.tgl;
    var JTEMPO = req.body.jtempo;
    var KODES = req.body.kodes;
    var NAMAS = req.body.namas;
    var KURS = req.body.kurs;
    var KOTA = req.body.kota;
    var ALAMAT = req.body.alamat;
    var TGL_FKTR = req.body.tglfktr;
    var NO_FKTR = req.body.nofktr;
    var NOTES = req.body.notes;
    var PPN = Number(req.body.ppn);
    var NETT = Number(req.body.nett);
    var USRNM = req.body.usrnm;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var PER = req.body.per;
    connection.query("UPDATE beli set DR=?, NO_PO=?, TGL_PO=?, TGL=?, JTEMPO=?, KODES=?, NAMAS=?, KURS=?, KOTA=?, ALAMAT=?, TGL_FKTR=?, NO_FKTR=?, NOTES=?, PPN=?, NETT=?, USRNM=?, FLAG=?, FLAG2=?, PER=? WHERE NO_BUKTI=?", [DR, NO_PO, TGL_PO, TGL, JTEMPO, KODES, NAMAS, KURS, KOTA, ALAMAT, TGL_FKTR, NO_FKTR, NOTES, PPN, NETT, USRNM, FLAG, FLAG2, PER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};
exports.caribelisparepart = function (req, res) {
    connection.query("select * from beli where FLAG2='SP'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

///TRANSAKSI HEADER HUT BAHAN
//paginate
exports.hutbahan_paginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    var offset_page = Number(req.body.offset);
    var limit_page = Number(req.body.limit);
    connection.query("select * from hut where KODES like ? or NAMAS like ? LIMIT ?, ?", [filter_cari, filter_cari, offset_page, limit_page],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///paginate
exports.count_hutbahanpaginate = function (req, res) {
    var filter_cari = '%' + req.body.cari + '%';
    connection.query("select COUNT(*) from hut where KODES like ? or NAMAS like ?", [filter_cari, filter_cari],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);
            }
        });
}
///HEADER
exports.tambahheaderhutbahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var PER = req.body.PER;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var BAYAR = req.body.BAYAR;
    var TOTAL = Number(req.body.TOTAL);
    var FLAG = req.body.FLAG;
    var USRNM = req.body.USRNM;

    connection.query("insert into hut (NO_BUKTI, TGL, PER, KODES, NAMAS, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?)", [NO_BUKTI, TGL, PER, KODES, NAMAS, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi thut Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailhutbahan = function (req, res) {
    var REC = req.body.REC;
    var NO_BUKTI = req.body.NO_BUKTI;
    var NO_FAKTUR = req.body.NO_BELI;
    var URAIAN = req.body.NOTES;
    var TOTAL = req.body.TOTAL;
    var BAYAR = req.body.BAYAR;
    var FLAG = req.body.FLAG;
    var PER = req.body.PER;

    connection.query("insert into hutd (REC,NO_BUKTI,NO_FAKTUR,URAIAN,TOTAL,BAYAR,FLAG,PER) values (?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, NO_FAKTUR, URAIAN, TOTAL, BAYAR, FLAG, PER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Transaksi Pembayaran Hutang Detail', res);

            }
        });
};

exports.tampilhutbahan = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from hut where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ? AND FLAG='PH'", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderhutbahan = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;
    var TGL = req.body.TGL;
    var PER = req.body.PER;
    var KODES = req.body.KODES;
    var NAMAS = req.body.NAMAS;
    var ALAMAT = req.body.ALAMAT;
    var KOTA = req.body.KOTA;
    var NOTES = req.body.NOTES;
    var BAYAR = req.body.BAYAR;
    var TOTAL = Number(req.body.TOTAL);
    var FLAG = req.body.FLAG;
    var USRNM = req.body.USRNM;

    connection.query("UPDATE hut set TGL=?, PER=?, KODES=?, NAMAS=?, ALAMAT=?, KOTA=?, NOTES=?, BAYAR=?, TOTAL=?, FLAG=?, USRNM=? WHERE NO_BUKTI=?", [TGL, PER, KODES, NAMAS, ALAMAT, KOTA, NOTES, BAYAR, TOTAL, FLAG, USRNM, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Transaksi Beli Header', res);

            }
        });
};
exports.carihutbahan = function (req, res) {
    connection.query("select * from hut where FLAG='PH'", function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};
exports.ambilhutdetail = function (req, res) {
    var nobukti = req.body.cari;
    // var filter_cari = '%'+req.body.cari+'%';
    connection.query("SELECT * from hut where NO_BUKTI=?", [nobukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {
                response.ok(rows, res);

            }
        });
}
exports.hapushutbahan = function (req, res) {
    var no_bukti = req.body.no_bukti;
    connection.query("DELETE from hut where NO_BUKTI=?; DELETE from hutd where NO_BUKTI=?", [no_bukti, no_bukti],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
}

///TRANSAKSI HEADER DETAIL STOK
///HEADER
exports.tambahheaderstok = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TGL = req.body.tgl;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into stocka (NO_BUKTI,TGL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?)", [NO_BUKTI, TGL, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Stok Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailstok = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kode_bahan;
    var NA_BHN = req.body.nama_bahan;
    var WARNA = req.body.warna;
    var SIZE = req.body.size;
    var GOL = req.body.golongan;
    var PAIR = req.body.pair;
    var LUSIN = req.body.lusin;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into stockad (REC,NO_BUKTI,KD_BHN,NA_BHN,WARNA,SIZE,GOL,QTYP,QTY,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, WARNA, SIZE, GOL, PAIR, LUSIN, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Stok Detail', res);

            }
        });
};

exports.tampilstok = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from stocka where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ?", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderstok = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TGL = req.body.tgl;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE stocka set TGL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [TGL, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Koreksi Header', res);

            }
        });
};

exports.tambahheaderstok = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TGL = req.body.tgl;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into stocka (NO_BUKTI,TGL,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?)", [NO_BUKTI, TGL, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Stok Header', res);

            }
        });
};

///DETAIL
exports.tambahdetailstok = function (req, res) {
    var REC = req.body.rec;
    var NO_BUKTI = req.body.nobukti;
    var KD_BHN = req.body.kode_bahan;
    var NA_BHN = req.body.nama_bahan;
    var WARNA = req.body.warna;
    var SIZE = req.body.size;
    var GOL = req.body.golongan;
    var PAIR = req.body.pair;
    var LUSIN = req.body.lusin;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("insert into stockad (REC,NO_BUKTI,KD_BHN,NA_BHN,WARNA,SIZE,GOL,QTYP,QTY,PER,FLAG,FLAG2,USRNM) values (?,?,?,?,?,?,?,?,?,?,?,?,?)", [REC, NO_BUKTI, KD_BHN, NA_BHN, WARNA, SIZE, GOL, PAIR, LUSIN, PER, FLAG, FLAG2, USER],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Tambah Stok Detail', res);

            }
        });
};

exports.tampilstok = function (req, res) {
    var nobukti = '%' + req.body.cari + '%';
    var tgl_awal = req.body.tglawal;
    var tgl_akhir = req.body.tglakhir;
    connection.query("select * from stocka where if(?<>'',NO_BUKTI like ?,true) AND TGL BETWEEN ? AND ?", [nobukti, nobukti, tgl_awal, tgl_akhir], function (error, rows, fields) {
        if (error) {
            connection.log(error);
        } else {

            response.ok(rows, res);

        }
    });
};

exports.editheaderstok = function (req, res) {
    var NO_BUKTI = req.body.nobukti;
    var TGL = req.body.tgl;
    var PER = req.body.per;
    var FLAG = req.body.flag;
    var FLAG2 = req.body.flag2;
    var USER = req.body.user;
    connection.query("UPDATE stocka set TGL=?, PER=?, FLAG=?, FLAG2=?, USRNM=? WHERE NO_BUKTI=?", [TGL, PER, FLAG, FLAG2, USER, NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok('Berhasil Edit Koreksi Header', res);

            }
        });
};








///LAPORAN PO
exports.lappo = function (req, res) {


    var tgla = req.body.tgla;
    var tglb = req.body.tglb;
    var namasa = req.body.namasa;
    var namasb = req.body.namasb;

    connection.query("select po.NO_PO, po.TGL, po.JTEMPO, po.KODES, po.NAMAS, po.KD_BRG, po.NA_BRG, po.KG, po.HARGA, po.TOTAL, po.NOTES, po.RPRATE, po.RPHARGA, po.RPTOTAL from po where TGL between ? and ?  and po.NAMAS between ? and ? and gol='Y'", [tgla, tglb, namasa, namasb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///LAPORAN PO BAHAN
exports.lappobahan = function (req, res) {
    var tgl_a = req.body.tgl_a;
    var tgl_b = req.body.tgl_b;
    var namas_a = req.body.namas_a;
    var namas_b = req.body.namas_b;
    var bahan_a = req.body.bahan_a;
    var bahan_b = req.body.bahan_b;

    connection.query("SELECT * FROM	po,	pod WHERE po.NO_BUKTI = pod.NO_BUKTI AND po.TGL BETWEEN ? AND ? AND IF(?<>'', IF(?<>'', po.KODES BETWEEN ? AND ?, po.KODES BETWEEN ? AND '~~~'), true) AND IF(?<>'', IF(?<>'', pod.KD_BHN BETWEEN ? AND ?, pod.KD_BHN BETWEEN ? AND '~~~'), true) AND po.FLAG = 'PO' ORDER BY po.NO_BUKTI;", [tgl_a, tgl_b, namas_a, namas_b, namas_a, namas_b, namas_a, bahan_a, bahan_b, bahan_a, bahan_b, bahan_a],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PO NON BAHAN
exports.lappon = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;
    connection.query(" select po.NO_PO, po.TGL, po.JTEMPO, po.KODES, po.NAMAS, po.KD_BRG, po.NA_BRG, po.KG, po.HARGA, po.TOTAL, po.NOTES, po.RPRATE, po.RPHARGA, po.RPTOTAL from po where TGL between ? and ?  and gol='Z'", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN BELI BAHAN
exports.lapbelibahan = function (req, res) {
    var tgl_a = req.body.tgl_a;
    var tgl_b = req.body.tgl_b;
    var sup_a = req.body.sup_a;
    var sup_b = req.body.sup_b;
    var bhn_a = req.body.bhn_a;
    var bhn_b = req.body.bhn_b;

    connection.query("SELECT * FROM	beli,	belid WHERE beli.NO_BUKTI = belid.NO_BUKTI AND beli.TGL BETWEEN ? AND ? AND IF(?<>'', IF(?<>'', beli.KODES BETWEEN ? AND ?, beli.KODES BETWEEN ? AND '~~~'), true) AND IF(?<>'', IF(?<>'', belid.KD_BHN BETWEEN ? AND ?, belid.KD_BHN BETWEEN ? AND '~~~'), true) AND beli.FLAG = 'BL' ORDER BY beli.NO_BUKTI;", [tgl_a, tgl_b, sup_a, sup_b, sup_a, sup_b, sup_a, bhn_a, bhn_b, bhn_a, bhn_b, bhn_a],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN THUT BAHAN
exports.lapthutbahan = function (req, res) {
    var tgl_a = req.body.tgl_a;
    var tgl_b = req.body.tgl_b;
    var sup_a = req.body.sup_a;
    var sup_b = req.body.sup_b;

    connection.query("SELECT * FROM	beli WHERE beli.TGL BETWEEN ? AND ? AND IF(?<>'', IF(?<>'', beli.KODES BETWEEN ? AND ?, beli.KODES BETWEEN ? AND '~~~'), true) AND beli.FLAG = 'HT' ORDER BY beli.NO_BUKTI;", [tgl_a, tgl_b, sup_a, sup_b, sup_a, sup_b, sup_a],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN HUT BAHAN
exports.laphutbahan = function (req, res) {
    var tgl_a = req.body.tgl_a;
    var tgl_b = req.body.tgl_b;
    var sup_a = req.body.sup_a;
    var sup_b = req.body.sup_b;

    connection.query("SELECT * FROM	hut WHERE hut.TGL BETWEEN ? AND ? AND IF(?<>'', IF(?<>'', hut.KODES BETWEEN ? AND ?, hut.KODES BETWEEN ? AND '~~~'), true) AND hut.FLAG = 'PH' ORDER BY hut.NO_BUKTI;", [tgl_a, tgl_b, sup_a, sup_b, sup_a, sup_b, sup_a],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN SO
exports.lapso = function (req, res) {
    var tgl_a = req.body.tgl_a;
    var tgl_b = req.body.tgl_b;
    var cus_a = req.body.cus_a;
    var cus_b = req.body.cus_b;
    var brg_a = req.body.brg_a;
    var brg_b = req.body.brg_b;

    connection.query("SELECT * FROM	so, sod WHERE so.NO_BUKTI = sod.NO_BUKTI AND so.TGL BETWEEN ? AND ? AND IF(?<>'', IF(?<>'', so.KODEC BETWEEN ? AND ?, so.KODEC BETWEEN ? AND '~~~'), true) AND IF(?<>'', IF(?<>'', sod.KD_BRG BETWEEN ? AND ?, sod.KD_BRG BETWEEN ? AND '~~~'), true) AND so.FLAG = 'SO' ORDER BY so.NO_BUKTI;", [tgl_a, tgl_b, cus_a, cus_b, cus_a, cus_b, cus_a, brg_a, brg_b, brg_a, brg_b, brg_a],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN SJ
exports.lapsj = function (req, res) {


    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("select * from surat, suratd where surat.NO_BUKTI=suratd.NO_BUKTI and TGL between ? and ? and surat.flag='SJ' ORDER BY surat.NO_BUKTI;", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN JUAL
exports.lapjual = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("select * from jual, juald where jual.NO_BUKTI=juald.NO_BUKTI and TGL between ? and ? and jual.flag='JL' ORDER BY jual.NO_BUKTI;", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN STOCK A
exports.lapstocka = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("select * from stocka, stockad where stocka.NO_BUKTI=stockad.NO_BUKTI and TGL between ? and ? and stocka.flag='KA' ORDER BY stocka.NO_BUKTI;", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN STOCK B
exports.lapstockb = function (req, res) {
    var per = req.body.per;
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("SELECT stocka.no_bukti AS NO_BUKTI, stockad.kd_bHN AS KD_BHN, stockad.na_bHN AS NA_BHN, stockad.satuan AS SATUAN, stockad.qty AS QTY, stockad.HARGA, stockad.TOTAL FROM stocka, stockad WHERE stocka.no_bukti = stockad.no_bukti AND stocka.PER = ? AND stocka.TGL = ? AND stocka.TGL = ? AND stockad.flag='KA' ORDER BY stockad.no_bukti;", [per, tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PAKAI
exports.lappakai = function (req, res) {


    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("select * from pakai, pakaid where pakai.NO_BUKTI=pakaid.NO_BUKTI and TGL between ? and ? and pakai.flag='PK' ORDER BY pakai.NO_BUKTI;", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN TERIMA
exports.lapterima = function (req, res) {


    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query("select * from terima, terimad where terima.NO_BUKTI=terimad.NO_BUKTI and TGL between ? and ? and terima.flag='TR' ORDER BY terima.NO_BUKTI;", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN KAS
exports.lapkas = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query(" select kas.NO_BUKTI, kas.TGL, kas.KET, kas.BACNO, kas.BNAMA, kas.TYPE, kas.JUMLAH from kas where TGL between ? and ?", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN BANK
exports.lapbank = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query(" select bank.NO_BUKTI, bank.TGL, bank.KET, bank.BACNO, bank.BNAMA, bank.TYPE, bank.JUMLAH from bank where TGL between ? and ?", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN MEMO
exports.lapmemo = function (req, res) {
    var tgla = req.body.tgla;
    var tglb = req.body.tglb;

    connection.query(" select memo.NO_BUKTI, memo.TGL, memo.KET, memo.DEBET, memo.KREDIT from memo where TGL between ? and ?", [tgla, tglb],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PERINCIAN STOK BAHAN
exports.lapperincianstk_bhn = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var AW = 'bhnd.AW' + per.substring(0, 2);
    var MA = 'bhnd.MA' + per.substring(0, 2);
    var KE = 'bhnd.KE' + per.substring(0, 2);
    var LN = 'bhnd.LN' + per.substring(0, 2);
    var AK = 'bhnd.AK' + per.substring(0, 2);

    connection.query("select bhn.KD_BHN AS KODE, bhn.NA_BHN AS NAMA, ?? AS AWAL, ?? AS MASUK, ?? AS KELUAR, ?? AS LAIN, ?? AS AKHIR from bhn, bhnd WHERE bhn.KD_BHN = bhnd.KD_BHN and bhnd.YER=? order by bhn.KD_BHN", [AW, MA, KE, LN, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PERINCIAN STOK BARANG
exports.lapperincianstk_brg = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var AW = 'brgd.AW' + per.substring(0, 2);
    var MA = 'brgd.MA' + per.substring(0, 2);
    var KE = 'brgd.KE' + per.substring(0, 2);
    var LN = 'brgd.LN' + per.substring(0, 2);
    var AK = 'brgd.AK' + per.substring(0, 2);

    connection.query("select brg.KD_BRG AS KODE, brg.NA_BRG AS NAMA, ?? AS AWAL, ?? AS MASUK, ?? AS KELUAR, ?? AS LAIN, ?? AS AKHIR from brg, brgd WHERE brg.KD_BRG = brgd.KD_BRG and brgd.YER=? order by brg.KD_BRG", [AW, MA, KE, LN, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PERINCIAN HUTANG
exports.lapperincian_hut = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var AW = 'supd.AW' + per.substring(0, 2);
    var MA = 'supd.MA' + per.substring(0, 2);
    var KE = 'supd.KE' + per.substring(0, 2);
    var LN = 'supd.LN' + per.substring(0, 2);
    var AK = 'supd.AK' + per.substring(0, 2);

    connection.query("select sup.KODES AS KODE, sup.NAMAS AS NAMA, ?? AS AWAL, ?? AS MASUK, ?? AS KELUAR, ?? AS LAIN, ?? AS AKHIR from sup, supd WHERE sup.KODES = supd.KODES and supd.YER=? order by sup.KODES", [AW, MA, KE, LN, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PERINCIAN PIUTANG
exports.lapperincian_piu = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var AW = 'custd.AW' + per.substring(0, 2);
    var MA = 'custd.MA' + per.substring(0, 2);
    var KE = 'custd.KE' + per.substring(0, 2);
    var LN = 'custd.LN' + per.substring(0, 2);
    var AK = 'custd.AK' + per.substring(0, 2);

    connection.query("select cust.KODEC AS KODE, cust.NAMAC AS NAMA, ?? AS AWAL, ?? AS MASUK, ?? AS KELUAR, ?? AS LAIN, ?? AS AKHIR from cust, custd WHERE cust.KODEC = custd.KODEC and custd.YER=? order by cust.KODEC", [AW, MA, KE, LN, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN PERINCIAN NERACA
exports.lapperincian_nera = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var AW = 'accountd.AW' + per.substring(0, 2);
    var KD = 'accountd.KD' + per.substring(0, 2);
    var KK = 'accountd.KK' + per.substring(0, 2);
    var BD = 'accountd.BD' + per.substring(0, 2);
    var BK = 'accountd.BK' + per.substring(0, 2);
    var MD = 'accountd.MD' + per.substring(0, 2);
    var MK = 'accountd.MK' + per.substring(0, 2);
    var AK = 'accountd.AK' + per.substring(0, 2);

    connection.query("select account.ACNO AS KODE, account.NAMA AS NAMA, ?? AS AWAL, ?? AS KAS_DEBET, ?? AS KAS_KREDIT, ?? AS BANK_DEBET, ?? AS BANK_KREDIT, ?? AS MEMO_DEBET, ?? AS MEMO_KREDIT, ?? AS AKHIR from account, accountd WHERE account.ACNO = accountd.ACNO and accountd.YER=? order by account.ACNO", [AW, KD, KK, BD, BK, MD, MK, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN KARTU STOK BAHAN
exports.lapkartustk_bhn = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var kode1 = req.body.kode1;
    var kode2 = req.body.kode2;

    connection.query("SELECT URUT, NO_BUKTI, TGL, KODE, NAMA, URAIAN, AWAL, MASUK, KELUAR, LAIN, " +
        " if(@tempKD=KODE, @AKHIR:=@AKHIR+AWAL+MASUK-KELUAR+LAIN, @AKHIR:=AWAL+MASUK-KELUAR+LAIN) AS SALDO, (@tempKD:=KODE) as TEMPKODE from ( " +
        " SELECT 1 as URUT, '-' AS NO_BUKTI, '2022-01-01' AS TGL, bhnd.KD_BHN AS KODE, bhnd.NA_BHN AS NAMA, 'SALDO AWAL' AS URAIAN, bhnd.AW01 AS AWAL, 0 AS MASUK, 0 AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM bhn, bhnd WHERE bhn.KD_BHN=bhnd.KD_BHN and bhnd.YER=? " +
        " UNION ALL " +
        " SELECT 2 as URUT, beli.NO_BUKTI, beli.TGL, belid.KD_BHN AS KODE, belid.NA_BHN AS NAMA, CONCAT(beli.KODES, '-', beli.NAMAS) AS URAIAN, 0 AS AWAL, belid.QTY AS MASUK, 0 AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM beli, belid WHERE beli.NO_BUKTI = belid.NO_BUKTI and beli.PER=? " +
        " UNION ALL " +
        " SELECT 3 as URUT, pakai.NO_BUKTI, pakai.TGL, pakaid.KD_BHN AS KODE, pakaid.NA_BHN AS NAMA, 'PEMAKAIAN' AS URAIAN, 0 AS AWAL, 0 AS MASUK, pakaid.QTY AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM pakai, pakaid WHERE pakai.NO_BUKTI = pakaid.NO_BUKTI and pakai.PER=?  " +
        " UNION ALL " +
        " SELECT 4 as URUT, stocka.NO_BUKTI, stocka.TGL, stockad.KD_BHN AS KODE, stockad.NA_BHN AS NAMA, 'KOREKSI' AS URAIAN, 0 AS AWAL, 0 AS MASUK, 0 AS KELUAR, stockad.QTY AS LAIN, 0 AS SALDO " +
        " FROM stocka, stockad WHERE stocka.NO_BUKTI = stockad.NO_BUKTI and stocka.PER=? " +
        " ) as KARTU " +
        " JOIN (SELECT @AKHIR:=0 ) AS BB ON 1=1 " +
        " WHERE if(?<>'',if(?<>'',KODE BETWEEN ? and ?,KODE BETWEEN ? and '~~~'),true) " +
        " ORDER BY KODE,URUT,NO_BUKTI", [yer, per, per, per, kode1, kode2, kode1, kode2, kode1],
        function (error, rows, fields) {

            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN KARTU STOK BARANG
exports.lapkartustk_brg = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var kode1 = req.body.kode1;
    var kode2 = req.body.kode2;

    connection.query("SELECT URUT, NO_BUKTI, TGL, KODE, NAMA, URAIAN, AWAL, MASUK, KELUAR, LAIN, " +
        " if(@tempKD=KODE, @AKHIR:=@AKHIR+AWAL+MASUK-KELUAR+LAIN, @AKHIR:=AWAL+MASUK-KELUAR+LAIN) AS SALDO, (@tempKD:=KODE) as TEMPKODE from ( " +
        " SELECT 1 as URUT, '-' AS NO_BUKTI, '2022-01-01' AS TGL, brgd.KD_BRG AS KODE, brgd.NA_BRG AS NAMA, 'SALDO AWAL' AS URAIAN, brgd.AW01 AS AWAL, 0 AS MASUK, 0 AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM brg, brgd WHERE brg.KD_BRG=brgd.KD_BRG and brgd.YER=? " +
        " UNION ALL " +
        " SELECT 2 as URUT, terima.NO_BUKTI, terima.TGL, terimad.KD_BRG AS KODE, terimad.NA_BRG AS NAMA, 'PENERIMAAN' AS URAIAN, 0 AS AWAL, terimad.QTY AS MASUK, 0 AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM terima, terimad WHERE terima.NO_BUKTI = terimad.NO_BUKTI and terima.PER=? " +
        " UNION ALL " +
        " SELECT 3 as URUT, surat.NO_BUKTI, surat.TGL, suratd.KD_BRG AS KODE, suratd.NA_BRG AS NAMA, CONCAT(surat.KODEC, '-', surat.NAMAC) AS URAIAN, 0 AS AWAL, 0 AS MASUK, suratd.QTY AS KELUAR, 0 AS LAIN, 0 AS SALDO " +
        " FROM surat, suratd WHERE surat.NO_BUKTI = suratd.NO_BUKTI and surat.PER=?  " +
        " UNION ALL " +
        " SELECT 4 as URUT, stockb.NO_BUKTI, stockb.TGL, stockbd.KD_BRG AS KODE, stockbd.NA_BRG AS NAMA, 'KOREKSI' AS URAIAN, 0 AS AWAL, 0 AS MASUK, 0 AS KELUAR, stockbd.QTY AS LAIN, 0 AS SALDO " +
        " FROM stockb, stockbd WHERE stockb.NO_BUKTI = stockbd.NO_BUKTI and stockb.PER=? " +
        " ) as KARTU " +
        " JOIN (SELECT @AKHIR:=0 ) AS BB ON 1=1 " +
        " WHERE if(?<>'',if(?<>'',KODE BETWEEN ? and ?,KODE BETWEEN ? and '~~~'),true) " +
        " ORDER BY KODE,URUT,NO_BUKTI", [yer, per, per, per, kode1, kode2, kode1, kode2, kode1],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN KARTU HUTANG
exports.lapkartu_hut = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var kode1 = req.body.kode1;
    var kode2 = req.body.kode2;

    // SELECT '-' AS NO_BUKTI, '2022-01-01' AS TGL, supd.KODES AS KODE, supd.NAMAS AS NAMA, 'SALDO AWAL' AS URAIAN, supd.AW01 AS AWAL, 0 AS MASUK, 0 AS KELUAR, 0 AS SALDO
    //  FROM supd WHERE supd.YER = '2022' 
    // UNION ALL 
    // SELECT beli.NO_BUKTI, beli.TGL, beli.KODES AS KODE, beli.NAMAS AS NAMA, 'PEMBELIAN' AS URAIAN, 0 AS AWAL, beli.NETT AS MASUK, 0 AS KELUAR, 0 AS SALDO 
    // FROM beli 
    // UNION ALL 
    // SELECT hut.NO_KASIR AS NO_BUKTI, hut.TGL_KASIR AS TGL, hut.KODES AS KODE, hut.NAMAS AS NAMA, CONCAT(hut.KODES, hut.NAMAS) AS URAIAN, 0 AS AWAL, 0 AS MASUK, hut.BAYAR AS KELUAR, 0 AS SALDO 
    // FROM hut

    connection.query("SELECT URUT, NO_BUKTI, TGL, KODE, NAMA, URAIAN, AWAL, MASUK, KELUAR, " +
        " if(@tempKD=KODE, @AKHIR:=@AKHIR+AWAL+MASUK-KELUAR, @AKHIR:=AWAL+MASUK-KELUAR) AS SALDO, (@tempKD:=KODE) as TEMPKODE from ( " +
        " SELECT 1 as URUT, '-' AS NO_BUKTI, '2022-01-01' AS TGL, supd.KODES AS KODE, supd.NAMAS AS NAMA, 'SALDO AWAL' AS URAIAN, supd.AW01 AS AWAL, 0 AS MASUK, 0 AS KELUAR, 0 AS SALDO FROM sup, supd WHERE sup.KODES=supd.KODES and supd.YER=? " +
        " UNION ALL " +
        " SELECT 2 as URUT, beli.NO_BUKTI, beli.TGL, beli.KODES AS KODE, beli.NAMAS AS NAMA, 'PEMBELIAN' AS URAIAN, 0 AS AWAL, beli.NETT AS MASUK, 0 AS KELUAR, 0 AS SALDO " +
        " FROM beli WHERE beli.PER=? " +
        " UNION ALL " +
        " SELECT 3 as URUT, hut.NO_KASIR AS NO_BUKTI, hut.TGL_KASIR AS TGL, hut.KODES AS KODE, hut.NAMAS AS NAMA, CONCAT(hut.KODES, '-', hut.NAMAS) AS URAIAN, 0 AS AWAL, 0 AS MASUK, hut.BAYAR AS KELUAR, 0 AS SALDO FROM hut WHERE hut.PER=? " +
        " ) as KARTU " +
        " JOIN (SELECT @AKHIR:=0 ) AS BB ON 1=1 " +
        " WHERE if(?<>'',if(?<>'',KODE BETWEEN ? and ?,KODE BETWEEN ? and '~~~'),true) " +
        " ORDER BY KODE,URUT,NO_BUKTI", [yer, per, per, kode1, kode2, kode1, kode2, kode1],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN KARTU PIUTANG
exports.lapkartu_piu = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var kode1 = req.body.kode1;
    var kode2 = req.body.kode2;

    connection.query("SELECT URUT, NO_BUKTI, TGL, KODE, NAMA, URAIAN, AWAL, MASUK, KELUAR, " +
        " if(@tempKD=KODE, @AKHIR:=@AKHIR+AWAL+MASUK-KELUAR, @AKHIR:=AWAL+MASUK-KELUAR) AS SALDO, (@tempKD:=KODE) as TEMPKODE from ( " +
        " SELECT 1 as URUT, '-' AS NO_BUKTI, '2022-01-01' AS TGL, custd.KODEC AS KODE, custd.NAMAC AS NAMA, 'SALDO AWAL' AS URAIAN, custd.AW01 AS AWAL, 0 AS MASUK, 0 AS KELUAR, 0 AS SALDO FROM cust, custd WHERE cust.KODEC=custd.KODEC and custd.YER=? " +
        " UNION ALL " +
        " SELECT 2 as URUT, jual.NO_BUKTI, jual.TGL, jual.KODEC AS KODE, jual.NAMAC AS NAMA, 'PENJUALAN' AS URAIAN, 0 AS AWAL, jual.NETT AS MASUK, 0 AS KELUAR, 0 AS SALDO " +
        " FROM jual WHERE jual.PER=? " +
        " UNION ALL " +
        " SELECT 3 as URUT, piu.NO_KASIR AS NO_BUKTI, piu.TGL_KASIR AS TGL, piu.KODEC AS KODE, piu.NAMAC AS NAMA, CONCAT(piu.KODEC, '-', piu.NAMAC) AS URAIAN, 0 AS AWAL, 0 AS MASUK, piu.BAYAR AS KELUAR, 0 AS SALDO FROM piu WHERE piu.PER=? " +
        " ) as KARTU " +
        " JOIN (SELECT @AKHIR:=0 ) AS BB ON 1=1 " +
        " WHERE if(?<>'',if(?<>'',KODE BETWEEN ? and ?,KODE BETWEEN ? and '~~~'),true) " +
        " ORDER BY KODE,URUT,NO_BUKTI", [yer, per, per, kode1, kode2, kode1, kode2, kode1],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
///LAPORAN BUKU BESAR
exports.lapbuku_besar = function (req, res) {
    var per = req.body.per;
    var acno = req.body.acno;
    const string1 = "select `accountd`.`ACNO` AS `ACNO`,`accountd`.`NAMA` AS `NAMA`,' ' AS `KODEZ`,' ' AS `NAMAZ`,' ' AS `NO_BUKTI`,'2001-01-01' AS `TGL`,' ' AS `ACNOD`,' ' AS `NACNO`,' Saldo Awal ' AS `URAIAN`,`accountd`.`AW01` AS `AWAL`,0 AS `DEBET`,0 AS `KREDIT`,0 AS `AKHIR`,' ' AS `KODEX`,' ' AS `NAMAX`,`account`.`GRUP` AS `GRUP`,`account`.`NM_GRUP` AS `NM_GRUP`,`accountd`.`YER` AS `yer` from (`account` join `accountd`) where ((`account`.`ACNO` = `accountd`.`ACNO`) ) union all select `kas`.`BACNO` AS `ACNO`,`kas`.`BNAMA` AS `NAMA`,`kas`.`KODE` AS `KODEZ`,`kas`.`NAMA` AS `NAMAZ`,`kas`.`NO_BUKTI` AS `NO_BUKTI`,`kas`.`TGL` AS `TGL`,`kasd`.`ACNO` AS `ACNOD`,`kasd`.`NACNO` AS `NACNO`,`kasd`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,`kasd`.`DEBET` AS `DEBET`,`kasd`.`KREDIT` AS `KREDIT`,0 AS `AKHIR`,`kas`.`KODE` AS `KODEX`,`kas`.`NAMA` AS `NAMAX`,`kasd`.`GRUP` AS `GRUP`,`kasd`.`NM_GRUP` AS `NM_GRUP`, year(`kas`.`TGL`) AS `yer` from (`kas` join `kasd`) where ((`kas`.`NO_BUKTI` = `kasd`.`NO_BUKTI`)) union all select `kasd`.`ACNO` AS `ACNO`,`kasd`.`NACNO` AS `NAMA`,`kas`.`KODE` AS `KODEZ`,`kas`.`NAMA` AS `NAMAZ`,`kas`.`NO_BUKTI` AS `NO_BUKTI`,`kas`.`TGL` AS `TGL`,`kas`.`BACNO` AS `ACNOD`,`kas`.`BNAMA` AS `NACNO`,`kasd`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,`kasd`.`KREDIT` AS `DEBET`,`kasd`.`DEBET` AS `KREDIT`,0 AS `AKHIR`,`kas`.`KODE` AS `KODEX`,`kas`.`NAMA` AS `NAMAX`,`kasd`.`GRUP` AS `GRUP`,`kasd`.`NM_GRUP` AS `NM_GRUP`,year(`kas`.`TGL`) AS `yer` from (`kas` join `kasd`) where ((`kas`.`NO_BUKTI` = `kasd`.`NO_BUKTI`)) union all select `bank`.`BACNO` AS `ACNO`,`bank`.`BNAMA` AS `NAMA`,`bank`.`KODE` AS `KODEZ`,`bank`.`NAMA` AS `NAMAZ`,`bank`.`NO_BUKTI` AS `NO_BUKTI`,`bank`.`TGL` AS `TGL`,`bankd`.`ACNO` AS `ACNOD`,`bankd`.`NACNO` AS `NACNO`,   `bankd`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,`bankd`.`DEBET` AS `DEBET`,`bankd`.`KREDIT` AS `KREDIT`,0 AS `AKHIR`,`bank`.`KODE` AS `KODEX`,`bank`.`NAMA` AS `NAMAX`,`bankd`.`GRUP` AS `GRUP`,`bankd`.`NM_GRUP` AS `NM_GRUP`,year(`bank`.`TGL`) AS `yer` ";
    const string2 = string1 + "from ";
    const string3 = string2 + "(`bank` join `bankd`) where ((`bank`.`NO_BUKTI` = `bankd`.`NO_BUKTI`)) union all select `bankd`.`ACNO` AS `ACNO`,`bankd`.`NACNO` AS `NAMA`,`bank`.`KODE` AS `KODEZ`,`bank`.`NAMA` AS `NAMAAZ`,`bank`.`NO_BUKTI` AS `NO_BUKTI`,`bank`.`TGL` AS `TGL`,`bank`.`BACNO` AS `ACNOD`,`bank`.`BNAMA` AS `NACNO`,`bankd`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,`bankd`.`KREDIT` AS `DEBET`,`bankd`.`DEBET` AS `KREDIT`,0 AS `AKHIR`,`bank`.`KODE` AS `KODEX`,`bank`.`NAMA` AS `NAMAX`,`bankd`.`GRUP` AS `GRUP`,`bankd`.`NM_GRUP` AS `NM_GRUP`,year(`bank`.`TGL`) AS `yer` from (`bank` join `bankd`) where ((`bank`.`NO_BUKTI` = `bankd`.`NO_BUKTI`) ) union all select `memod`.`ACNO` AS `ACNO`,`memod`.`NACNO` AS `NAMA`,`memo`.`KODE` AS `KODEZ`,`memo`.`NAMA` AS `NAMAZ`,`memo`.`NO_BUKTI` AS `NO_BUKTI`,`memo`.`TGL` AS `TGL`,`memod`.`ACNOB` AS `ACNOD`,`memod`.`NACNOB` AS `NACNO`,`memod`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,`memod`.`DEBET` AS `DEBET`,0 AS `KREDIT`,0 AS `AKHIR`,`memo`.`KODE` AS `KODEX`,`memo`.`NAMA` AS `NAMAX`,`memod`.`GRUPA` AS `GRUP`,`memod`.`NM_GRUPA` AS `NM_GRUP`,year(`memo`.`TGL`) AS `yer` from (`memo` join `memod`) where ((`memo`.`NO_BUKTI` = `memod`.`NO_BUKTI`) and (`memod`.`DEBET` <> 0)) union all select `memod`.`ACNOB` AS `acno`,`memod`.`NACNOB` AS `NAMA`,`memo`.`KODE` AS `KODEZ`,`memo`.`NAMA` AS `NAMAZ`,`memo`.`NO_BUKTI` AS `NO_BUKTI`,`memo`.`TGL` AS `TGL`,`memod`.`ACNO` AS `acnod`,`memod`.`NACNO` AS `nacno`,`memod`.`URAIAN` AS `URAIAN`,0 AS `AWAL`,0 AS `DEBET`,`memod`.`KREDIT` AS `KREDIT`,0 AS `AKHIR`,`memo`.`KODE` AS `KODEX`,`memo`.`NAMA` AS `NAMAX`,`memod`.`GRUPB` AS `GRUP`,`memod`.`NM_GRUPB` AS `NM_GRUP`,year(`memo`.`TGL`) AS `yer` from (`memo` join `memod`) where ((`memo`.`NO_BUKTI` = `memod`.`NO_BUKTI`) and (`memod`.`KREDIT` <> 0))";

    // select hero.*,account.nama as bnama, if(@acno=hero.bacno,@saldo :=@saldo+hero.awal+hero.debet-hero.kredit,@saldo :=hero.awal+hero.debet-hero.kredit) as saldo,@acno:=hero.bacno from (select accountd.ACNO AS BACNO, 'SALDO AWAL' AS NO_BUKTI,'2001-01-01' AS TGL, convert (:tglaw,date) as tglx, '' AS ACNO,'' AS NACNO, '' AS URAIAN, accountd.AW01 AS AWAL, 0 AS DEBET, 0 AS KREDIT,0 AS BARIS FROM accountd WHERE accountd.YER= ? AND accountd.AW01 <>0 and accountd.acno= ? UNION ALL  select KAS.BACNO,  KAS.NO_BUKTI, KAS.TGL, convert (kas.tgl,date) as tglx, KASD.ACNO, KASD.NACNO, KASD.URAIAN,0 AS AWAL, KASD.DEBET, KASD.KREDIT,IF(kas.TYPE='BKM',1,3) AS BARIS FROM KAS, KASD WHERE KAS.NO_BUKTI = KASD.NO_BUKTI and kas.per = ? and kas.bacno = ? UNION ALL select KASD.ACNO as bacno,KAS.NO_BUKTI, KAS.TGL, convert (kas.tgl,date) as tglx, KAS.BACNO AS ACNO, KAS.BNAMA AS NACNO, KASD.URAIAN,0 AS AWAL, KASD.KREDIT AS DEBET, KASD.DEBET AS KREDIT, IF(kas.TYPE='BKM',3,1) AS BARIS FROM KAS,KASD WHERE KAS.NO_BUKTI = KASD.NO_BUKTI and kas.per = ? and kasd.acno = ? ALL select BANK.BACNO,BANK.NO_BUKTI, BANK.TGL, convert (bank.tgl,date) as tglx, BANKD.ACNO, BANKD.NACNO, BANKD.URAIAN,0 AS AWAL, BANKD.DEBET, BANKD.KREDIT, IF(BANK.TYPE='BBM',2,4) AS BARIS FROM BANK, BANKD WHERE BANK.NO_BUKTI = BANKD.NO_BUKTI and bank.per=?  and bank.bacno=?  UNION ALL select BANKD.ACNO AS BACNO, BANK.NO_BUKTI, BANK.TGL, convert (bank.tgl,date) as tglx, BANK.BACNO AS ACNO, BANK.BNAMA AS NACNO, BANKD.URAIAN,0 AS AWAL, BANKD.KREDIT AS DEBET, BANKD.DEBET AS KREDIT, IF(BANK.TYPE='BBM',4,2) AS BARIS  FROM BANK, BANKD WHERE BANK.NO_BUKTI = BANKD.NO_BUKTI  and  bank.per = ?  and bankd.acno=?  UNION ALL select MEMOD.ACNO AS BACNO,  MEMO.NO_BUKTI, MEMO.TGL, convert (memo.tgl,date) as tglx, MEMOD.ACNOb AS ACNO, MEMOD.NACNOb AS NACNO, MEMOD.URAIAN,0 AS AWAL, MEMOD.DEBET, 0 as KREDIT ,5 as baris FROM MEMO, MEMOD WHERE MEMO.NO_BUKTI = MEMOD.NO_BUKTI and  memo.per = ? and memod.acno=?  UNION ALL select MEMOD.ACNOB AS BACNO,  MEMO.NO_BUKTI, MEMO.TGL, convert (memo.tgl,date) as tglx, MEMOD.ACNO AS ACNO, MEMOD.NACNO AS NACNO, MEMOD.URAIAN,0 AS AWAL, 0 AS DEBET, MEMOD.KREDIT  ,6 as baris FROM MEMO, MEMOD WHERE MEMO.NO_BUKTI = MEMOD.NO_BUKTI and  memo.per = ? and memod.acnob=? ) AS HERO left join account on hero.bacno=account.ACNO join ( select @saldo:=0,@ACNO:='' ) sx on 1=1 order by hero.BACNO,hero.tglx,hero.baris,hero.no_bukti

    connection.query(string3, [],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///LAPORAN NERACA
exports.lapnera = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var JUM = 'nera.JUM' + per.substring(0, 2);

    connection.query("SELECT NAMA AS NAMA, ?? AS JUM  FROM nera WHERE YER=? ORDER BY GOL", [JUM, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///LAPORAN RUGI LABA
exports.laprl = function (req, res) {
    var per = req.body.per;
    var yer = per.substring(3);
    var JUM = 'rl.JUM' + per.substring(0, 2);
    var AK = 'rl.AK' + per.substring(0, 2);

    connection.query("SELECT NAMA AS NAMA, GOL AS GOL, ?? AS JUM, ?? AS AK FROM rl WHERE YER=? ORDER BY GOL", [JUM, AK, yer],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///PROCEDURE PENJUALAN
exports.jualins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call jualins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.jualdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call jualdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.tpiuins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call tpiuins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.tpiudel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call tpiudel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.piuins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call piuins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.piudel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call piudel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///PROCEDURE PEMBELIAN
exports.beliins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call beliins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.belidel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call belidel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.thutins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call thutins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.thutdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call thutdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.hutins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call hutins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.hutdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call hutdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///PROCEDURE ACCOUNT
exports.kasins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call kasins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.kasdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call kasdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.bankins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call bankins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.bankdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call bankdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.memoins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call memoins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.memodel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call memodel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};

///PRODECURE LAINNYA
exports.stockains = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call stockains(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.stockadel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call stockadel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.stockbins = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call stockbins(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};
exports.stockbdel = function (req, res) {
    var NO_BUKTI = req.body.NO_BUKTI;

    connection.query("Call stockbdel(?)", [NO_BUKTI],
        function (error, rows, fields) {
            if (error) {
                connection.log(error);
            } else {

                response.ok(rows, res);

            }
        });
};