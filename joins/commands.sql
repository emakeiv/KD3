-- INNER
SELECT o.id, c.first_name, c.last_name, o.date_placed, o.shipping_price
FROM "Order" o INNER JOIN "Customer" c ON o.customer_id = c.id;

-- LEFT OUTER
SELECT 
    p.id, 
    i.quantity
FROM "Product" p 
LEFT OUTER JOIN "Inventory" i ON p.id = i.product_id AND i.quantity > 10
WHERE p.cost_price > 100.0;

-- RIGHT OUTER
SELECT 
    o.id , 
    o.date_placed, 
    c.first_name, 
    c.last_name 
FROM "Order" o
RIGHT OUTER JOIN "Customer" c ON o.customer_id = c.id
WHERE o.shipping_price < 10;

-- FULL OUTER
SELECT 
    c.id, 
    c.first_name, 
    c.last_name, 
    o.id,
    o.date_placed
FROM "Customer" c
FULL OUTER JOIN "Order" o ON c.id = o.customer_id;

-- SELF
SELECT 
    c1.id,
    c1.last_name, 
    c2.id,
    c2.last_name
FROM "Customer" c1
INNER JOIN "Customer" c2 
    ON c1.last_name = c2.last_name
    AND c1.id < c2.id
ORDER BY c1.last_name, c1.id;

-- CROSS
SELECT 
    p1.id,
    p1.name,
    p2.id,
    p2.name
FROM "Product" p1
CROSS JOIN "Product" p2
WHERE p1.id <> p2.id
  AND p1.category_id = p2.category_id
ORDER BY p1.id, p2.id;

-- NATURAL 
SELECT ol.order_id, ol.product_id, p.name, ol.quantity
FROM "OrderLine" ol NATURAL JOIN "Product" p
ORDER BY ol.order_id, ol.product_id;

