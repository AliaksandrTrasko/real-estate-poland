-- Difference between premium and basic apartments prices
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
    ROUND(premium.pdrice_per_sqm, 2) AS premium_sqm,
    ROUND(basic.price_per_sqm, 2) AS basic_sqm
FROM premium
CROSS JOIN basic;



-- The impact of location on the price per square meter - SALE
SELECT
    CASE
        WHEN centre_distance < 2  THEN '1. 2km or less'
        WHEN centre_distance < 5  THEN '2. 2-5 km'
        WHEN centre_distance < 10 THEN '3. 5-10 km'
        ELSE '4. 10km or more'
    END AS distance,
    COUNT(*) AS count,
    ROUND(AVG(price/square_meters), 0) AS avg_price_per_sqm,
    ROUND(MIN(price/square_meters), 0) AS min_price_per_sqm,
    ROUND(MAX(price/square_meters), 0) AS max_price_per_sqm
FROM apartments
WHERE offer_type = 'sale'
    AND square_meters > 15
GROUP BY distance
ORDER BY distance;

-- The impact of location on the price per square meter - RENT
SELECT
    CASE
        WHEN centre_distance < 2  THEN '1. 2km or less'
        WHEN centre_distance < 5  THEN '2. 2-5 km'
        WHEN centre_distance < 10 THEN '3. 5-10 km'
        ELSE '4. 10km or more'
    END AS distance,
    COUNT(*) AS count,
    ROUND(AVG(price), 2) AS avg_rent,
    ROUND(AVG(price / square_meters), 2) AS avg_rent_per_sqm
FROM apartments
WHERE offer_type = 'rent'
  AND square_meters > 15
GROUP BY distance
ORDER BY distance;


-- Top 10 Most Expensive Apartments in each city (sales only)
WITH ranked AS (
    SELECT city, type, square_meters, build_year, price,
    ROUND(price/square_meters) AS price_per_sqm,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY ROUND(price / square_meters) DESC) as row_num,
    date_month
    FROM apartments
    WHERE offer_type = 'sale'
    AND square_meters > 15
    AND type != 'Unknown'
)
SELECT * 
FROM ranked
WHERE row_num <= 10
ORDER BY city, row_num;

-- Most Expensive Apartments in each city (sales only)
WITH ranked AS (
    SELECT city, type, square_meters, build_year, price,
    ROUND(price/square_meters) AS price_per_sqm,
    ROW_NUMBER() OVER (PARTITION BY city ORDER BY ROUND(price / square_meters) DESC) as row_num,
    date_month
    FROM apartments
    WHERE offer_type = 'sale'
    AND square_meters > 15
    AND type != 'Unknown'
)
SELECT * 
FROM ranked
WHERE row_num = 1
ORDER BY price_per_sqm DESC;
    