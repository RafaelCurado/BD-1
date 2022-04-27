CREATE SCHEMA FestivalPlanner;
GO CREATE TABLE Banda (
        id INT NOT NULL,
        nome VARCHAR(50) NOT NULL,
        telefone VARCHAR(9) CHECK (telefone LIKE '[0-9]{9}'),
        email VARCHAR(50) CHECK (email LIKE '[a-zA-Z_-0-9]+@[a-Z]+.[a-z]+'),
        nElementos INT CHECK (nElementos >= 1) PRIMARY KEY(id),
    );
CREATE TABLE Pessoa (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    email VARCHAR(50) CHECK (email LIKE '[a-zA-Z_-0-9]+@[a-Z]+.[a-z]+'),
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(9) CHECK (telefone LIKE '[0-9]{9}'),
    sexo VARCHAR(1) CHECK (
        sexo = 'M'
        OR sexo = 'F'
    ),
    PRIMARY KEY(cc),
);
CREATE TABLE SoundCheck (
    id INT NOT NULL,
    duracao INT CHECK (duracao > 0),
    dataInicio DATETIME,
    PRIMARY KEY(id),
);
CREATE TABLE EmpresaCatering (
    nif VARCHAR(9) CHECK (nif LIKE '[0-9]{9}'),
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) CHECK (email LIKE '[a-zA-Z_-0-9]+@[a-Z]+.[a-z]+'),
    telefone VARCHAR(9) CHECK (telefone LIKE '[0-9]{9}'),
    endereço VARCHAR(8) NOT NULL CHECK (endereço LIKE '^[0-9]{4}-[0-9]{3}'),
    PRIMARY KEY(nif),
);
CREATE TABLE GeneroMusical (
    id_banda INT NOT NULL,
    genero VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_banda, genero),
    FOREIGN KEY (id_banda) REFERENCES Banda(id),
);
CREATE TABLE Comitiva (
    id INT NOT NULL,
    email VARCHAR(50) CHECK (email LIKE '[a-zA-Z_-0-9]+@[a-Z]+.[a-z]+'),
    telefone VARCHAR(9) CHECK (telefone LIKE '[0-9]{9}'),
    nTecnicos INT NOT NULL,
    nElementos INT NOT NULL,
    nAcompanhantes INT NOT NULL,
    id_banda INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_banda) REFERENCES Banda(id),
);
CREATE TABLE Acompanhante (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    tipo VARCHAR(50),
    id_comitiva INT NOT NULL,
    PRIMARY KEY(cc),
    FOREIGN KEY(cc) REFERENCES Pessoa(cc),
    FOREIGN KEY(id_comitiva) REFERENCES Comitiva(id),
);
CREATE TABLE Tecnico (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    tipo VARCHAR(50),
    id_comitiva INT NOT NULL,
    PRIMARY KEY(cc),
    FOREIGN KEY(cc) REFERENCES Pessoa(cc),
    FOREIGN KEY(id_comitiva) REFERENCES Comitiva(id),
);
CREATE TABLE Musico (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    nomeArtistico VARCHAR(50),
    id_banda INT NOT NULL,
    PRIMARY KEY(cc),
    FOREIGN KEY(cc) REFERENCES Pessoa(cc),
    FOREIGN KEY(id_banda) REFERENCES Banda(id),
);
CREATE TABLE Instrumento (
    id INT NOT NULL,
    marca VARCHAR(50),
    fabricante VARCHAR(50),
    model VARCHAR(50),
    cc_musico VARCHAR(12) NOT NULL CHECK (cc_musico LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    PRIMARY KEY(id),
    FOREIGN KEY(cc_musico) REFERENCES Musico(cc),
);
CREATE TABLE FamiliaInstrumento (
    id_instrumento INT NOT NULL,
    familia VARCHAR(50),
    PRIMARY KEY(id_instrumento, familia),
    FOREIGN KEY(id_instrumento) REFERENCES Instrumento(id),
);
CREATE TABLE Manager (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    tipo VARCHAR(50),
    PRIMARY KEY(cc),
    FOREIGN KEY(cc) REFERENCES Pessoa(cc),
);
CREATE TABLE Promotor (
    cc VARCHAR(12) NOT NULL CHECK (cc LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    tipo VARCHAR(50),
    PRIMARY KEY(cc),
    FOREIGN KEY(cc) REFERENCES Pessoa(cc),
);
CREATE TABLE Evento (
    id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    nDias INT CHECK (nDias > 0),
    dataInicio DATETIME NOT NULL,
    dataFim DATETIME NOT NULL,
    nBilhetes INT,
    dataProposta DATETIME NOT NULL,
    cc_promotor VARCHAR(12) NOT NULL CHECK (cc_promotor LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    cc_manager VARCHAR(12) NOT NULL CHECK (cc_manager LIKE '[0-9]{9}[A-Z]{2}[0-9]{1}'),
    PRIMARY KEY(id),
    FOREIGN KEY(cc_promotor) REFERENCES Promotor(cc),
    FOREIGN KEY(cc_manager) REFERENCES Manager(cc),
);
CREATE TABLE Palco(
    id INT NOT NULL,
    endereço VARCHAR(8) NOT NULL CHECK (endereço LIKE '^[0-9]{4}-[0-9]{3}'),
    lotacao INT CHECK (lotacao > 0),
    id_evento INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_evento) REFERENCES Evento(id),
);
CREATE TABLE Concerto(
    id INT NOT NULL,
    id_evento INT NOT NULL,
    id_palco INT NOT NULL,
    id_banda INT NOT NULL,
    duracao INT CHECK (duracao > 0),
    dataInicio DATETIME NOT NULL,
    id_soundcheck INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(id_evento) REFERENCES Evento(id),
    FOREIGN KEY(id_palco) REFERENCES Palco(id),
    FOREIGN KEY(id_banda) REFERENCES Banda(id),
    FOREIGN KEY(id_soundcheck) REFERENCES SoundCheck(id),
);
CREATE TABLE Refeicao(
    id_evento INT NOT NULL,
    nif_empresa VARCHAR(9) CHECK (nif_empresa LIKE '[0-9]{9}'),
    id INT NOT NULL,
    prato VARCHAR(50) NOT NULL,
    sobremesa VARCHAR(50),
    bebida VARCHAR(50),
    PRIMARY KEY(id),
    FOREIGN KEY(id_evento) REFERENCES Evento(id),
    FOREIGN KEY(nif_empresa) REFERENCES EmpresaCatering(nif),
)