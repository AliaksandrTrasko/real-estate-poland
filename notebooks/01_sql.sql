SELECT *
FROM apartments a
LIMIT 10;

-- ROI - Return on Investment BY CITY DONE
WITH sale AS (
    SELECT city,
           AVG(price) AS avg_sale_price
    FROM apartments
    WHERE offer_type = 'sale'
    GROUP BY city
),
rent AS (
    SELECT city,
           AVG(price) AS avg_rent_price
    FROM apartments
    WHERE offer_type = 'rent'
    GROUP BY city
)
SELECT 
    s.city,
    ROUND(s.avg_sale_price, 2) AS avg_sale_price,
    ROUND(r.avg_rent_price, 2) AS avg_rent_per_month,
    ROUND((r.avg_rent_price * 12 / s.avg_sale_price * 100), 2) AS roi_percent,
    ROUND((s.avg_sale_price / (r.avg_rent_price * 12)), 1) AS payback_years
FROM sale AS s
JOIN rent AS r 
USING(city)
ORDER BY roi_percent DESC;

-- ROI - Return on Investment BY BUILDING TYPE (Что окупается быстрее через сдачу в аренду) DONE
WITH sale AS (
    SELECT type,
           AVG(price) AS avg_sale_price
    FROM apartments
    WHERE offer_type = 'sale'
    AND type != 'Unknown'
    GROUP BY type
),
rent AS (
    SELECT type,
           AVG(price) AS avg_rent_price
    FROM apartments
    WHERE offer_type = 'rent'
    AND type != 'Unknown'
    GROUP BY type
)
SELECT 
    s.type,
    ROUND(s.avg_sale_price, 0)  AS avg_sale_price,
    ROUND(r.avg_rent_price, 0)  AS avg_rent_per_month,
    ROUND((r.avg_rent_price * 12 / s.avg_sale_price * 100), 2) AS roi_percent,
    ROUND((s.avg_sale_price / (r.avg_rent_price * 12)), 1) AS payback_years
FROM sale AS s
JOIN rent AS r
USING(type)
ORDER BY roi_percent DESC;


--------------------------------------------------------------------------------------------------

 
-- The impact of location on the price per square meter - SALE DONE
SELECT
    CASE
        WHEN centre_distance < 2  THEN '2km or less'
        WHEN centre_distance < 5  THEN '2-5 km'
        WHEN centre_distance < 10 THEN '5-10 km'
        ELSE '10km or more'
    END AS distance,
    COUNT(*)                                          AS listings,
    ROUND(AVG(price / square_meters), 0)     AS avg_price_per_sqm,
    ROUND(MIN(price / square_meters), 0)     AS min_price_per_sqm,
    ROUND(MAX(price / square_meters), 0)     AS max_price_per_sqm
FROM apartments
WHERE offer_type = 'sale'
  AND square_meters > 0
GROUP BY distance
ORDER BY distance;
 
-- The impact of location on the price per square meter - RENT DONE
SELECT
    CASE
        WHEN centre_distance < 2  THEN '2km or less'
        WHEN centre_distance < 5  THEN '2-5 km'
        WHEN centre_distance < 10 THEN '5-10 km'
        ELSE '10km or more'
    END AS distance,
    COUNT(*) AS listings,
    ROUND(AVG(price), 2) AS avg_rent,
    ROUND(AVG(price / square_meters), 2) AS avg_rent_per_sqm
FROM apartments
WHERE offer_type = 'rent'
  AND square_meters > 0
GROUP BY distance
ORDER BY distance;




-- Топ-10 самых дорогих в каждом городе: DONE

WITH ranked AS (
    SELECT city, type, square_meters, build_year, price,
    ROUND(price/square_meters) AS price_per_sqm,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY price DESC) as row_num,
    date_month
    FROM apartments
    WHERE offer_type = 'sale'
    AND square_meters > 10
)
SELECT * 
FROM ranked
WHERE row_num <= 10
ORDER BY city, row_num;

-- Average age per building type
SELECT type, ROUND(AVG(build_year), 2) as year_build
FROM apartments
WHERE build_year IS NOT NULL
AND type != 'Unknown'
GROUP BY type;


-- Difference between premium and basic apartments prices DONE
WITH premium AS (
    SELECT AVG(price/square_meters) AS price_per_sqm
    FROM apartments
    WHERE offer_type = 'sale'
      AND has_parking_space = 'yes'
      AND has_balcony = 'yes'
),
basic AS (
    SELECT AVG(price/square_meters) AS price_per_sqm
    FROM apartments
    WHERE offer_type = 'sale'
      AND has_parking_space = 'no'
      AND has_balcony = 'no'
)
SELECT
    ROUND(premium.price_per_sqm, 2) AS premium_sqm,
    ROUND(basic.price_per_sqm, 2)   AS basic_sqm
FROM premium
CROSS JOIN basic;


SELECT *
FROM apartments
WHERE type = 'Tenement'
AND build_year IS NOT NULL
ORDER BY build_year DESC
LIMIT 25;

-- Как менялась цена по месяцам
SELECT
    date_month,
    offer_type,
    ROUND(AVG(price), 0) AS avg_price,
    ROUND(AVG(price / square_meters), 0) AS avg_price_per_sqm,
    COUNT(*) AS listings
FROM apartments
WHERE square_meters > 0
GROUP BY date_month, offer_type
ORDER BY date_month, offer_type;
