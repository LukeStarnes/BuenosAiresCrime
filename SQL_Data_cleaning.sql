-- Replace spanish months with the english equivalent
--Enero>January
--Febrero>February
--Marzo>March
--Abril>April
--Mayo>May
--Junio>June
--Julio>July
--Agosto>August
--Septiembre>September
--Octubre>October
--Noviembre>November
--Diciembre>December

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
Lunes>Monday
Martes>Tuesday
Miércoles>Wednesday
Jueves>Thursday
Viernes>Friday
Sábado>Saturday
Domingo>Sunday

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
