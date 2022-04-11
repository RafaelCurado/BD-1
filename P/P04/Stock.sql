CREATE SCHEMA Stock;
GO
CREATE TABLE Empresa(
    NIF INT NOT NULL CHECK (
        NIF BETWEEN 100000000 AND 999999999
    ),
    Nome VARCHAR(50) NOT NULL,
    Localizacao VARCHAR(50),
    PRIMARY KEY(NIF),
);
CREATE TABLE Produto(
    NIF INT NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    Quantidade INT CHECK (Quantidade >= 0),
    Preco MONEY CHECK (Preco >= 0),
    Nome VARCHAR(50) NOT NULL,
    Localizacao VARCHAR(50),
    PRIMARY KEY(Codigo),
    FOREIGN KEY(NIF) REFERENCES Empresa(NIF),
);
CREATE TABLE IVA(
    IVA INT NOT NULL CHECK (IVA >= 0),
    Codigo VARCHAR(50) NOT NULL,
    PRIMARY KEY(IVA, Codigo),
    FOREIGN KEY(Codigo) REFERENCES Produto(Codigo),
);
CREATE TABLE Fornecedor(
    Nome VARCHAR(50) NOT NULL,
    Address VARCHAR(8) CHECK (Address LIKE '^[0-9]{4}-[0-9]{3}'),
    FAX INT NOT NULL CHECK (
        FAX BETWEEN 200000000 AND 999999999
    ),
    NIF INT NOT NULL CHECK (
        NIF BETWEEN 100000000 AND 999999999
    ),
    Condicoes VARCHAR(50) NOT NULL,
    PRIMARY KEY(NIF),
);
CREATE TABLE Encomenda (
    NIF INT NOT NULL,
    Num INT NOT NULL,
    Quantidade INT CHECK (Quantidade >= 0),
    PRIMARY KEY(Num),
    FOREIGN KEY(NIF) REFERENCES Fornecedor(NIF),
);
CREATE TABLE Contem (
    Num_Enc INT NOT NULL,
    Codigo_prod VARCHAR(50) NOT NULL,
    Quantidade INT CHECK (Quantidade >= 0),
    PRIMARY KEY(Num_Enc, Codigo_prod),
    FOREIGN KEY(Num_Enc) REFERENCES Encomenda(Num),
    FOREIGN KEY(Codigo_prod) REFERENCES Produto(Codigo),
);
CREATE TABLE PagamentoCond(
    NIF INT NOT NULL,
    Condicoes VARCHAR(50) NOT NULL,
    PRIMARY KEY(NIF, Condicoes),
    FOREIGN KEY(NIF) REFERENCES Fornecedor(NIF),
);
CREATE TABLE ForncedorTipo(
    NIF INT NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    Designcao VARCHAR(50),
    PRIMARY KEY(NIF, Codigo),
    FOREIGN KEY(NIF) REFERENCES Fornecedor(NIF),
);