-- ROI - Return on Investment BY CITY
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

-- ROI - Return on Investment BY BUILDING TYPE (Что окупается быстрее через сдачу в аренду)
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
