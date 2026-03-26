SELECT *
FROM apartments a
LIMIT 10;

-- ROI - Return on Investment by City
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

-- ROI - Return on Investment by building type (Что окупается быстрее через сдачу в аренду)
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


-- Average age per building type
SELECT type, ROUND(AVG(buildyear), 2)
FROM apartments
WHERE buildyear IS NOT NULL
AND type != 'Unknown'
GROUP BY type;


-- Difference between premium and basic apartments prices
WITH premium AS (
    SELECT AVG(price / squaremeters) AS price_per_sqm
    FROM apartments
    WHERE offer_type = 'sale'
      AND has_parking_space = 'yes'
      AND has_balcony = 'yes'
),
basic AS (
    SELECT AVG(price / squaremeters) AS price_per_sqm
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

SELECT type, AVG(price / squaremeters) AS price_per_sqm
FROM apartments
WHERE offer_type = 'sale'
GROUP BY type;