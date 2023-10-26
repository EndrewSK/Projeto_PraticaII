create schema locadora

CREATE TABLE locadora.Clientes (
    CPF CHAR(11) PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL,
	Sobrenome VARCHAR (50) NOT NULL,
    Email VARCHAR(80) NOT NULL,
    Endereco VARCHAR(100) NOT NULL,
    Senha VARCHAR(15) NOT NULL
);

CREATE TABLE locadora.Veiculos (
    VeiculoID INT PRIMARY KEY,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Ano INT,
    Placa VARCHAR(20) UNIQUE,
    Disponivel BIT
);

CREATE TABLE locadora.Locacoes (
    LocacaoID INT PRIMARY KEY,
    CPF CHAR(11) NOT NULL,
    VeiculoID INT,
    DataInicio DATETIME,
    DataFim DATETIME,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (CPF) REFERENCES  locadora.Clientes(CPF),
    FOREIGN KEY (VeiculoID) REFERENCES locadora.Veiculos(VeiculoID)
);

CREATE TABLE locadora.Funcionarios (
    FuncionarioID INT PRIMARY KEY,
    Nome VARCHAR(20),
	Sobrenome VARCHAR(50),
    Cargo VARCHAR(50),
    DataContratacao DATE,
    Salario DECIMAL(10, 2)
);

CREATE TABLE locadora.LogLocacoes (
    LogID INT PRIMARY KEY,
    LocacaoID INT,
    Operacao VARCHAR(10),
    DataAlteracao DATETIME
);



CREATE TRIGGER Trg_AfterLocacoes
ON locadora.Locacoes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO locadora.LogLocacoes (LocacaoID, Operacao, DataAlteracao)
    SELECT
        i.LocacaoID, 'INSERT', GETDATE()
    FROM
        inserted i
    UNION ALL
    SELECT
        u.LocacaoID, 'UPDATE', GETDATE()
    FROM
        updated u
    UNION ALL
    SELECT
        d.LocacaoID, 'DELETE', GETDATE()
    FROM
        deleted d;
END;




CREATE VIEW locadora.DetalhesLocacoes AS
 SELECT
    L.LocacaoID,
    C.Nome AS NomeCliente,
    V.Marca + ' ' + V.Modelo AS Veiculo,
    L.DataInicio,
    L.DataFim
 FROM locadora.Locacoes L
 INNER JOIN locadora.Clientes C ON L.CPF = C.CPF
 INNER JOIN locadora.Veiculos V ON L.VeiculoID = V.VeiculoID;




INSERT INTO locadora.Clientes (CPF, Nome, Sobrenome, Email, Endereco, Senha)
VALUES 
('12345678901', 'João', 'Silva', 'joao@example.com', 'Rua 123, Cidade A', 'senha123'),
('35343420200', 'Endrew', 'Oliveira', 'endrew23541@g.unicamp.br', 'Rua João Gui, Cidade Campinas', 'senhasegura23');

INSERT INTO locadora.Veiculos (VeiculoID, Marca, Modelo, Ano, Placa, Disponivel)
VALUES 
(1, 'Toyota', 'Corolla', 2022, 'ABC123', 1),
(2, 'Chevrolet', 'Astra', 2010, 'ASD321', 1);

INSERT INTO locadora.Locacoes (LocacaoID, CPF, VeiculoID, DataInicio, DataFim, ValorTotal)
VALUES 
(1, '12345678901', 1, CONVERT(DATETIME, '2023-10-25 10:00:00', 120), CONVERT(DATETIME, '2023-10-27 18:00:00', 120), 150.00),
(2, '35343420200', 2, CONVERT(DATETIME, '2023-10-20 11:30:00', 120), CONVERT(DATETIME, '2023-10-26 12:00:00', 120), 450.00);


INSERT INTO locadora.Funcionarios (FuncionarioID, Nome, Sobrenome, Cargo, DataContratacao, Salario)
VALUES 
(1, 'Maria', 'Oliveira', 'Atendente', '2023-01-15', 1500.00),
(2, 'João', 'Silva', 'Manobrista', '2023-06-21', 2000.00);

INSERT INTO locadora.LogLocacoes (LogID, LocacaoID, Operacao, DataAlteracao)
VALUES 
(1, 1, 'INSERT', GETDATE());





--SELECT * FROM DetalhesLocacoes;

select * from locadora.Clientes

select * from locadora.Veiculos

select * from locadora.Locacoes 

select * from locadora.Funcionarios

select * from locadora.LogLocacoes

--drop table locadora.Funcionarios

DROP TRIGGER Trg_AfterLocacoes;
