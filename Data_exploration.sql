--Create a table totalling all crime types for each neighbourhood, ordered by violent_theft
SELECT neighbourhood,
coalesce(Theft_violent,0) AS Theft_violent,
coalesce(Theft_non_violent,0) AS Theft_non_violent,
coalesce(Injuries,0) AS Injuries,
coalesce(Homicide,0) AS Homicide
FROM crosstab
('select neighbourhood, crime_type, count(1) 
from crime_data
JOIN ON
WHERE neighbourhood IS NOT NULL 
group by neighbourhood, crime_type
order by neighbourhood, crime_type',
'values (''Theft_violent''),(''Theft_non_violent''),(''Injuries''),(''Homicide'')')              
AS result(neighbourhood varchar, Theft_violent bigint, Theft_non_violent bigint, Injuries bigint, Homicide bigint)
ORDER BY Theft_violent DESC, Theft_non_violent DESC, Injuries DESC, Homicide DESC
 

--Identify the neighbourhood with maximum homicides 
SELECT neighbourhood, crime_type, COUNT(*) AS min_count
FROM crime_data
WHERE crime_type = 'Homicide'
GROUP BY neighbourhood, crime_type
ORDER BY min_count ASC
LIMIT 1
 
--Identify the neighbourhood with minimum homicides 
SELECT neighbourhood, crime_type, COUNT(*) AS max_count
FROM crime_data
WHERE crime_type = 'Homicide'
GROUP BY neighbourhood, crime_type
ORDER BY max_count DESC
LIMIT 1


--Identify changes in crime types by year
SELECT crime_year,
coalesce(Theft_violent,0) AS Theft_violent,
coalesce(Theft_non_violent,0) AS Theft_non_violent,
coalesce(Injuries,0) AS Injuries,
coalesce(Homicide,0) AS Homicide
FROM crosstab
('select crime_year, crime_type, count(1) 
from crime_data
group by crime_year, crime_type
order by crime_year, crime_type',
'values (''Theft_violent''),(''Theft_non_violent''),(''Injuries''),(''Homicide'')')              
AS result(crime_year int, Theft_violent bigint, Theft_non_violent bigint, Injuries bigint, Homicide bigint)
ORDER BY crime_year DESC

 

--Identify changes in crime types by month
SELECT crime_month,
coalesce(Theft_violent,0) AS Theft_violent,
coalesce(Theft_non_violent,0) AS Theft_non_violent,
coalesce(Injuries,0) AS Injuries,
coalesce(Homicide,0) AS Homicide
FROM crosstab
('select crime_month, crime_type, count(1) 
from crime_data 
group by crime_month, crime_type
order by crime_month, crime_type',
'values (''Theft_violent''),(''Theft_non_violent''),(''Injuries''),(''Homicide'')')              
AS result(crime_month varchar, Theft_violent bigint, Theft_non_violent bigint, Injuries bigint, Homicide bigint)
ORDER BY to_date(crime_month,'Month');

 

--Identify changes in crime types by day of week
SELECT day_of_week,
coalesce(Theft_violent,0) AS Theft_violent,
coalesce(Theft_non_violent,0) AS Theft_non_violent,
coalesce(Injuries,0) AS Injuries,
coalesce(Homicide,0) AS Homicide
FROM crosstab
('select day_of_week, crime_type, count(1) 
from crime_data 
group by day_of_week, crime_type
order by day_of_week, crime_type',
'values (''Theft_violent''),(''Theft_non_violent''),(''Injuries''),(''Homicide'')')              
AS result(day_of_week varchar, Theft_violent bigint, Theft_non_violent bigint, Injuries bigint, Homicide bigint)
ORDER BY theft_violent DESC


--Identify changes in crime types by hour of day
SELECT hour_of_day,
coalesce(Theft_violent,0) AS Theft_violent,
coalesce(Theft_non_violent,0) AS Theft_non_violent,
coalesce(Injuries,0) AS Injuries,
coalesce(Homicide,0) AS Homicide
FROM crosstab
('select hour_of_day, crime_type, count(1) 
from crime_data 
group by hour_of_day, crime_type
order by hour_of_day, crime_type',
'values (''Theft_violent''),(''Theft_non_violent''),(''Injuries''),(''Homicide'')')              
AS result(hour_of_day int, Theft_violent bigint, Theft_non_violent bigint, Injuries bigint, Homicide bigint)
ORDER BY hour_of_day ASC


--Create neighbourhood info table to explore connections
CREATE TABLE neighbourhood_info
(
    neighbourhood character varying(100),
    population integer,
    area numeric
);


--Looking at violent thefts per square km
WITH t1 AS 
(SELECT crime_data.neighbourhood, area, COUNT(1) AS violent_thefts
FROM crime_data
JOIN neighbourhood_info
ON crime_data.neighbourhood = neighbourhood_info.neighbourhood 
WHERE crime_data.neighbourhood IS NOT NULL AND crime_type = 'Theft_violent'
GROUP BY crime_data.neighbourhood, area 
ORDER BY crime_data.neighbourhood
)
SELECT neighbourhood, round(violent_thefts / area) AS violent_thefts_per_km_squared FROM t1
ORDER BY violent_thefts_per_km_squared DESC

 
--Looking at homicides per square km
WITH t1 AS 
(SELECT crime_data.neighbourhood, area, COUNT(1) AS homicides
FROM crime_data
JOIN neighbourhood_info
ON crime_data.neighbourhood = neighbourhood_info.neighbourhood 
WHERE crime_data.neighbourhood IS NOT NULL AND crime_type = 'Homicide'
GROUP BY crime_data.neighbourhood, area 
ORDER BY crime_data.neighbourhood
)
SELECT neighbourhood, round(homicides / area) AS homicides_per_km_squared FROM t1
ORDER BY homicides_per_km_squared DESC

 

