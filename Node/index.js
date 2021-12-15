// CONNECTION TO DATABASE

const path = require('path');
const multer = require('multer');

const mysql = require('mysql');
const express = require('express');
var app = express();
const bodyparser = require('body-parser');
app.use(bodyparser.json());

var mysqlConnection = mysql.createConnection({
    host: 'markitsql',
    user: 'root',
    password: 'root',
    database: 'markitdb',
    multipleStatements: true
});

mysqlConnection.connect((err) => {
    if (!err)
        console.log('DB connection succeded.');
    else
        console.log('DB connection failed \n Error : ' + JSON.stringify(err, undefined, 2));
});
exports.mysqlConnection = mysqlConnection;
app.listen(3000, () => console.log('Express server is runnig at port no : 3000'));


//Multipart Request



app.use('/images', express.static(path.join(__dirname, '/images')));


const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'images');
    },
    filename: (req, file, cb) => {
        console.log(file);
        //if(req.body.image=="img.jpg")
        cb(null, req.body.image + path.extname(file.originalname));
        //else
        //cb(null, file.originalname.slice(0, -4) + path.extname(file.originalname));

    }
});
const fileFilter = (req, file, cb) => {
    if (file.mimetype == 'image/jpeg' || file.mimetype == 'image/png' || file.mimetype === 'image/jpg') {
        cb(null, true);
    } else {
        cb(null, false);
    }
}
const upload = multer({ storage: storage, fileFilter: fileFilter });
//Multipart Request


// WEB SERVICES
//Imports
const product = require('./product');
const category = require('./category');
const user = require('./user');
const company = require('./company');
const commande = require('./commande');
const password = require('./password');

//Runs
password.run(app, mysqlConnection);

product.run(app, mysqlConnection, upload);
category.run(app, mysqlConnection);
user.run(app, mysqlConnection, upload);
company.run(app, mysqlConnection);
commande.run(app, mysqlConnection);