CREATE OR REPLACE FUNCTION update_order_total_price()
RETURNS TRIGGER AS $$
DECLARE
    total_quantity INTEGER;
    discount_factor DECIMAL(3,2);
BEGIN
    -- Calculate total quantity for the order
    SELECT SUM(quantity) INTO total_quantity
    FROM order_details
    WHERE order_id = NEW.order_id;

    -- Determine discount factor based on total quantity
    IF total_quantity >= 50 THEN
        discount_factor := 0.70;
    ELSIF total_quantity >= 20 THEN
        discount_factor := 0.80;
    ELSIF total_quantity >= 10 THEN
        discount_factor := 0.90;
    ELSIF total_quantity >= 2 THEN
        discount_factor := 0.95;
    ELSE
        discount_factor := 1.00;
    END IF;

    -- Update the total_price in the orders table
    UPDATE orders
    SET total_price = (
        SELECT SUM(
            ((od.length * od.width * 2) + (od.length * od.height * 2) + (od.width * od.height * 2)) / 1000000.0 * f.price_m2 * od.quantity
        ) * discount_factor
        FROM order_details od
        JOIN finish f ON od.finish_id = f.id
        WHERE od.order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ensure the trigger is properly set
CREATE TRIGGER update_order_total_price_trigger
AFTER INSERT OR UPDATE OR DELETE ON order_details
FOR EACH ROW
EXECUTE FUNCTION update_order_total_price();