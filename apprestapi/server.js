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

app.listen(3000, () => {
    console.log('Server stated on port');
});

