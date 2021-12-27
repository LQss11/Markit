function run(app,mysqlConnection) { 

//Get all employees
app.get('/category', (req, res) => {
    mysqlConnection.query('SELECT * FROM category ', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get an employees
app.get('/category/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM category WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
            //res.send(rows[0])
            //res.send(rows[0]);
        else
            console.log(err);
    })
});

//Delete an employees
app.delete('/category/:id', (req, res )=> {
    mysqlConnection.query('DELETE FROM category WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send("deleted successfully");
        else
            console.log(err);
    })
});

//Insert an employees
app.post('/category', (req, res) => {
    let cat = req.body;
    //var sql ="INSERT INTO `category` (`id`, `name`) VALUES (?,?);";
    //mysqlConnection.query(sql,[cat.id, cat.name])
    var sql ="INSERT INTO `category` (id,"+JSON.parse(JSON.stringify(Object.keys(req.body))).toString()+") VALUES (NULL,?);";
    mysqlConnection.query(sql,[Object.values(req.body)])
    mysqlConnection.query('SELECT * FROM category ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {


        if (!err)
            res.send("new category id is = "+rows[0].id.toString());
        else
            console.log(err);
    })
});

//Update an employees
app.put('/category/:id', (req, res) => {
    let cat = req.body;
    
        mysqlConnection.query("Update category SET ? WHERE id = ?", [cat,req.params.id], (err, rows, fields) => {
            mysqlConnection.query('SELECT * FROM category WHERE id = ?', [req.params.id], (err1, catrows, fields) => {
            if (!err)
                res.send(catrows);
            else
                console.log(err);
        })
    })
});



/*---------------------MORE METHODS-----------------------------------*/
//Get all cats names
app.get('/catname', (req, res) => {
    mysqlConnection.query('SELECT name FROM category ', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});



} 
module.exports = {run}
