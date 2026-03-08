
DROP DATABASE IF EXISTS SuwapiyasaDB;
CREATE DATABASE SuwapiyasaDB;
USE SuwapiyasaDB;

-- STAFF (SUPERCLASS)
CREATE TABLE Staff (
    EmployeeID  VARCHAR(10) PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    Address VARCHAR(200),
    TelephoneNumber VARCHAR(20),
    EmployeeType ENUM('Nurse','Doctor','Surgeon') NOT NULL
);
DESCRIBE Staff;

-- NURSE (SUBCLASS OF STAFF)
CREATE TABLE Nurse (
    NurseID  VARCHAR(10) PRIMARY KEY,
    Grade VARCHAR(50),
    YearOfExperience INT CHECK (YearOfExperience >= 0),
    SurgerySkillType VARCHAR(100),
    MonthlySalary DECIMAL(10,2) CHECK (MonthlySalary >= 0),
    FOREIGN KEY (NurseID) REFERENCES Staff(EmployeeID)
);
DESCRIBE Nurse;

-- DOCTOR (SUBCLASS OF STAFF)
CREATE TABLE Doctor (
    DoctorID  VARCHAR(10) PRIMARY KEY,
    Speciality VARCHAR(100),
    MonthlySalary DECIMAL(10,2) CHECK (MonthlySalary >= 0),
    FOREIGN KEY (DoctorID) REFERENCES Staff(EmployeeID)
);
DESCRIBE Doctor;

-- SURGEON (SUBCLASS OF STAFF)
CREATE TABLE Surgeon (
    SurgeonID  VARCHAR(10) PRIMARY KEY,
    Speciality VARCHAR(100),
    ContractType VARCHAR(50),
    ContractLength INT CHECK (ContractLength > 0),
    FOREIGN KEY (SurgeonID) REFERENCES Staff(EmployeeID)
);
DESCRIBE Surgeon;
-- -----------------------------------------
-- HEAD DOCTOR
CREATE TABLE Head_Doctor (
    HDNumber  VARCHAR(10) PRIMARY KEY,
    HeadDoctorName VARCHAR(100),
    Speciality VARCHAR(100)
);
DESCRIBE Head_Doctor;

-- PATIENT
CREATE TABLE Patient (
    PatientID  VARCHAR(10) PRIMARY KEY,
    LastName VARCHAR(100),
    Surname VARCHAR(100),
    Age INT CHECK (Age > 0),
    Address VARCHAR(200),
    BloodType VARCHAR(5),
    TelephoneNumber VARCHAR(20));
DESCRIBE Patient;

-- LOCATION
CREATE TABLE Location (
    LocationID  VARCHAR(10) PRIMARY KEY,
    BedNumber INT,
    RoomNumber INT,
    NursingUnit VARCHAR(50)
);
DESCRIBE Location;

-- ALLERGY
CREATE TABLE Allergy (
    AllergyID  VARCHAR(10) PRIMARY KEY,
    AllergyName VARCHAR(100),
    AllergyType VARCHAR(100)
);
DESCRIBE Allergy;

-- RELATIONSHIP: PATIENT HAS ALLERGY (M:N)
CREATE TABLE Patient_Allergy (
    PatientID  VARCHAR(10),
    AllergyID VARCHAR(10) ,
    PRIMARY KEY (PatientID, AllergyID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AllergyID) REFERENCES Allergy(AllergyID)
);
DESCRIBE Patient_Allergy;

-- MEDICATION
CREATE TABLE Medication (
    MedicationCode  VARCHAR(10) PRIMARY KEY,
    MedicationName VARCHAR(100),
    QuantityOnHand INT CHECK (QuantityOnHand >= 0),
    QuantityOrdered INT CHECK (QuantityOrdered >= 0),
    ExpirationDate DATE,
    Cost DECIMAL(10,2)
);
DESCRIBE Medication;


-- MEDICATION INTERACTION
CREATE TABLE MedicationInteraction (
    InteractionID  VARCHAR(10) PRIMARY KEY,
    InteractionMedicationCode1  VARCHAR(10),
    InteractionMedicationCode2  VARCHAR(10),
    Severity VARCHAR(50),
    FOREIGN KEY (InteractionMedicationCode1) REFERENCES Medication(MedicationCode),
    FOREIGN KEY (InteractionMedicationCode2) REFERENCES Medication(MedicationCode)
);
DESCRIBE MedicationInteraction;

-- RELATIONSHIP: MEDICATION INTERACTS (M:N)
CREATE TABLE Medication_MedicationInteracts (
    MedicationCode  VARCHAR(10),
    InteractionID  VARCHAR(10),
    PRIMARY KEY (MedicationCode, InteractionID),
    FOREIGN KEY (MedicationCode) REFERENCES Medication(MedicationCode),
    FOREIGN KEY (InteractionID) REFERENCES MedicationInteraction(InteractionID)
);
DESCRIBE Medication_MedicationInteracts;

