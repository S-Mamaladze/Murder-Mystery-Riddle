# Technical Report: SQL Implementation & Challenges

## 1. Data Schema & Types

During the migration to SQL Server (SSMS), I encountered several data integrity challenges:

ID Overflow: The person_id and ssn fields required BIGINT or INT rather than SMALLINT to prevent overflow errors during the INSERT process.

String Truncation: Street names and event names were imported as NVARCHAR(MAX) to ensure no descriptive data was lost during the transition from the CSV source.

## 2. Query Optimization

While the investigation was performed sequentially, the final production query was optimized using Common Table Expressions (CTEs).

Why CTEs?

Readability: Logic is separated into "Clues" and "Results," making it easier for other analysts to audit.

Maintainability: If the gym database schema changes, only the Hitman_Clues block needs updating.

## 3. Environment Details

Database Engine: Microsoft SQL Server 2022

Interface: SQL Server Management Studio (SSMS) 21

Source Data: SQLite converted to CSV via Google Sheets
