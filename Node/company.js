function run(app,mysqlConnection) { 

//Get all employees
app.get('/company', (req, res) => {
    mysqlConnection.query('SELECT * FROM company ', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get an employees
app.get('/company/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM company WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

app.get('/companylast', (req, res) => {
    mysqlConnection.query('SELECT * FROM company ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Delete an employees
app.delete('/company/:id', (req, res )=> {
    mysqlConnection.query('DELETE FROM company WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send("deleted successfully");
        else
            console.log(err);
    })
});

//Insert an employees
app.post('/company', (req, res) => {
    var sql ="INSERT INTO `company` (id,"+JSON.parse(JSON.stringify(Object.keys(req.body))).toString()+") VALUES (NULL,?);";
    mysqlConnection.query(sql,[Object.values(req.body)])
    mysqlConnection.query('SELECT * FROM company ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {

        if (!err)
            res.send("new company id is = "+rows[0].id.toString());
        else
            console.log(err);
    })
});

//Update an employees
app.put('/company/:id', (req, res) => {
    let comp= req.body;
    
        mysqlConnection.query("Update company SET ? WHERE id = ?", [comp,req.params.id], (err, rows, fields) => {
            mysqlConnection.query('SELECT * FROM company WHERE id = ?', [req.params.id], (err1, comprows, fields) => {
            if (!err)
                res.send(comprows);
            else
                console.log(err);
        })
    })
});

} 
module.exports = {run}
