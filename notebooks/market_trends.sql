-- Typical Rental vs. For-Sale Apartments in each city
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


-- The impact of floor level on price
SELECT
    CASE
        WHEN floor = 0 THEN 'Ground floor (Parter)'
        WHEN floor BETWEEN 1 AND 3 THEN '1-3 floor'
        WHEN floor BETWEEN 4 AND 7 THEN '4-7 floor'
        WHEN floor BETWEEN 8 AND 15 THEN '8-15 floor'
        ELSE '16+'
    END AS floor_group,
    COUNT(*) AS listings,
    ROUND(AVG(price / square_meters), 0) AS avg_price_per_sqm
FROM apartments
WHERE offer_type = 'sale' AND square_meters > 0
GROUP BY floor_group
ORDER BY floor_group;


-- How the price changed month by month
SELECT
    date_month,
    offer_type,
    ROUND(AVG(price), 0) AS avg_price,
    ROUND(AVG(price / square_meters), 0) AS avg_price_per_sqm,
    COUNT(*) AS count
FROM apartments
WHERE square_meters > 0
GROUP BY date_month, offer_type
ORDER BY date_month, offer_type;
