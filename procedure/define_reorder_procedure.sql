DROP TABLE IF EXISTS "Reorders";

CREATE TABLE IF NOT EXISTS "Reorders"(
    product_id integer,
    message text
);

CREATE OR REPLACE FUNCTION reorders(min_stock INT)
RETURNS INTEGER AS $$
DECLARE
    reorder_item INTEGER;
    reorder_count INTEGER;
    inventory_row RECORD;
    product_row RECORD;
    msg text;
BEGIN
    SELECT count(*) INTO reorder_count 
    FROM "Inventory"
    WHERE quantity <= min_stock;
    
    FOR inventory_row IN 
        SELECT * FROM "Inventory" 
        WHERE quantity <= min_stock
    
    LOOP
        BEGIN
            SELECT * INTO product_row 
            FROM "Product"
            WHERE id = inventory_row.product_id;

            msg = 'Order more ' || product_row.description || 's at ' ||
                to_char(product_row.cost_price, '99.99');

            INSERT INTO "Reorders" (product_id, message) 
            VALUES (inventory_row.product_id, msg);
        END;
    END LOOP;
    RETURN reorder_count;
END;
$$ LANGUAGE plpgsql;