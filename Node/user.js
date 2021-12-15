const bcrypt = require('bcrypt')
const nodemailer = require("nodemailer");


async function run(app, mysqlConnection, upload) {


    //Upload route
    app.post('/upload', upload.single('image'), (req, res, next) => {

        mysqlConnection.query("INSERT INTO USER (firstname,image) Values (?,?);", [req.body.firstname, req.body.image]);


        try {
            return res.status(201).json({
                message: 'File uploded successfully'
            });
        } catch (error) {
            console.error(error);
        }
    });
    //Upload route




    //Get all employees
    app.get('/user', (req, res) => {
        mysqlConnection.query('SELECT * FROM user ', (err, rows, fields) => {
            if (!err)
                res.send(rows);
            else
                console.log(err);
        })
    });

    //Get an employees
    app.get('/user/:id', (req, res) => {
        mysqlConnection.query('SELECT * FROM user WHERE id = ?', [req.params.id], async(err, rows, fields) => {
            /*const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(req.body.password, salt)
        const isSame = await bcrypt.compare(rows[0].password, hash)
*/
            //res.send(req.body);
            if (!err)
                res.send(rows);
            else
                console.log(err);
        })
    });

    //Delete an employees
    app.delete('/user/:id', (req, res) => {
        mysqlConnection.query('DELETE FROM user WHERE id = ?', [req.params.id], (err, rows, fields) => {
            if (!err)
                res.send("deleted successfully");
            else
                console.log(err);
        })
    });

    //Insert an employees
    app.post('/user', upload.single('image'), async(req, res) => {
        var sql = "INSERT INTO `user` (id," + JSON.parse(JSON.stringify(Object.keys(req.body))).toString() + ") VALUES (NULL,?);";

        const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(req.body.password, salt);
        req.body.password = hash;

        mysqlConnection.query(sql, [Object.values(req.body)])
        mysqlConnection.query('SELECT * FROM user ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {

            if (!err) {
                res.send("new user id is = " + rows[0].id.toString());

                //sendMail("http://192.168.43.118:3000/verify/"+rows[0].id,rows[0].mail.toString());

            } else
                console.log(err);
        })
    });


    //Update an employees
    app.put('/user/:id', upload.single('image'), async(req, res) => {
        let us = req.body;
        if (req.body && req.body.password) {
            const salt = await bcrypt.genSalt(10)
            const hash = await bcrypt.hash(req.body.password, salt);
            req.body.password = hash;
        }

        mysqlConnection.query("Update user SET ? WHERE id = ?", [us, req.params.id], (err, rows, fields) => {
            mysqlConnection.query('SELECT * FROM user WHERE id = ?', [req.params.id], (err1, usrows, fields) => {
                if (!err)
                    res.send(usrows);

                else
                    console.log(err);
            })
        })
    });


    /*------------------EXTRA FUNCTIONS----------------*/
    //Activate User

    app.get('/verify/:id', async(req, res) => {
        let us = req.body;
        //mysqlConnection.query('SELECT * FROM token WHERE token = ?', [req.params.id], (err1, usrows, fields) => {


        mysqlConnection.query("Update user SET state = 1 WHERE id = ?", [req.params.id], (err, rows, fields) => {
            if (!err) {
                //res.send(usrows);
                res.send("{\"State\":\"1\"}")

            } else
                console.log(err);
        })

    });

    //forgot pass
    app.put('/userforgotpassword', async(req, res) => {
        let us = req.body;

        req.body.password = makeid(5)
        pass = req.body.password
        const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(req.body.password, salt);
        req.body.password = hash;
        mysqlConnection.query("Update user SET password = ? WHERE mail = ?", [req.body.password, req.body.mail], (err, rows, fields) => {

            mysqlConnection.query('SELECT * FROM user WHERE mail = ?', [req.body.mail], (err1, usrows, fields) => {
                if (!err) {
                    res.send(usrows[0])
                    changePass(req.body.mail, pass, usrows[0].username)
                } else
                    console.log(err);
            })
        })
    });


    //State On/OFF
    app.get('/changestate/:id', async(req, res) => {
        let us = req.body;
        //mysqlConnection.query('SELECT * FROM token WHERE token = ?', [req.params.id], (err1, usrows, fields) => {

        mysqlConnection.query('SELECT * FROM user WHERE id = ?', [req.params.id], (err1, usrows, fields) => {
            if (usrows[0].state)
                mysqlConnection.query("Update user SET state = 0 WHERE id = ?", [req.params.id], (err, rows, fields) => {
                    if (!err) {
                        usrows[0].state = 0;
                        //res.send(usrows);
                        res.send("{\"State\":\"0\"}")

                    } else
                        console.log(err);
                })
            else
                mysqlConnection.query("Update user SET state = 1 WHERE id = ?", [req.params.id], (err, rows, fields) => {
                    if (!err) {
                        usrows[0].state = 1;
                        //res.send(usrows);
                        res.send("{\"State\":\"1\"}")

                    } else
                        console.log(err);
                })
        })
    });


    function sendMail(confirm, mail) {
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'Markittn2020@gmail.com',
                pass: 'markitmarkit2020'
            }
        });

        var mailOptions = {
            from: 'MarkitTn2020@gmail.com',
            to: mail,
            subject: 'Proceed Email Confirmation!',
            text: 'Thank you for subscribing to Markit you did very well by choosing us dear client, we really appreciate it.\n Will you please verify your email now by clicking on this link: ' + confirm
        };

        transporter.sendMail(mailOptions, function(error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });
    }

    function changePass(mail, pass, username) {
        var transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'Markittn2020@gmail.com',
                pass: 'markitmarkit2020'
            }
        });

        var mailOptions = {
            from: 'MarkitTn2020@gmail.com',
            to: mail,
            subject: 'Password Reset!',
            text: 'Username: ' + username + "\nPassword: " + pass
        };

        transporter.sendMail(mailOptions, function(error, info) {
            if (error) {
                console.log(error);
            } else {
                console.log('Email sent: ' + info.response);
            }
        });
    }

    function makeid(length) {
        var result = '';
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < length; i++) {
            result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
    }

}
module.exports = { run }