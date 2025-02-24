CREATE OR REPLACE FUNCTION update_finish_price()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'finish' THEN
        NEW.price_m2 = (
            SELECT (m.price_m2 + c.price_m2)
            FROM materials m, colors c
            WHERE m.id = NEW.material_id AND c.id = NEW.color_id
        );
    ELSIF TG_TABLE_NAME IN ('materials', 'colors') THEN
        UPDATE finish
        SET price_m2 = m.price_m2 + c.price_m2
        FROM materials m, colors c
        WHERE finish.material_id = m.id AND finish.color_id = c.id
        AND (m.id = NEW.id OR c.id = NEW.id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_finish_price_trigger
BEFORE INSERT OR UPDATE ON finish
FOR EACH ROW
EXECUTE FUNCTION update_finish_price();

CREATE TRIGGER update_materials_price_trigger
AFTER UPDATE ON materials
FOR EACH ROW
EXECUTE FUNCTION update_finish_price();

CREATE TRIGGER update_colors_price_trigger
AFTER UPDATE ON colors
FOR EACH ROW
EXECUTE FUNCTION update_finish_price();