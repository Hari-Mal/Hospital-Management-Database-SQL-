# Hospital-Management-Database-SQL-

This project involves designing and implementing a relational database for a hospital management system named SuwapiyasaDB. Developed using MySQL, the schema captures the core entities and relationships of a healthcare environment, including staff management (doctors, nurses, surgeons), patient records, medical treatments, surgeries, medications, and allergies.

Key features include:

Staff specialization hierarchy with superclass/subclass tables (Staff, Nurse, Doctor, Surgeon) using foreign key inheritance.

Many-to-many relationships such as Doctor_Patient, Patient_Allergy, Patient_Medication, and Nurse_Surgery, managed via junction tables.

Referential integrity through primary keys, foreign keys, and check constraints (e.g., age, salary, experience).

Complex queries (provided in Relations.sql) demonstrating joins across multiple tables to extract meaningful insights, such as doctor assignments, patient allergies, medication interactions, and surgery schedules.

This project showcases proficiency in database design, normalization, SQL scripting, and the ability to model real-world scenarios with proper constraints and relationships—ideal for applications in healthcare information systems.
