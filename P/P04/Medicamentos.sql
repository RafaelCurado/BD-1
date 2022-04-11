CREATE SCHEMA Medicamentos;
GO
CREATE TABLE Farmacia(
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(8) NOT NULL CHECK (Endereço LIKE '^[0-9]{4}-[0-9]{3}'),
    Telefone VARCHAR(9) CHECK (Telefone LIKE '[0-9]{9}'),
    NIF VARCHAR(9) NOT NULL CHECK (NIF LIKE '[0-9]{9}'),
    PRIMARY KEY(NIF),
);
CREATE TABLE Paciente(
    NSNS VARCHAR(9) NOT NULL CHECK (NSNS LIKE '[0-9]{9}'),
    Endereço VARCHAR(8) NOT NULL CHECK (Endereço LIKE '^[0-9]{4}-[0-9]{3}'),
    Nome VARCHAR(50) NOT NULL,
    Data_nasc DATE NOT NULL,
    PRIMARY KEY(NSNS),
);
CREATE TABLE Medico(
    NID INT,
    Nome VARCHAR(50) NOT NULL,
    Especialdade VARCHAR(50) NOT NULL,
    PRIMARY KEY(NID),
);
CREATE TABLE Farmaceutica(
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(8) NOT NULL CHECK (Endereço LIKE '^[0-9]{4}-[0-9]{3}'),
    Telefone VARCHAR(9) CHECK (Telefone LIKE '[0-9]{9}'),
    Nreg INT NOT NULL,
    PRIMARY KEY(Nreg),
);
CREATE TABLE Farmaco(
    Nome_com VARCHAR(50) NOT NULL,
    Formula VARCHAR(50) NOT NULL,
    Nome_tec VARCHAR(50) NOT NULL,
    Nreg INT NOT NULL,
    PRIMARY KEY(Nreg, Nome_tec),
    FOREIGN KEY(Nreg) REFERENCES Farmaceutica(Nreg),
);
CREATE TABLE Vende(
    Nome_tec VARCHAR(50) NOT NULL,
    Nreg INT NOT NULL,
    NIF VARCHAR(9) NOT NULL CHECK (NIF LIKE '[0-9]{9}'),
    PRIMARY KEY(Nome_tec, Nreg, NIF),
    FOREIGN Key(Nreg, Nome_tec) REFERENCES Farmaco(Nreg, Nome_tec),
    FOREIGN Key(NIF) REFERENCES Farmacia(NIF),
);
CREATE TABLE Prescricao(
    Nuni INT NOT NULL,
    Data_ DATE NOT NULL,
    Data_proc DATE NOT NULL,
    NID INT,
    NSNS VARCHAR(9) NOT NULL CHECK (NSNS LIKE '[0-9]{9}'),
    NIF VARCHAR(9) NOT NULL CHECK (NIF LIKE '[0-9]{9}'),
    PRIMARY KEY(Nuni),
    FOREIGN KEY(NID) REFERENCES Medico(NID),
    FOREIGN KEY(NSNS) REFERENCES Paciente(NSNS),
    FOREIGN KEY(NIF) REFERENCES Farmacia(NIF),
);
CREATE TABLE Inclui(
    Nome_tec VARCHAR(50),
    Nreg INT NOT NULL,
    Nuni INT NOT NULL,
    PRIMARY KEY(Nome_tec, Nreg, Nuni),
    FOREIGN Key(Nreg, Nome_tec) REFERENCES Farmaco(Nreg, Nome_tec),
    FOREIGN Key(Nuni) REFERENCES Prescricao(Nuni),
);