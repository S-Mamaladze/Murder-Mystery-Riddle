-- Step 1: Analyzing the Crime Scene 
-- The starting point of the investigation. #

SELECT *
FROM crime_scene_report
WHERE type = 'murder'
AND city = 'SQL city'
AND date = '20180115';

-- Step 2: Finding Witnesses #
-- Witness 1: Lives in the last house on "Northwestern Dr".
-- Witness 2: Named Annabel, lives on "Franklin Ave".

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC; -- Morty Schapiro

SELECT * FROM person
WHERE address_street_name = 'Franklin Ave'
AND name LIKE '%Annabel%'; -- Annabel Miller

-- Step 3: Interviewing Witnesses
-- Extracting clues about the killer: Gold gym member, plate contains "H42W".

SELECT * FROM interview WHERE person_id = 14887;
SELECT * FROM interview WHERE person_id = 16371;

-- Step 4: Identifying the Killer
-- ross-referencing Gym and Driver's License data.

SELECT p.name, gfm.id as member_id, dl.plate_number
FROM person p
JOIN get_fit_now_member gfm ON p.id = gfm.person_id
JOIN drivers_license dl ON p.license_id = dl.id
WHERE gfm.membership_status = 'gold'
AND gfm.id LIKE '48Z%'
AND dl.plate_number LIKE '%H42W%'; -- Jeremy Bowers

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
HAVING COUNT() = 3; -- Miranda Priestly
