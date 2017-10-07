DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS times;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  customer_name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  cost INT4
);

CREATE TABLE times (
  id SERIAL4 PRIMARY KEY,
  scheduled_for INT4,
  film_id INT4 REFERENCES films(id)
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id),
  film_id INT4 REFERENCES films(id)
);
