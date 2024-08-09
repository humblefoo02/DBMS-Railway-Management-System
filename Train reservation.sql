CREATE DATABASE IF NOT EXISTS TrainReservationSystem;
USE TrainReservationSystem;

CREATE TABLE User (
    u_id INT PRIMARY KEY AUTO_INCREMENT,
    Password VARCHAR(255) NOT NULL,
    Security VARCHAR(255) NOT NULL
);

CREATE TABLE Passenger (
    PNR INT PRIMARY KEY AUTO_INCREMENT,
    p_name VARCHAR(255) NOT NULL,
    Gender CHAR(1),
    Seat_no INT,
    Reserve_status BOOLEAN,
    Age INT
);

CREATE TABLE Train (
    Train_id INT PRIMARY KEY AUTO_INCREMENT,
    T_name VARCHAR(255) NOT NULL,
    Train_type VARCHAR(255),
    Avail_class VARCHAR(255),
    Train_status VARCHAR(255)
);

CREATE TABLE Station (
    S_id INT PRIMARY KEY AUTO_INCREMENT,
    S_name VARCHAR(255) NOT NULL,
    Route VARCHAR(255) NOT NULL
);

CREATE TABLE Route (
    Train_id INT,
    S_id INT,
    Start BOOLEAN,
    End BOOLEAN,
    Stop_no INT,
    Depart_time TIME,
    Arriv_time TIME,
    PRIMARY KEY (Train_id, S_id),
    FOREIGN KEY (Train_id) REFERENCES Train(Train_id),
    FOREIGN KEY (S_id) REFERENCES Station(S_id)
);

CREATE TABLE Book (
    Train_id INT,
    u_id INT,
    PNR INT,
    Dates DATE,
    PRIMARY KEY (Train_id, u_id, PNR),
    FOREIGN KEY (Train_id) REFERENCES Train(Train_id),
    FOREIGN KEY (u_id) REFERENCES User(u_id),
    FOREIGN KEY (PNR) REFERENCES Passenger(PNR)
);

USE TrainReservationSystem;

CREATE TABLE TrainStatus (
    Train_id INT,
    Avail varchar(255),
    Statuss varchar(255),
    Booked varchar(255),
    WaitSeat varchar(255),
    PRIMARY KEY (Train_id),
    FOREIGN KEY (Train_id) REFERENCES Train(Train_id)
);


-- Insert sample data
INSERT INTO User (Password, Security) VALUES ('password123', 'securityQ1'), ('password456', 'securityQ2');
INSERT INTO Passenger (p_name, Gender, Seat_no, Reserve_status, Age) VALUES ('John Doe', 'M', 1, TRUE, 25), ('Jane Doe', 'F', 2, TRUE, 30);
INSERT INTO Train (T_name, Train_type, Avail_class, Train_status) VALUES ('Express', 'Fast', 'First Class', 'On Time'), ('Local', 'Slow', 'Economy', 'Delayed');
INSERT INTO Station (S_name, Route) VALUES ('Station A', 'Route 1'), ('Station B', 'Route 2');
INSERT INTO Route (Train_id, S_id, Start, End, Stop_no, Depart_time, Arriv_time) VALUES (1, 1, TRUE, FALSE, 1, '08:00:00', '09:00:00'), (1, 2, FALSE, TRUE, 2, '09:30:00', '10:30:00');
INSERT INTO Book (Train_id, u_id, PNR, Dates) VALUES (1, 1, 1, '2024-02-28'), (1, 2, 2, '2024-03-01');
INSERT INTO TrainStatus (Train_id, Avail, Statuss, Booked, WaitSeat) VALUES
(1, 'Available', 'On time', '50', '20'),
(2, 'Available', 'Delayed', '45', '15'),
(3, 'Full', 'On time', '60', '0'),
(4, 'Available', 'Cancelled', '0', '0'),
(5, 'Full', 'On time', '60', '0'),
(6, 'Available', 'Delayed', '55', '10'),
(7, 'Full', 'On time', '60', '0'),
(8, 'Available', 'On time', '40', '25'),
(9, 'Available', 'Delayed', '50', '20'),
(10, 'Full', 'On time', '60', '0');


-- Additional tables and data can be added based on further requirements
