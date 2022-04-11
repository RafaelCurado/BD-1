CREATE SCHEMA RentACar;
GO
END CREATE TABLE Client (
	NIF INT NOT NULL CHECK (
		NIF BETWEEN 100000000 AND 999999999
	),
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(8) CHECK (Address LIKE '^[0-9]{4}-[0-9]{3}'),
	NLicense INT,
	PRIMARY KEY(NIF),
);
CREATE TABLE Filiate (
	Num INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(8) CHECK (Address LIKE '^[0-9]{4}-[0-9]{3}'),
	PRIMARY KEY(Num)
);
CREATE TABLE TypeCar (
	Code VARCHAR(50) NOT NULL,
	Designation VARCHAR(50),
	A_R INT CHECK (
		A_R = 0
		OR A_R = 1
	),
	PRIMARY KEY(Code),
);
CREATE TABLE Similar(
	frs_code VARCHAR(50) NOT NULL,
	scn_code VARCHAR(50) NOT NULL,
	PRIMARY KEY(frs_code, scn_code),
	FOREIGN KEY(frs_code) REFERENCES TypeCar(Code),
	FOREIGN KEY(scn_code) REFERENCES TypeCar(Code),
);
CREATE TABLE Car (
	Plate VARCHAR(6) NOT NULL,
	Automaker VARCHAR(50),
	Year_make DATE,
	Type_code VARCHAR(50),
	PRIMARY KEY(Plate),
	FOREIGN KEY(Type_code) REFERENCES TypeCar(Code),
);
CREATE TABLE Rented (
	Num INT NOT NULL,
	Duration INT CHECK(Duration > 0),
	Date DATETIME,
	Client_NIF INT,
	Filiate_Num INT,
	Car_plate VARCHAR(6),
	PRIMARY KEY(Num),
	FOREIGN KEY(Client_NIF) REFERENCES Client(NIF),
	FOREIGN KEY(Filiate_Num) REFERENCES Filiate(Num),
	FOREIGN KEY(Car_Plate) REFERENCES Car(Plate),
);
CREATE TABLE Light(
	N_seats INT CHECK (
		N_seats >= 0
		AND N_seats <= 9
	),
	N_doors INT,
	Fuel INT CHECK (
		/*Using UN codes for hazardous materials*/
		Fuel >= 1
		AND Fuel <= 3600
	),
	Type_code VARCHAR(50),
	PRIMARY KEY(Type_code),
	FOREIGN KEY(Type_code) REFERENCES TypeCar(Code),
);
CREATE TABLE Heavy(
	Pass INT NOT NULL CHECK (
		Pass = 0
		OR Pass = 1
	),
	W_eight INT NOT NULL CHECK (W_eight > 3500),
	Type_code VARCHAR(50),
	PRIMARY KEY(Type_code),
	FOREIGN KEY(Type_code) REFERENCES TypeCar(Code),
);