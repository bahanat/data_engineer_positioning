CREATE TABLE clients (
  id VARCHAR(6) PRIMARY KEY CHECK (id ~ '^[a-z]{2}-\d{3}$'),
  name VARCHAR(255),
  created_at TIMESTAMP
);

CREATE TABLE orders (
  id INT PRIMARY KEY,
  client_id VARCHAR(6),
  total_price DECIMAL(10, 2),
  created_at TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients (id)
);

CREATE TABLE materials (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  price_m2 DECIMAL(10, 2)
);

CREATE TABLE colors (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  price_m2 DECIMAL(10, 2)
);

CREATE TABLE finish (
  id INT PRIMARY KEY,
  material_id INT,
  color_id INT,
  price_m2 DECIMAL(10, 2),
  FOREIGN KEY (material_id) REFERENCES materials (id),
  FOREIGN KEY (color_id) REFERENCES colors (id)
);

CREATE TABLE order_details (
  id INT PRIMARY KEY,
  order_id INT,
  finish_id INT,
  quantity INT,
  length INT,
  width INT,
  height INT,
  FOREIGN KEY (order_id) REFERENCES orders (id),
  FOREIGN KEY (finish_id) REFERENCES finish (id),
  CONSTRAINT check_length CHECK (length BETWEEN 1 AND 1000),
  CONSTRAINT check_width CHECK (width BETWEEN 1 AND 1000),
  CONSTRAINT check_height CHECK (height BETWEEN 1 AND 1000)
);