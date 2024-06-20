CREATE SCHEMA ACE;
SET SEARCH_PATH TO ACE; 

CREATE TABLE Branch ( 
    Branch_ID CHAR(4), 
    Location VARCHAR(30) NOT NULL, 
    Telephone_No CHAR(11) NOT NULL,
    Email VARCHAR(30) NOT NULL, 
    Budget DECIMAL(12, 2) NOT NULL,
    Head_ID CHAR(4) NOT NULL, 
    PRIMARY KEY (Branch_ID) 
    -- FOREIGN KEY (Head_ID) REFERENCES Personnel(Personnel_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Items ( 
    Item_Code CHAR(4), 
    Item_Name VARCHAR(50) NOT NULL UNIQUE, 
    Cost DECIMAL(9, 2) NOT NULL,
    PRIMARY KEY (Item_Code) 
);

CREATE TABLE Inventory (
    Branch_ID CHAR(4), 
    Item_Code CHAR(4), 
    Stock INTEGER NOT NULL,
    PRIMARY KEY (Branch_ID, Item_Code),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Item_Code) REFERENCES Items(Item_Code) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Unit ( 
    Unit_ID CHAR(4), 
    Unit_Name VARCHAR(30) NOT NULL UNIQUE, 
    PRIMARY KEY (Unit_ID) 
); 

CREATE TABLE Associated_Unit ( 
    Branch_ID CHAR(4),
    Unit_ID CHAR(4), 
    Coordinator_ID CHAR(4) NOT NULL UNIQUE, 
    PRIMARY KEY (Branch_ID, Unit_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Unit_ID) REFERENCES Unit(Unit_ID) ON UPDATE CASCADE ON DELETE CASCADE
    -- FOREIGN KEY (Coordinator_ID) REFERENCES Personnel(Personnel_ID) ON UPDATE CASCADE ON DELETE CASCADE
); 

CREATE TABLE Personnel (
    Personnel_ID CHAR(4),
    Branch_ID CHAR(4) NOT NULL, 
    Unit_ID CHAR(4) NOT NULL, 
    Name VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Designation VARCHAR(30) NOT NULL,
    Hire_Date DATE NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    Service_Status VARCHAR(10) NOT NULL,
    Years_of_Experience INTEGER NOT NULL,
    DOB DATE NOT NULL,
    Phone_No CHAR(10) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    PRIMARY KEY (Personnel_ID),
    FOREIGN KEY (Branch_ID, Unit_ID) REFERENCES Associated_Unit(Branch_ID, Unit_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Cases ( 
    Case_ID CHAR(18),
    Case_Title VARCHAR(300) NOT NULL,
    Reporting_Time TIMESTAMP NOT NULL,
    Crime_Location VARCHAR(100) NOT NULL,
    Status VARCHAR(10) NOT NULL,
    PRIMARY KEY (Case_ID)
);

CREATE TABLE Assigned_Case (
    Personnel_ID CHAR(4),
    Case_ID CHAR(18),
    PRIMARY KEY (Personnel_ID, Case_ID),
    FOREIGN KEY (Personnel_ID) REFERENCES Personnel(Personnel_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Criminal_Record (
    Criminal_ID CHAR(6), 
    Name VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Nationality VARCHAR(10) NOT NULL,
    Contact_No CHAR(10) NOT NULL,
    Known_Address VARCHAR(50),
    PRIMARY KEY (Criminal_ID)
);

CREATE TABLE Evidence ( 
    Case_ID CHAR(18),
    Item_Found VARCHAR(100) NOT NULL,
    Location_Found VARCHAR(100) NOT NULL,
    Date_Time_Found TIMESTAMP NOT NULL,
    PRIMARY KEY (Case_ID, Item_Found),
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE
);  

CREATE TABLE Verdict (
    Case_ID CHAR(18),
    Criminal_ID CHAR(6), 
    Case_End_Date DATE NOT NULL,
    Court_Verdict VARCHAR(200) NOT NULL,
    PRIMARY KEY (Case_ID, Criminal_ID),
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Criminal_ID) REFERENCES Criminal_Record(Criminal_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Witness (
    Case_ID CHAR(18), 
    Name VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Contact_No CHAR(10) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Witness_Statement VARCHAR(300) NOT NULL,
    PRIMARY KEY (Case_ID, Name),
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Victim (
    Case_ID CHAR(18), 
    Name VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Contact_No CHAR(10) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Victim_Description VARCHAR(300) NOT NULL,
    PRIMARY KEY (Case_ID, Name),
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Suspect (
    Case_ID CHAR(18), 
    Name VARCHAR(30) NOT NULL,
    Gender CHAR(1) NOT NULL,
    DOB DATE NOT NULL,
    Contact_No CHAR(10) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Suspect_Description VARCHAR(300) NOT NULL,
    PRIMARY KEY (Case_ID, Name),
    FOREIGN KEY (Case_ID) REFERENCES Cases(Case_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Run these constraints when all the data insertions are completed
-- ALTER TABLE Branch ADD FOREIGN KEY (head_id) REFERENCES Personnel(Personnel_id);
-- ALTER TABLE Associated_Unit ADD FOREIGN KEY (Coordinator_ID) REFERENCES Personnel(Personnel_ID);