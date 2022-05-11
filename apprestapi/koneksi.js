var mysql = require('mysql');
//buat koneksi database
const conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'admin',
    database: 'db_kmbs',
    port: '3309',
    dateStrings:true,
    decimalNumbers:true,
    multipleStatements:true
});

conn.connect((err) => {
    if (err) throw err;
    console.log('Mysql is Connected!');
});

module.exports = conn;
