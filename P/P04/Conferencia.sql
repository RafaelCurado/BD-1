CREATE SCHEMA Conferencia;
GO
CREATE TABLE Instituicao(
    Nome VARCHAR(50) NOT NULL,
    Morada VARCHAR(8) NOT NULL CHECK (Morada LIKE '^[0-9]{4}-[0-9]{3}'),
    PRIMARY KEY(Morada),
);
CREATE TABLE Pessoa(
    Email VARCHAR(50) NOT NULL CHECK (Email LIKE '[a-zA-Z_-0-9]+@[a-Z]+.[a-z]+'),
    Nome VARCHAR(50) NOT NULL,
    Morada VARCHAR(8),
    PRIMARY KEY(Email),
    FOREIGN KEY(Morada) REFERENCES Instituicao(Morada),
);
CREATE TABLE Participante (
    Morada VARCHAR(50),
    Data_ins DATE NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY(Email),
    FOREIGN KEY (Email) REFERENCES Pessoa(Email),
);
CREATE TABLE Estudante (
    Comprovativo VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY(Email),
    FOREIGN KEY (Email) REFERENCES Participante(Email),
);
CREATE TABLE NEstudante (
    Tranferencia VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY(Email),
    FOREIGN KEY (Email) REFERENCES Participante(Email),
);
CREATE TABLE Autor(
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY(Email),
    FOREIGN KEY(Email) REFERENCES Pessoa(Email),
);
CREATE TABLE Artigo(
    Titulo VARCHAR(50) NOT NULL UNIQUE,
    Num_reg INT NOT NULL,
    PRIMARY KEY(Num_reg),
);
CREATE TABLE Escreve(
    Email VARCHAR(50) NOT NULL,
    Num_reg INT NOT NULL,
    PRIMARY KEY(Email, Num_reg),
    FOREIGN KEY(Email) REFERENCES Pessoa(Email),
    FOREIGN KEY(Num_reg) REFERENCES Artigo(Num_reg),
);