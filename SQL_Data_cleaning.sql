-- Replace spanish months with the english equivalent
--Enero > January
--Febrero > February
--Marzo > March
--Abril > April
--Mayo > May
--Junio > June
--Julio > July
--Agosto > August
--Septiembre > September
--Octubre > October
--Noviembre > November
--Diciembre > December

UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Enero','January');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Febrero','February');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Marzo','March');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Abril','April');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Mayo','May');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Junio','June');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Julio','July');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Agosto','August');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Septiembre','September');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Octubre','October');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Noviembre','November');
UPDATE crime_data
SET crime_month = REPLACE(crime_month,'Diciembre','December');


-- Replace spanish days with the english equivalent (including lower case equivalents)
Lunes > Monday
Martes > Tuesday
Miércoles > Wednesday
Jueves > Thursday
Viernes > Friday
Sábado > Saturday
Domingo > Sunday

UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Lunes','Monday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'lunes','Monday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Martes','Tuesday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'martes','Tuesday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Miércoles','Wednesday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'miércoles','Wednesday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Jueves','Thursday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'jueves','Thursday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Viernes','Friday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'viernes','Friday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Sábado','Saturday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'sábado','Saturday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'Domingo','Sunday');
UPDATE crime_data
SET day_of_week = REPLACE(day_of_week,'domingo','Sunday');


--Fix Sd (sin data) (without data) times to Null

UPDATE crime_data
SET hour_of_day = REPLACE(hour_of_day,'S/D','');
UPDATE crime_data
SET hour_of_day = REPLACE(hour_of_day,'sd','');
UPDATE crime_data
SET hour_of_day = REPLACE(hour_of_day,'SD','');


-- Delete null time_data 
DELETE FROM crime_data
WHERE hour_of_day NOT IN ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23');


---- Replace spanish crime types with the english equivalent
Lesiones > Injuries
Homicidio > Homicide
Hurto (sin violencia) > Theft (without violence)
Robo (con violencia) > Theft (with violence)

UPDATE crime_data
SET crime_type = REPLACE(crime_type,'Lesiones','Injuries');
UPDATE crime_data
SET crime_type = REPLACE(crime_type,'Homicidio','Homicide');
UPDATE crime_data
SET crime_type = REPLACE(crime_type,'Hurto (sin violencia)', 'Theft_non_violent');
UPDATE crime_data
SET crime_type = REPLACE(crime_type,'Robo (con violencia)','Theft_violent');


--Fix sub_type where was null for 2019
UPDATE crime_data
SET crime_subtype = 'Siniestro Vial'
WHERE crime_type = 'Injuries';


--Remove nulls from sub category
UPDATE crime_data
SET crime_subtype = 'Generic theft (with violence)'
WHERE crime_type = 'Theft (with violence)' AND crime_subtype IS NULL
UPDATE crime_data
SET crime_subtype = 'Generic theft (without violence)'
WHERE crime_type = 'Theft (without violence)' AND crime_subtype is NULL


--Change crime_type language

UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Siniestro Vial','Sinister road homicide')
WHERE crime_type = 'Homicide';
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Siniestro Vial','Sinister road injury')
WHERE crime_type = 'Injuries';
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Doloso','Intentional homicide');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Femicidio','Femicide');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Femicidio Intrafamiliar','Femicide (inside family)');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Travesticidio/Transfemicidio','Transfemicide/Transvesticide');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Con uso de moto','Theft using motorbike');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Robo Automotor','Auto theft (with violence)');
UPDATE crime_data
SET crime_subtype = REPLACE(crime_subtype,'Hurto Automotor','Auto theft (without violence)');


-- Fix neighbourhoods with duplications and typos

UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'Boca','La Boca');
UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'Paternal','La Paternal');
UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'Monserrat','Montserrat');
UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'Nueva pompeya','Nueva Pompeya');
UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'Villa del Parque','Villa Del Parque');

UPDATE crime_data
SET neighbourhood = REPLACE(neighbourhood,'La La Boca','La Boca');


-- Check for duplicates (22 duplicate crime_ids were found, but upon investigation 
  -- 21 of these were for different crimes, so they can remain. The crime_ids were not changed.)

SELECT CRIME_ID, COUNT(*)
FROM crime_data
GROUP BY CRIME_ID
HAVING COUNT(*) > 1


-- Duplicate rows with crime_id  RH-2021-1002368 were removed and readded once:
DELETE FROM crime_data
WHERE crime_id = 'RH-2021-1002368'

INSERT INTO crime_data (crime_id, crime_year, crime_month, day_of_week, crime_date, hour_of_day, crime_type, crime_subtype, neighbourhood, commune, latitude, longitude)
VALUES ('RH-2021-1002368', '2021', 'December', 'Tuesday', '28/12/2021', '12', 'Theft (with violence)', 'Generic theft (with violence)', 'Villa Riachuelo', '8', '-34.68689', '-58.477151');


-- Change data type for hour_of_day and commune to integer
ALTER TABLE crime_data ALTER COLUMN hour_of_day  TYPE integer USING (hour_of_day::integer);


-- EXPORT AS cleaned_data

