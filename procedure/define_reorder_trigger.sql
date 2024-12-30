CREATE FUNCTION reorder_trigger() RETURNS trigger AS $$
DECLARE
    mq INTEGER;
    product_record RECORD;
BEGIN
    mq := tg_argv[0];
    raise notice 'in trigger, mq is %', mq;
    IF new.quantity <= mq
    THEN
        SELECT * INTO product_record FROM "Product"
        WHERE id = new.id;
        INSERT INTO "Reorders" VALUES (new.id, product_record.description);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;