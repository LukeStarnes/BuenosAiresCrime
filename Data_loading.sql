--Create SQL Tables and Import data for each year

CREATE TABLE data_2021
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2021
    OWNER to postgres;

CREATE TABLE data_2020
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2020
    OWNER to postgres;

CREATE TABLE data_2019
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2019
    OWNER to postgres;

CREATE TABLE data_2018
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2018
    OWNER to postgres;

CREATE TABLE data_2017
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2017
    OWNER to postgres;

CREATE TABLE data_2016
(
    crime_id character varying(100),
    crime_year character varying(100),
    crime_month character varying(100),
    day_of_week character varying(100),
    crime_date date,
    hour_of_day character varying(100),
    crime_type character varying(100),
    crime_subtype character varying(100),
    neighbourhood character varying(100),
    commune character varying(100),
    latitude numeric,
    longitude numeric
);

ALTER TABLE IF EXISTS data_2016
    OWNER to postgres;

--Import data and union tables into one

CREATE table crime_data as
Select *
from data_2016
union all
Select *
from data_2017
union all
Select *
from data_2018
union all
Select *
from data_2019
union all
Select *
from data_2020
union all
Select *
from data_2021

--Check data imported ok
select crime_year, count(*) as incidents
from crime_data
group by crime_year
order by crime_year
