SELECT 
    name,
    weight,
    price,
    round(cast(price / (weight / 1000.0) as numeric), 2) as price_per_kg
FROM 
    products
ORDER BY 
    price_per_kg asc,
    name asc;
