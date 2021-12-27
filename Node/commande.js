function run(app,mysqlConnection) { 

//Get all employees
app.get('/commande', (req, res) => {
    mysqlConnection.query('SELECT * FROM commande ', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get an employees
app.get('/commande/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM commande WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Delete an employees
app.delete('/commande:id', (req, res )=> {
    mysqlConnection.query('DELETE FROM commande WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send("deleted successfully");
        else
            console.log(err);
    })
});

//Insert an employees
app.post('/commande', (req, res) => {
    var sql ="INSERT INTO `commande` (id,"+JSON.parse(JSON.stringify(Object.keys(req.body))).toString()+") VALUES (NULL,?);";
    mysqlConnection.query(sql,[Object.values(req.body)])
    mysqlConnection.query('SELECT * FROM commande ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {

        if (!err)
            res.send("new commande id is = "+rows[0].id.toString());
        else
            console.log(err);
    })
});

//State On/OFF
app.get('/updatecmd/:id', async (req, res) => {
    let us= req.body;
                //mysqlConnection.query('SELECT * FROM token WHERE token = ?', [req.params.id], (err1, usrows, fields) => {

        mysqlConnection.query('SELECT * FROM commande WHERE id = ?', [req.params.id], (err1, usrows, fields) => {
        if(usrows[0].state)
            mysqlConnection.query("Update commande SET state = 0 WHERE id = ?", [req.params.id], (err, rows, fields) => {
                if (!err)
                {
                    usrows[0].state=0;
                    //res.send(usrows);
                    res.send("{\"State\":\"0\"}")

                }
                else
                    console.log(err);
            })
        else
            mysqlConnection.query("Update commande SET state = 1 WHERE id = ?", [req.params.id], (err, rows, fields) => {
                if (!err)
                {
                    usrows[0].state=1;
                    //res.send(usrows);
                    res.send("{\"State\":\"1\"}")

                }
                else
                    console.log(err);
            })
        })
});


} 
module.exports = {run}
