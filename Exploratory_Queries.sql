-- Step 1: Analyzing the Crime Scene 
-- The starting point of the investigation.

SELECT *
FROM crime_scene_report
WHERE type = 'murder'
  AND city = 'SQL city'
  AND date = '20180115';

-- Step 2: Finding Witnesses 
-- Witness 1: Lives in the last house on "Northwestern Dr".
-- Witness 2: Named Annabel, lives on "Franklin Ave".

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC; -- Result: Morty Schapiro

SELECT * FROM person
WHERE address_street_name = 'Franklin Ave'
  AND name LIKE '%Annabel%'; -- Result: Annabel Miller

-- Step 5: The Mastermind
-- Tracing back based on Jeremy's confession.

SELECT p.name, i.annual_income, dl.car_make, dl.car_model
FROM person p
JOIN drivers_license dl ON p.license_id = dl.id
JOIN facebook_event_checkin fec ON p.id = fec.person_id
JOIN income i ON p.ssn = i.ssn
WHERE dl.hair_color = 'red'
  AND dl.car_make = 'Tesla'
  AND dl.car_model = 'Model S'
  AND fec.event_name = 'SQL Symphony Concert'
GROUP BY p.name, i.annual_income, dl.car_make, dl.car_model
HAVING COUNT(*) = 3; -- Result: Miranda Priestly
