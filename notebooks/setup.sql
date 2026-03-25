CREATE DATABASE real_estate;

-- 1. Удаляем старую кривую таблицу
DROP TABLE IF EXISTS apartments;

-- 2. Создаем новую, где этажи и комнаты - это NUMERIC
CREATE TABLE apartments (
    id VARCHAR(50),
    city VARCHAR(50),
    type VARCHAR(50),
    squareMeters NUMERIC,
    rooms NUMERIC,        -- Поменяли с INT на NUMERIC
    floor NUMERIC,        -- Поменяли с INT на NUMERIC
    floorCount NUMERIC,   -- Поменяли с INT на NUMERIC
    buildYear NUMERIC,    -- Поменяли с INT на NUMERIC
    latitude NUMERIC,
    longitude NUMERIC,
    centreDistance NUMERIC,
    poiCount NUMERIC,
    schoolDistance NUMERIC,
    clinicDistance NUMERIC,
    postOfficeDistance NUMERIC,
    kindergartenDistance NUMERIC,
    restaurantDistance NUMERIC,
    collegeDistance NUMERIC,
    pharmacyDistance NUMERIC,
    ownership VARCHAR(50),
    buildingMaterial VARCHAR(50),
    condition VARCHAR(50),
    hasParkingSpace VARCHAR(10),
    hasBalcony VARCHAR(10),
    hasElevator VARCHAR(10),
    hasSecurity VARCHAR(10),
    hasStorageRoom VARCHAR(10),
    price NUMERIC,
    offer_type VARCHAR(10),
    date_month DATE
);

-- Сначала очистим таблицу от возможных остатков
TRUNCATE TABLE apartments; 

-- Загружаем правильный файл!
COPY apartments
FROM 'D:/Lern ht code/real_estate poland/data/processed/apartments_clean_final.csv'
DELIMITER ','
CSV HEADER;