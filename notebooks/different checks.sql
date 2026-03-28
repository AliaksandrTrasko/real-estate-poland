-- Не "анализ по типу", а "любопытный факт"
SELECT type, 
       ROUND(AVG(build_year)) AS avg_build_year,
       COUNT(*) AS count
FROM apartments
GROUP BY type
ORDER BY avg_build_year;

-- проверка "заглушка" ли 1850 год
SELECT build_year, COUNT(*) 
FROM apartments 
WHERE build_year < 1900
GROUP BY build_year
ORDER BY COUNT(*) DESC;

select build_year
from apartments
where build_year is NOT null
order BY build_year asc;

SELECT floor, COUNT(*) 
FROM apartments
GROUP BY floor
ORDER BY floor;

-- Портрет типичной арендной квартиры vs продажной по городу
SELECT 
    city,
    offer_type,
    ROUND(AVG(square_meters), 0) AS avg_sqm,
    ROUND(AVG(rooms), 1) AS avg_rooms,
    ROUND(AVG(floor), 1) AS avg_floor,
    COUNT(*) AS count
FROM apartments
GROUP BY city, offer_type
ORDER BY city, offer_type, count DESC;


-- Цена за метр у разных типов постройки
SELECT type, AVG(price/square_meters) AS price_per_sqm
FROM apartments
WHERE offer_type = 'sale'
GROUP BY type;
-- Результаты: Apartment Building: 16810.17, Block of Flats: 12465.15, Tenement: 13256.22, Unknown: 13581.82