-- THEATRE
CREATE TABLE Theatre (
    TheatreNo  VARCHAR(10) PRIMARY KEY,
    TheatreName VARCHAR(100),
    TheatreLocation VARCHAR(100)
);
DESCRIBE Theatre;

-- SURGERY
CREATE TABLE Surgery (
    SurgeryID  VARCHAR(10) PRIMARY KEY,
    SurgeryName VARCHAR(100),
    Category VARCHAR(100),
    SpecialNeeds VARCHAR(200),
    TheatreNo  VARCHAR(10),
    FOREIGN KEY (TheatreNo) REFERENCES Theatre(TheatreNo)
);
DESCRIBE Surgery;

-- RELATIONSHIP: SURGERY NEED PATIENT (M:1)
CREATE TABLE Surgery_Patient (
    SurgeryID  VARCHAR(10),
    PatientID  VARCHAR(10),
    PRIMARY KEY (SurgeryID, PatientID),
    FOREIGN KEY (SurgeryID) REFERENCES Surgery(SurgeryID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
DESCRIBE Surgery_Patient;

-- RELATIONSHIP: SURGERY OCCURS IN THEATRE (M:1)
CREATE TABLE Surgery_Theatre (
    SurgeryID  VARCHAR(10) PRIMARY KEY,
    TheatreNo  VARCHAR(10),
    FOREIGN KEY (SurgeryID) REFERENCES Surgery(SurgeryID),
    FOREIGN KEY (TheatreNo) REFERENCES Theatre(TheatreNo)
);
DESCRIBE Surgery_Theatre;

-- RELATIONSHIP: NURSE ASSISTS SURGERY (M:N)
CREATE TABLE Nurse_Surgery (
    NurseID  VARCHAR(10),
    SurgeryID  VARCHAR(10),
    Date DATE,
    PRIMARY KEY (NurseID, SurgeryID),
    FOREIGN KEY (NurseID) REFERENCES Nurse(NurseID),
    FOREIGN KEY (SurgeryID) REFERENCES Surgery(SurgeryID)
);
DESCRIBE Nurse_Surgery;

-- RELATIONSHIP: SURGEON PERFORMS SURGERY (M:N)
CREATE TABLE Surgeon_Surgery (
    SurgeonID  VARCHAR(10),
    SurgeryID  VARCHAR(10),
    Date DATE,
    Time TIME,
    PRIMARY KEY (SurgeonID, SurgeryID),
    FOREIGN KEY (SurgeonID) REFERENCES Surgeon(SurgeonID),
    FOREIGN KEY (SurgeryID) REFERENCES Surgery(SurgeryID)
);
DESCRIBE Surgeon_Surgery;

-- RELATIONSHIP: DOCTOR TREATS PATIENT (M:N)
CREATE TABLE Doctor_Patient (
    DoctorID  VARCHAR(10),
    PatientID  VARCHAR(10),
    PRIMARY KEY (DoctorID, PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
DESCRIBE Doctor_Patient;

-- RELATIONSHIP: DOCTOR MONITORS HEAD DOCTOR (M:1)
CREATE TABLE Doctor_HeadDoctor (
    DoctorID  VARCHAR(10) PRIMARY KEY,
    HDNumber  VARCHAR(10),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (HDNumber) REFERENCES Head_Doctor(HDNumber)
);
DESCRIBE Doctor_HeadDoctor;

-- RELATIONSHIP: PATIENT TAKES MEDICATION (M:N)
CREATE TABLE Patient_Medication (
    PatientID  VARCHAR(10),
    MedicationCode  VARCHAR(10),
    PRIMARY KEY (PatientID, MedicationCode),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (MedicationCode) REFERENCES Medication(MedicationCode)
);
DESCRIBE Patient_Medication;

-- RELATIONSHIP: PATIENT ASSIGNED LOCATION (1:N)
CREATE TABLE Patient_Location (
    PatientID  VARCHAR(10) PRIMARY KEY,
    LocationID  VARCHAR(10),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
DESCRIBE Patient_Location ;

-- STAFF
INSERT INTO Staff VALUES
('S1','Anu','Female','Colombo','0771111111','Nurse'),
('S2','Perera','Male','Kandy','0772222222','Doctor'),
('S3','Silva','Male','Galle','0773333333','Surgeon'),
('S4','Fernando','Female','Panadura','0774444444','Nurse'),
('S5','Kavin','Male','Mathara','0775555555','Doctor'),
('S6','Malshi','Female','Piliyandala','0776666666','Surgeon'),
('S7','Nirwan','Male','Kaluthara','0777777777','Doctor');
SELECT * FROM Staff;

-- NURSE
INSERT INTO Nurse VALUES 
('S1','Grade A',5,'General',55000.00),
('S4','Grade B',4,'Normal',50000.00);
SELECT * FROM Nurse;

-- DOCTOR
INSERT INTO Doctor VALUES 
('S2','Cardiology',120000.00),
('S5','Therapy',120900.00),
('S7','Neurology',130000.00);
SELECT * FROM Doctor;

-- SURGEON
INSERT INTO Surgeon VALUES 
('S3','Orthopedic','Annual',12),
('S6','Neurosurgeon','Monthly',1);
SELECT * FROM Surgeon;

-- HEAD DOCTOR
INSERT INTO Head_Doctor VALUES 
('HD1','Dr. Fernando','Neurology'),
('HD2','Dr. Naveen','Cardiologist'),
('HD3','Dr. Sameera','Psychiatrist');
SELECT * FROM Head_Doctor;

-- PATIENT
INSERT INTO Patient VALUES
('P1','Kamal','Perera',45,'Colombo 7','A+','0711111111'),
('P2','Nimali','Silva',32,'Kandy','O+','0777777777'),
('P3','Kasun','Jayantha',39,'Galle','O+','0777754565'),
('P4','Nimali','Wijesinghe',22,'Panadura','B-','0777453789'),
('P5','Nimali','Karunarathna',34,'Mathara','B+','0777894321'),
('P6','Saman','Kumara',34,'Maharagama','A-','0777894456');
SELECT * FROM Patient;

-- LOCATION
INSERT INTO Location VALUES
('L1',12,3,'Ward-A'),
('L2',20,5,'Ward-B'),
('L3',26,4,'Ward-C');
SELECT * FROM Location;

INSERT INTO Patient_Location VALUES
('P1','L1'),
('P2','L2'),
('P3','L3'),
('P4','L1'),
('P5','L2'),
('P6','L3');
SELECT * FROM Patient_Location;

-- ALLERGY
INSERT INTO Allergy VALUES
('A1','Dust','Environmental'),
('A2','Penicillin','Medical');
SELECT * FROM Allergy;

INSERT INTO Patient_Allergy VALUES
('P1','A1'),
('P2','A2'),
('P3','A2'),
('P4','A1'),
('P5','A1');
SELECT * FROM Patient_Allergy;

-- MEDICATION
INSERT INTO Medication VALUES
('M1','Amoxicillin',50,10,'2026-01-01',250.00),
('M2','Paracetamol',200,30,'2025-09-01',200.00),
('M3','Aspirin',20,300,'2027-09-05',120.00),
('M4','Celecoxib',100,80,'2026-04-19',60.00),
('M5','Metronidazole',120,300,'2026-12-11',320.00);
SELECT * FROM Medication;

-- MEDICATION INTERACTION
INSERT INTO MedicationInteraction VALUES
('MI1','M1','M2','High'),
('MI2','M3','M2','High'),
('MI3','M4','M5','Low'),
('MI4','M3','M1','Medium');
SELECT * FROM MedicationInteraction;

INSERT INTO Medication_MedicationInteracts VALUES
('M1','MI1'),
('M2','MI1'),
('M3','MI2'),
('M3','MI4'),
('M4','MI3'),
('M5','MI3');
SELECT * FROM Medication_MedicationInteracts;

INSERT INTO Patient_Medication VALUES
('P1','M1'),
('P2','M2'),
('P3','M3'),
('P4','M4'),
('P5','M2'),
('P6','M5');
SELECT * FROM Patient_Medication;

-- THEATRE
INSERT INTO Theatre VALUES
('T1','Main Theatre','Building A'),
('T2','Theatre B','Building A'),
('T3','Theatre C','Building B');
SELECT * FROM Theatre;

-- SURGERY
INSERT INTO Surgery VALUES
('SUg1','Heart Surgery','Critical','Ventilator Required','T1'),
('SUg2','Eye Surgery','Normal','Treat cataracts','T2'),
('SUg3','Cancer Surgery','Normal','Reduce pain','T1'),
('SUg4','Leg Surgery','Critical','Fix broken bones','T3');
SELECT * FROM Surgery;

INSERT INTO Surgery_Patient VALUES 
('SUg1','P1'),
('SUg2','P2'),
('SUg3','P3'),
('SUg4','P4');
SELECT * FROM Surgery_Patient;

INSERT INTO Nurse_Surgery VALUES 
('S1','SUg1','2025-12-20'),
('S1','SUg2','2025-12-22'),
('S4','SUg4','2025-12-25');
SELECT * FROM Nurse_Surgery;

INSERT INTO Surgeon_Surgery VALUES 
('S3','SUg1','2025-05-20','09:30:00'),
('S6','SUg2','2025-05-22','10:30:00'),
('S3','SUg4','2025-05-25','11:30:00');
SELECT * FROM Surgeon_Surgery;

INSERT INTO Doctor_Patient VALUES 
('S2','P1'),
('S5','P2'),
('S5','P3'),
('S7','P4'),
('S2','P5'),
('S2','P6');
SELECT * FROM Doctor_Patient;

INSERT INTO Doctor_HeadDoctor VALUES 
('S2','HD1'),
('S5','HD2'),
('S7','HD3');
SELECT * FROM Doctor_HeadDoctor;

