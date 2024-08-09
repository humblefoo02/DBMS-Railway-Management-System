CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    PhoneNumbers VARCHAR(255),  -- Multiple phone numbers in one field
    AccountIDs VARCHAR(255)     -- Multiple account IDs in one field
);

INSERT INTO Customers VALUESpassenger
(1, 'John Doe', '123 Elm St', '123-456, 789-012', 'A101, A102'),
(1, 'John Doe', '123 Elm St', '123-456, 789-012', 'A101, A102'),  -- Duplicate entry
(2, 'Jane Smith', '456 Oak St', '234-567', 'A103'),
(3, 'Alice Johnson', '789 Pine St', '345-678', 'A104, A105, A106'),
(4, 'Bob Brown', '101 Maple St', '456-789', 'A107'),
(5, 'Charlie Black', '102 Maple St', '567-890', 'A108'),
(6, 'David Wilson', '103 Maple St', '678-901', 'A109'),
(7, 'Eve White', '104 Maple St', '789-012', 'A110'),
(8, 'Frank Green', '105 Maple St', '890-123', 'A111'),
(9, 'Grace Hall', '106 Maple St', '901-234', 'A112'),
(10, 'Hank Moody', '107 Maple St', '012-345', 'A113'),
(11, 'Ivy Gold', '108 Maple St', '123-456', 'A114'),
(12, 'Jake Silver', '109 Maple St', '234-567', 'A115'),
(13, 'Kate Bronze', '110 Maple St', '345-678', 'A116'),
(14, 'Luke Iron', '111 Maple St', '456-789', 'A117'),
(15, 'Mia Copper', '112 Maple St', '567-890', 'A118');


CREATE TABLE Accounts (
    AccountID VARCHAR(255) PRIMARY KEY,
    CustomerID INT,
    Balance DECIMAL(10, 2),
    AccountType VARCHAR(50)
);

INSERT INTO Accounts VALUES
('A101', 1, 1000.50, 'Checking'),
('A102', 1, 1500.75, 'Savings'),
('A103', 2, 2000.00, 'Checking'),
('A104', 3, 2500.25, 'Savings'),
('A105', 3, 3000.00, 'Checking'),
('A106', 3, 3500.00, 'Savings'),
('A107', 4, 4000.75, 'Checking'),
('A108', 5, 4500.25, 'Savings'),
('A109', 6, 5000.50, 'Checking'),
('A110', 7, 5500.75, 'Savings'),
('A111', 8, 6000.00, 'Checking'),
('A112', 9, 6500.25, 'Savings'),
('A113', 10, 7000.50, 'Checking'),
('A114', 11, 7500.75, 'Savings'),
('A115', 12, 8000.00, 'Checking'),
('A116', 13, 8500.25, 'Savings'),
('A117', 14, 9000.50, 'Checking'),
('A118', 15, 9500.75, 'Savings');


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID VARCHAR(255),
    Amount DECIMAL(10, 2),
    Date DATE,
    Details VARCHAR(255)  -- Multiple details in one field
);

INSERT INTO Transactions VALUES
(1, 'A101', -100.00, '2023-01-10', 'ATM Withdrawal, Fee $2'),
(2, 'A102', 200.00, '2023-01-11', 'Deposit, Check #123'),
(3, 'A103', -50.00, '2023-01-12', 'Payment, Online Purchase'),
(4, 'A104', 150.00, '2023-01-13', 'Deposit, Cash'),
(5, 'A105', -30.00, '2023-01-14', 'ATM Withdrawal, Fee $1'),
(6, 'A106', 300.00, '2023-01-15', 'Deposit, Check #124'),
(7, 'A107', -75.00, '2023-01-16', 'Payment, Online Purchase'),
(8, 'A108', 400.00, '2023-01-17', 'Deposit, Cash'),
(9, 'A109', -25.00, '2023-01-18', 'ATM Withdrawal, Fee $1'),
(10, 'A110', 500.00, '2023-01-19', 'Deposit, Check #125'),
(11, 'A111', -60.00, '2023-01-20', 'Payment, Online Purchase'),
(12, 'A112', 600.00, '2023-01-21', 'Deposit, Cash'),
(13, 'A113', -80.00, '2023-01-22', 'ATM Withdrawal, Fee $1'),
(14, 'A114', 700.00, '2023-01-23', 'Deposit, Check #126'),
(15, 'A115', -90.00, '2023-01-24', 'Payment, Online Purchase'),
(16, 'A116', 800.00, '2023-01-25', 'Deposit, Cash'),
(17, 'A117', -100.00, '2023-01-26', 'ATM Withdrawal, Fee $1'),
(18, 'A118', 900.00, '2023-01-27', 'Deposit, Check #127');


CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255),
    Address VARCHAR(255),
    ManagerName VARCHAR(255)
);

INSERT INTO Branches VALUES
(1, 'Downtown', '123 City Rd', 'Alice Johnson'),
(2, 'Uptown', '456 Uptown Rd', 'Bob Brown'),
(3, 'Midtown', '789 Midtown Rd', 'Alice Johnson'),  -- Redundant manager name
(4, 'Eastside', '101 Eastside Rd', 'Charlie Black'),
(5, 'Westside', '102 Westside Rd', 'David Wilson');




-- normalisation 

-- nf1
 CREATE TABLE Customers_nf1 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255)
);

