function run(app,mysqlConnection,upload) { 

//Get all employees
app.get('/product', (req, res) => {
    mysqlConnection.query('SELECT * FROM product ', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get an employees
app.get('/product/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM product WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Delete an employees
app.delete('/product/:id', (req, res )=> {
    mysqlConnection.query('DELETE FROM product WHERE id = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send("deleted successfully");
        else
            console.log(err);
    })
});

//Insert an employees
app.post('/product',upload.single('image'), (req, res) => {
    let prod = req.body;
    //var sql ="INSERT INTO `product` (`id`, `name`, `price`, `total`, `dateadded`, `barcode`, `description`, `category`) VALUES (?,?,?,?,?,?,?,?);";
    //mysqlConnection.query(sql,[prod.id, prod.name, prod.price, prod.total,prod.dateadded, prod.barcode, prod.description, prod.category])
    var sql ="INSERT INTO `product` (id,"+JSON.parse(JSON.stringify(Object.keys(req.body))).toString()+") VALUES (NULL,?);";
    mysqlConnection.query(sql,[Object.values(req.body)])
    mysqlConnection.query('SELECT * FROM product ORDER BY ID DESC LIMIT 1', (err, rows, fields) => {


        if (!err)
            res.send("new prod id is = "+rows[0].id.toString());
        else 
            console.log(err);
    })
});

//Update an employees
app.put('/product/:id',upload.single('image'), (req, res) => {
    let prod = req.body;
    
        mysqlConnection.query("Update product SET ? WHERE id = ?", [prod,req.params.id], (err, rows, fields) => {
            mysqlConnection.query('SELECT * FROM product WHERE id = ?', [req.params.id], (err1, prodrows, fields) => {
            if (!err)
                res.send(prodrows);
            else
                console.log(err);
        })
    })
});


app.get('/productcode/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM product WHERE barcode = ?', [req.params.id], (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});



} 
module.exports = {run}
