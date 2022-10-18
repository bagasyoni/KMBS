const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const cors = require('cors');

//parse applikasi json
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());


//panggil routes
var routes = require('./routes');
routes(app);

 var server = app.listen(3000,function(){
    console.log('Server started on port ' + server.address().port);
});

