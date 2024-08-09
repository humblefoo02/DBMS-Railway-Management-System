CREATE DATABASE train_reservation
USE train_reservation

CREATE TABLE user (
    u_id INT PRIMARY KEY,
    password VARCHAR(255),
    security VARCHAR(255)
);

CREATE TABLE passenger (
    pnr INT PRIMARY KEY,
    p_name VARCHAR(255),
    res_status VARCHAR(50),
    age INT,
    gender CHAR(1),
    seat_no VARCHAR(10)
);

CREATE TABLE station (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(255)
);

CREATE TABLE route (
    stop_no INT PRIMARY KEY,
    arr_time TIME,
    depart_time TIME
);

CREATE TABLE train (
    train_id INT PRIMARY KEY,
    t_name VARCHAR(255),
    train_type VARCHAR(50),
    avail_class VARCHAR(50)
);

CREATE TABLE tain_status (
    train_id INT,
    wait_seat INT,
    avail BOOLEAN,
    status VARCHAR(50),
    booked INT,
    FOREIGN KEY (train_id) REFERENCES train(train_id)
);



INSERT INTO user (u_id, password, security) VALUES
(1, 'pass123', 'sec1'),
(2, 'pass456', 'sec2'),
(3, 'pass789', 'sec3'),
(4, 'pass012', 'sec4'),
(5, 'pass345', 'sec5');

INSERT INTO passenger (pnr, p_name, res_status, age, gender, seat_no) VALUES
(1001, 'John Doe', 'Confirmed', 30, 'M', '12A'),
(1002, 'Jane Doe', 'Waiting', 27, 'F', ''),
(1003, 'Jim Beam', 'Confirmed', 34, 'M', '13B'),
(1004, 'Jill Hill', 'Confirmed', 28, 'F', '14A'),
(1005, 'Jack Jill', 'Waiting', 32, 'M', '');

INSERT INTO station (s_id, s_name) VALUES
(1, 'Station A'),
(2, 'Station B'),
(3, 'Station C'),
(4, 'Station D'),
(5, 'Station E');

INSERT INTO route (stop_no, arr_time, depart_time) VALUES
(1, '08:00:00', '08:10:00'),
(2, '09:00:00', '09:10:00'),
(3, '10:00:00', '10:10:00'),
(4, '11:00:00', '11:10:00'),
(5, '12:00:00', '12:10:00');

INSERT INTO train (train_id, t_name, train_type, avail_class) VALUES
(101, 'Train A', 'Express', 'First Class'),
(102, 'Train B', 'Regular', 'Second Class'),
(103, 'Train C', 'Express', 'First Class'),
(104, 'Train D', 'Regular', 'Second Class'),
(105, 'Train E', 'Express', 'First Class');

INSERT INTO tain_status (train_id, wait_seat, avail, status, booked) VALUES
(101, 0, TRUE, 'On Time', 30),
(102, 5, TRUE, 'Delayed', 25),
(103, 2, TRUE, 'On Time', 28),
(104, 0, TRUE, 'Cancelled', 0),
(105, 3, TRUE, 'On Time', 31);


CREATE VIEW PassengerTrainInfo AS
SELECT
    p.pnr,
    p.p_name,
    p.res_status,
    p.seat_no,
    t.train_id,
    t.t_name,
    t.train_type,
    t.avail_class,
    ts.status AS train_status,
    ts.booked,
    ts.avail
FROM
    passenger p
JOIN
    train t ON p.pnr = t.train_id  -- This join condition is assumed for demonstration purposes; adjust as needed
JOIN
    tain_status ts ON t.train_id = ts.train_id;


CREATE VIEW TrainAvailability AS
SELECT
    t.train_id,
    t.t_name,
    ts.avail,
    ts.status,
    ts.booked,
    (CASE
        WHEN ts.avail = TRUE THEN 'Yes'
        ELSE 'No'
    END) AS availability_text
FROM
    train t
JOIN
    tain_status ts ON t.train_id = ts.train_id;
    
    

DELIMITER //
CREATE TRIGGER AfterReservation
AFTER INSERT ON passenger
FOR EACH ROW
BEGIN
    IF NEW.res_status = 'Confirmed' THEN
        UPDATE tain_status
        SET booked = booked + 1
        WHERE train_id = (SELECT train_id FROM train WHERE train_id = NEW.pnr);
    END IF;
END; //
DELIMITER ;


-- Assuming a transaction to book a train seat
START TRANSACTION;
INSERT INTO user (u_id, password, security) VALUES (6, 'passExample', 'secExample');
-- Any other operations
COMMIT;

START TRANSACTION;
INSERT INTO user (u_id, password, security) VALUES (7, 'passExample2', 'secExample2');
-- Assume we decide not to add this user
ROLLBACK;

START TRANSACTION;
INSERT INTO station (s_id, s_name) VALUES (6, 'Station F');
SAVEPOINT SPStation;
INSERT INTO station (s_id, s_name) VALUES (7, 'Station G');
-- Decision to undo the last insert
ROLLBACK TO SPStation;
COMMIT;




DELIMITER $$

CREATE PROCEDURE ProcessConfirmedPassengers()
BEGIN
    -- Declare variables to hold data for each row
    DECLARE done INT DEFAULT FALSE;
    DECLARE pnr_var INT;
    DECLARE p_name_var VARCHAR(255);
    DECLARE seat_no_var VARCHAR(10);
    -- Declare the cursor
    DECLARE passenger_cursor CURSOR FOR
        SELECT pnr, p_name, seat_no FROM passenger WHERE res_status = 'Confirmed';
    -- Declare continue handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN passenger_cursor;

    -- Loop through all rows
    read_loop: LOOP
        FETCH passenger_cursor INTO pnr_var, p_name_var, seat_no_var;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Placeholder for operations on each row
        -- Example operation: output to console (This specific line is pseudo-code as MySQL does not support direct outputting)
        -- SELECT CONCAT('Processing passenger: ', p_name_var, ' with seat no: ', seat_no_var);
        
    END LOOP;

    -- Close the cursor
    CLOSE passenger_cursor;
END$$

DELIMITER ;




