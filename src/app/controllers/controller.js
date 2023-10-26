const selectClient = require("../db/classSelectClient.js");

class control_clients {
    add() {
        return async function(req, res) {
            const { prenome, sobrenome, dataNasc, email, cpf } = req.body;
            const clienter = await selectClient.init();
            try {
                await clienter.add(prenome, sobrenome, dataNasc, email, cpf);
            } catch (error) {
                console.error("Erro ao adicionar cliente:", error);
                res.status(500).send("Ocorreu um erro ao adicionar: " + error.message);
            }
        };
    };
};

module.exports = control_clients;