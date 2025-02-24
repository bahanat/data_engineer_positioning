CREATE OR REPLACE FUNCTION set_created_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_clients_created_at_trigger
BEFORE INSERT ON clients
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_orders_created_at_trigger
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION set_created_at();