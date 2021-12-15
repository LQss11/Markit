
const bcrypt = require('bcrypt')

function run(app,mysqlConnection) { 
//Get an employees


app.get('/login/:username/:password', (req, res) => {
    mysqlConnection.query('SELECT * FROM user WHERE username = ?', [req.params.username], async (err, rows, fields) => {
        if (!err)
            if (Object.keys(rows).length !== 0 && await bcrypt.compare(req.params.password, rows[0].password))
            {
                res.send(rows[0])
            }
            else
                res.send("{\"object\":\"empty\"}")
                   else
            console.log(err);
    })
});
app.get('/login/:username/:password', (req, res) => {
    mysqlConnection.query('SELECT * FROM user WHERE username = ?', [req.params.username], async (err, rows, fields) => {
        if (!err)
            if (Object.keys(rows).length !== 0 && await bcrypt.compare(req.params.password, rows[0].password))
            {
                res.send(rows[0])
            }
            else
                res.send("{\"object\":\"empty\"}")
                   else
            console.log(err);
    })
});
} 
module.exports = {run}
