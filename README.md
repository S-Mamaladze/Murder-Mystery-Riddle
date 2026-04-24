# SQL Murder Mystery: A Digital Forensic Investigation 
## 🕵️‍♂️ Investigating Crime Data with SQL Server (SSMS)
## Project Overview
This project is a technical walkthrough of the "SQL Murder Mystery." Using Microsoft SQL Server Management Studio (SSMS), I acted as a data detective to identify a murderer and the mastermind behind the crime. The project demonstrates the ability to navigate complex relational databases, handle data type constraints, and write high-level analytical queries.

## 💡 Why I Built This
While many beginners solve the SQL Murder Mystery using the provided web terminal, I chose to treat this as a professional database migration and analysis exercise.

I built this project to demonstrate:

End-to-End Ownership: Moving beyond simple querying to handle the full lifecycle—from data ingestion and schema troubleshooting to final reporting.

Technical Adaptability: Proving I can work within a professional-grade environment like Microsoft SQL Server (SSMS), which requires stricter data typing and more rigorous error handling than basic SQLite environments.

Production-Ready Logic: Moving from exploratory "one-off" queries to refactored, modular code using CTEs, showcasing a mindset focused on code maintainability and readability for a BI team.

# Technical Skills Demonstrated
Data Migration & Wrangling: Migrated data from SQLite/CSV into SQL Server via Google Sheets.

Database Troubleshooting: Resolved smallint overflow errors and nvarchar truncation issues during the import process.

Relational Logic: Utilized JOIN, WHERE, and LIKE operators to connect disparate tables (Gym, Drivers License, Facebook Events, Income).

Advanced SQL Architecture: Implemented Common Table Expressions (CTEs) and Subqueries to consolidate multiple investigation steps into a single production-ready script.

# The Investigation Trail
The Crime Scene: Analyzed crime_scene_report to identify witnesses.

Witness Testimony: Queried the interview table to gather clues about the suspect (Gym membership, car plate, physical appearance).

The Hitman: Cross-referenced get_fit_now_member with drivers_license to identify Jeremy Bowers.

The Mastermind: Analyzed the hitman's interview and queried the facebook_event_checkin and income tables to identify the employer, Miranda Priestly.

# Key Code Sample (The Optimized Solution)

### Final Solution Query
Check out the optimized query I wrote to solve the case in one go:

```sql
WITH Hitman_Clues AS (
    SELECT p.id, p.name
    FROM person p
    JOIN get_fit_now_member gfm ON p.id = gfm.person_id
    JOIN drivers_license dl ON p.license_id = dl.id
    WHERE gfm.membership_status = 'gold'
      AND gfm.id LIKE '48Z%'
      AND dl.plate_number LIKE '%H42W%'
),
Mastermind AS (
    SELECT p.name, i.annual_income
    FROM person p
    JOIN drivers_license dl ON p.license_id = dl.id
    JOIN facebook_event_checkin fec ON p.id = fec.person_id
    JOIN income i ON p.ssn = i.ssn
    WHERE dl.hair_color = 'red'
      AND dl.car_make = 'Tesla'
      AND fec.event_name = 'SQL Symphony Concert'
    GROUP BY p.name, i.annual_income
    HAVING COUNT(*) = 3
)
SELECT * FROM Mastermind;
