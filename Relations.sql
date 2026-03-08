-- 1 Show all nurses with their staff details
SELECT s.EmployeeID, s.EmployeeName, n.Grade, n.MonthlySalary
FROM Staff s
JOIN Nurse n ON s.EmployeeID = n.NurseID;

-- 2 Show all doctors with their staff details
SELECT s.EmployeeID, s.EmployeeName, d.Speciality, d.MonthlySalary
FROM Staff s
JOIN Doctor d ON s.EmployeeID = d.DoctorID;

-- 3 Show all surgeons with their staff details
SELECT s.EmployeeID, s.EmployeeName, sg.Speciality, sg.ContractType
FROM Staff s
JOIN Surgeon sg ON s.EmployeeID = sg.SurgeonID;

-- 4 Doctor Treats Patient (M:N)
SELECT d.DoctorID, s.EmployeeName AS DoctorName, p.PatientID, p.LastName
FROM Doctor_Patient dp
JOIN Doctor d ON dp.DoctorID = d.DoctorID
JOIN Staff s ON d.DoctorID = s.EmployeeID
JOIN Patient p ON dp.PatientID = p.PatientID;

-- 5 Patient Has Allergy (M:N)
SELECT p.PatientID, p.LastName, a.AllergyName
FROM Patient_Allergy pa
JOIN Patient p ON pa.PatientID = p.PatientID
JOIN Allergy a ON pa.AllergyID = a.AllergyID;

-- 6 Patient Takes Medication (M:N)
SELECT p.PatientID, p.LastName, m.MedicationName
FROM Patient_Medication pm
JOIN Patient p ON pm.PatientID = p.PatientID
JOIN Medication m ON pm.MedicationCode = m.MedicationCode;

-- 7 Medication Interacts With Medication (M:N)
SELECT m.MedicationName AS MainMedication,
       mi.Severity,
       m2.MedicationName AS InteractingMedication
FROM Medication_MedicationInteracts mm
JOIN MedicationInteraction mi ON mm.InteractionID = mi.InteractionID
JOIN Medication m ON mm.MedicationCode = m.MedicationCode
JOIN Medication m2 ON mi.InteractionMedicationCode2 = m2.MedicationCode;

-- 8 Patient Assigned to Location (1:N)
SELECT p.PatientID, p.LastName, l.LocationID, l.RoomNumber
FROM Patient_Location pl
JOIN Patient p ON pl.PatientID = p.PatientID
JOIN Location l ON pl.LocationID = l.LocationID;

-- 9 Surgery Needs Patient (M:1)
SELECT srg.SurgeryID, srg.SurgeryName, p.PatientID, p.LastName
FROM Surgery_Patient sp
JOIN Surgery srg ON sp.SurgeryID = srg.SurgeryID
JOIN Patient p ON sp.PatientID = p.PatientID;

-- 10 Surgery Occurs in Theatre (M:1)
SELECT srg.SurgeryName, t.TheatreName, t.TheatreLocation
FROM Surgery srg
JOIN Theatre t ON srg.TheatreNo = t.TheatreNo;

-- 11 Nurse Assists Surgery (M:N)
SELECT n.NurseID, s.EmployeeName AS NurseName, sg.SurgeryName, ns.Date
FROM Nurse_Surgery ns
JOIN Nurse n ON ns.NurseID = n.NurseID
JOIN Staff s ON n.NurseID = s.EmployeeID
JOIN Surgery sg ON ns.SurgeryID = sg.SurgeryID;

-- 12  Surgeon Performs Surgery (M:N)
SELECT sg.SurgeryName, s.EmployeeName AS SurgeonName, ss.Date, ss.Time
FROM Surgeon_Surgery ss
JOIN Surgeon su ON ss.SurgeonID = su.SurgeonID
JOIN Staff s ON su.SurgeonID = s.EmployeeID
JOIN Surgery sg ON ss.SurgeryID = sg.SurgeryID;

--  13. Doctor Monitors Head Doctor (M:1)
SELECT d.DoctorID, s.EmployeeName AS DoctorName, hd.HeadDoctorName
FROM Doctor_HeadDoctor dh
JOIN Doctor d ON dh.DoctorID = d.DoctorID
JOIN Staff s ON d.DoctorID = s.EmployeeID
JOIN Head_Doctor hd ON dh.HDNumber = hd.HDNumber;