INSERT INTO Customers_nf1 VALUES
(1, 'John Doe', '123 Elm St'),
(2, 'Jane Smith', '456 Oak St'),
(3, 'Alice Johnson', '789 Pine St'),
(4, 'Bob Brown', '101 Maple St'),
(5, 'Charlie Black', '102 Maple St'),
(6, 'David Wilson', '103 Maple St'),
(7, 'Eve White', '104 Maple St'),
(8, 'Frank Green', '105 Maple St'),
(9, 'Grace Hall', '106 Maple St'),
(10, 'Hank Moody', '107 Maple St'),
(11, 'Ivy Gold', '108 Maple St'),
(12, 'Jake Silver', '109 Maple St'),
(13, 'Kate Bronze', '110 Maple St'),
(14, 'Luke Iron', '111 Maple St'),
(15, 'Mia Copper', '112 Maple St');


CREATE TABLE PhoneNumbers_nf1 (
    CustomerID INT,
    PhoneNumber VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers_nf1(CustomerID)
);

INSERT INTO PhoneNumbers_nf1 VALUES
(1, '123-456'),
(1, '789-012'),
(2, '234-567'),
(3, '345-678'),
(4, '456-789'),
(5, '567-890'),
(6, '678-901'),
(7, '789-012'),
(8, '890-123'),
(9, '901-234'),
(10, '012-345'),
(11, '123-456'),
(12, '234-567'),
(13, '345-678'),
(14, '456-789'),
(15, '567-890');


CREATE TABLE Accounts_nf1 (
    AccountID VARCHAR(255) PRIMARY KEY,
    CustomerID INT,
    Balance DECIMAL(10, 2),
    AccountType VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers_nf1(CustomerID)
);

INSERT INTO Accounts_nf1 VALUES
('A101', 1, 1000.50, 'Checking'),
('A102', 1, 1500.75, 'Savings'),
('A103', 2, 2000.00, 'Checking'),
('A104', 3, 2500.25, 'Savings'),
('A105', 3, 3000.00, 'Checking'),
('A106', 3, 3500.00, 'Savings'),
('A107', 4, 4000.75, 'Checking'),
('A108', 5, 4500.25, 'Savings'),
('A109', 6, 5000.50, 'Checking'),
('A110', 7, 5500.75, 'Savings'),
('A111', 8, 6000.00, 'Checking'),
('A112', 9, 6500.25, 'Savings'),
('A113', 10, 7000.50, 'Checking'),
('A114', 11, 7500.75, 'Savings'),
('A115', 12, 8000.00, 'Checking'),
('A116', 13, 8500.25, 'Savings'),
('A117', 14, 9000.50, 'Checking'),
('A118', 15, 9500.75, 'Savings');




-- nf2
 CREATE TABLE CustomerAccounts_nf2 (
    CustomerID INT,
    AccountID VARCHAR(255),
    BranchID INT,  -- Assuming customers can have accounts in different branches
    AccountType VARCHAR(50),  -- This is dependent only on AccountID, not the whole composite key
    FOREIGN KEY (CustomerID) REFERENCES Customers_nf1(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts_nf1(AccountID),
    PRIMARY KEY (CustomerID, AccountID)
);

INSERT INTO CustomerAccounts_nf2 VALUES
(1, 'A101', 1, 'Checking'),
(1, 'A102', 1, 'Savings'),
(2, 'A103', 2, 'Checking');


CREATE TABLE Accounts_nf2 (
    AccountID VARCHAR(255) PRIMARY KEY,
    Balance DECIMAL(10, 2),
    AccountType VARCHAR(50)  -- Moved here because it's dependent only on AccountID
);

INSERT INTO Accounts_nf2 VALUES
('A101', 1000.50, 'Checking'),
('A102', 1500.75, 'Savings'),
('A103', 2000.00, 'Checking');


CREATE TABLE CustomerAccounts_nf2sol (
    CustomerID INT,
    AccountID VARCHAR(255),
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers_nf1(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts_nf2(AccountID),
    PRIMARY KEY (CustomerID, AccountID)
);

INSERT INTO CustomerAccounts_nf2sol VALUES
(1, 'A101', 1),
(1, 'A102', 1),
(2, 'A103', 2);



-- nf3
CREATE TABLE Branches_nf3 (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255),
    Address VARCHAR(255),
    ManagerID INT,
    ManagerName VARCHAR(255)  -- This is a transitive dependency if ManagerID determines ManagerName
);


CREATE TABLE Branches_nf3sol (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255),
    Address VARCHAR(255),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Managers(ManagerID)
);


CREATE TABLE Managers_nf3 (
    ManagerID INT PRIMARY KEY,
    ManagerName VARCHAR(255)
);

-- Insert some sample data into Managers
INSERT INTO Managers_nf3 VALUES
(1, 'Alice Johnson'),
(2, 'Bob Brown'),
(3, 'Charlie Black');

-- Insert data into the revised Branches table
INSERT INTO Branches_nf3sol VALUES
(1, 'Downtown', '123 City Rd', 1),
(2, 'Uptown', '456 Uptown Rd', 2),
(3, 'Midtown', '789 Midtown Rd', 1);  -- Note that Alice Johnson manages both Downtown and Midtown


-- bcnf

-- Assuming BranchName could uniquely determine Address
CREATE TABLE Branches_nf4 (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255) UNIQUE,
    Address VARCHAR(255),  -- Hypothetically functionally dependent on BranchName
    ManagerID INT
);

CREATE TABLE Branches_nf4sol (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(255) UNIQUE,
    ManagerID INT
);

CREATE TABLE BranchLocations_nf4 (
    BranchName VARCHAR(255) PRIMARY KEY,
    Address VARCHAR(255)
);
 
