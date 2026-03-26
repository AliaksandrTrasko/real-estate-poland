CREATE DATABASE real_estate;

DROP TABLE IF EXISTS apartments;

CREATE TABLE apartments (
    id VARCHAR(50),
    city VARCHAR(50),
    type VARCHAR(50),
    squareMeters NUMERIC,
    rooms NUMERIC,
    floor NUMERIC,
    floor_count NUMERIC,
    build_year NUMERIC,
    latitude NUMERIC,
    longitude NUMERIC,
    centre_distance NUMERIC,
    poi_count NUMERIC,
    school_distance NUMERIC,
    clinic_distance NUMERIC,
    post_office_distance NUMERIC,
    kindergarten_distance NUMERIC,
    restaurant_distance NUMERIC,
    college_distance NUMERIC,
    pharmacy_distance NUMERIC,
    ownership VARCHAR(50),
    building_material VARCHAR(50),
    condition VARCHAR(50),
    has_parking_space VARCHAR(10),
    has_balcony VARCHAR(10),
    has_elevator VARCHAR(10),
    has_security VARCHAR(10),
    has_storage_room VARCHAR(10),
    price NUMERIC,
    offer_type VARCHAR(10),
    date_month DATE
);

TRUNCATE TABLE apartments; 

COPY apartments
FROM 'D:/Lern ht code/real_estate poland/data/processed/apartments_clean_final.csv'
DELIMITER ','
CSV HEADER;