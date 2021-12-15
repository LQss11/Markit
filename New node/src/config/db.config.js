module.exports = {
    HOST: "markitsql",
    USER: "root",
    PASSWORD: "root",
    DB: "markitdb",
    dialect: "mysql",
    multipleStatements: true,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
};