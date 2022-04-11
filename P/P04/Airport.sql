CREATE SCHEMA Airport;
GO
CREATE TABLE Airport (
    Code INT NOT NULL,
    Airport_Name VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,
    Estado INT NOT NULL CHECK (
        Estado >= 0
        AND Estado <= 1
    ),
    PRIMARY KEY (Code),
);
CREATE TABLE Airplane_type (
    Name_type VARCHAR(30) NOT NULL,
    Max_seats INT NOT NULL CHECK (Max_seats > 0),
    Company VARCHAR(30) NOT NULL,
    PRIMARY KEY (Name_type),
);
CREATE TABLE Can_Land (
    Code INT NOT NULL,
    Name_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (Code, Name_type),
    FOREIGN KEY (Code) REFERENCES Airport(Code),
    FOREIGN KEY (Name_type) REFERENCES Airplane_type(Name_type)
);
CREATE TABLE Airplane(
    Airplane_id VARCHAR(5) NOT NULL,
    Total_nr_of_seats INT NOT NULL CHECK (Total_nr_of_seats > 0),
    Name_type VARCHAR(30) NOT NULL,
    PRIMARY KEY (Airplane_id),
    FOREIGN KEY (Name_type) REFERENCES Airplane_type(Name_type)
);
CREATE TABLE Flight(
    Number_fl INT NOT NULL,
    Airline VARCHAR(30) NOT NULL,
    WeekDays VARCHAR(3) CHECK (
        WeekDays IN ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')
    ),
    PRIMARY KEY (Number_fl),
);
CREATE TABLE Flight_Leg(
    Departure_code INT NOT NULL,
    Arrival_code INT NOT NULL,
    Leg_number_fl INT NOT NULL,
    Flight_number_fl INT NOT NULL,
    Departure_time DATETIME NOT NULL,
    Arrival_time DATETIME NOT NULL,
    PRIMARY KEY (Leg_number_fl, Flight_number_fl),
    FOREIGN KEY (Departure_code) REFERENCES Airport(Code),
    FOREIGN KEY (Arrival_code) REFERENCES Airport(Code),
    FOREIGN KEY (Flight_number_fl) REFERENCES Flight(Number_fl),
    CHECK (Departure_time < Arrival_time),
);
CREATE TABLE Fares(
    Code INT NOT NULL,
    Flight_number_fl INT NOT NULL,
    Amount INT,
    Restrictions VARCHAR(50),
    PRIMARY KEY (Code, Flight_number_fl),
    FOREIGN KEY (Flight_number_fl) REFERENCES Flight(Number_fl)
);
CREATE TABLE Leg_Instance(
    Leg_Instance_DATE DATE NOT NULL,
    Flight_number_fl INT NOT NULL,
    Airplane_id VARCHAR(5) NOT NULL,
    Leg_number_fl INT NOT NULL,
    Departure_time DATETIME NOT NULL,
    Arrival_time DATETIME NOT NULL,
    Number_fl_avail_seats INT,
    Departure_code INT NOT NULL,
    Arrival_code INT NOT NULL,
    PRIMARY KEY (
        Flight_number_fl,
        Leg_number_fl,
        Leg_Instance_DATE
    ),
    FOREIGN KEY (Departure_code) REFERENCES Airport(Code),
    FOREIGN KEY (Arrival_code) REFERENCES Airport(Code),
    FOREIGN KEY (Leg_number_fl, Flight_number_fl) REFERENCES Flight_Leg(Leg_number_fl, Flight_number_fl),
    FOREIGN KEY (Flight_number_fl) REFERENCES Flight(Number_fl),
    FOREIGN KEY (Airplane_id) REFERENCES Airplane(Airplane_id),
);
CREATE TABLE Seat(
    Flight_number_fl INT NOT NULL,
    Leg_number_fl INT NOT NULL,
    Seat_number_fl INT NOT NULL,
    Seat_date DATE NOT NULL,
    Customer_name VARCHAR(30) NOT NULL,
    Cphone INT NOT NULL,
    PRIMARY KEY (
        Seat_number_fl,
        Seat_date,
        Leg_number_fl,
        Flight_number_fl
    ),
    FOREIGN KEY (Flight_number_fl, Leg_number_fl, Seat_date) REFERENCES Leg_Instance(
        Flight_number_fl,
        Leg_number_fl,
        Leg_Instance_DATE
    ),
);