const mssql = require('mssql');
const getPool = require("../../config/database");

class classSelectClient {

    constructor(pool) {
        this._db = pool;
    }

    static async init() {
        const pool = await getPool();
        return new classSelectClient(pool);
    }

    add(prenome, sobrenome, dataNasc, email, cpf) {
        return new Promise((resolve, reject) => {
            const sql = `Insert into node.clients (prenome, sobrenome, dataNasc, email, cpf)
                         values (@prenome, @sobrenome, Convert(date, @dataNasc, 103), @email, @cpf)`;

            const request = new mssql.Request(this._db);
            request.input('prenome', mssql.NVarChar, prenome);
            request.input('sobrenome', mssql.NVarChar, sobrenome);
            request.input('dataNasc', mssql.Date, dataNasc);
            request.input('email', mssql.NVarChar, email);
            request.input('cpf', mssql.NVarChar, cpf);

            request.query(sql, (err, result) => {
                if (err) {
                    console.log("Erro durante a execução da query:", err);
                    return reject(err);
                }

                resolve(result);
            });
        });
    }
}

module.exports = classSelectClient;