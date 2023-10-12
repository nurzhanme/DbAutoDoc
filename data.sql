CREATE TABLE users (
    user_id serial PRIMARY KEY,
    username varchar(50) NOT NULL,
    email varchar(100) NOT NULL,
    password_hash text NOT NULL
);

CREATE TABLE products (
    product_id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    description text,
    price numeric(10, 2) NOT NULL,
    stock_quantity integer NOT NULL
);

CREATE TABLE categories (
    category_id serial PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE product_categories (
    product_id integer REFERENCES products (product_id),
    category_id integer REFERENCES categories (category_id),
    PRIMARY KEY (product_id, category_id)
);

CREATE TABLE orders (
    order_id serial PRIMARY KEY,
    user_id integer REFERENCES users (user_id),
    order_date timestamp,
    status varchar(20)
);

CREATE TABLE order_items (
    order_item_id serial PRIMARY KEY,
    order_id integer REFERENCES orders (order_id),
    product_id integer REFERENCES products (product_id),
    quantity integer,
    item_price numeric(10, 2)
);

CREATE TABLE addresses (
    address_id serial PRIMARY KEY,
    user_id integer REFERENCES users (user_id),
    street_address text,
    city varchar(50),
    state varchar(50),
    zip_code varchar(10)
);

CREATE TABLE reviews (
    review_id serial PRIMARY KEY,
    product_id integer REFERENCES products (product_id),
    user_id integer REFERENCES users (user_id),
    rating smallint,
    comment text,
    review_date timestamp
);

CREATE TABLE payment_methods (
    payment_method_id serial PRIMARY KEY,
    user_id integer REFERENCES users (user_id),
    type varchar(20),
    account_number varchar(20)
);

CREATE TABLE wishlist (
    wishlist_id serial PRIMARY KEY,
    user_id integer REFERENCES users (user_id),
    product_id integer REFERENCES products (product_id)
);


-- Generating Fake User Data
INSERT INTO users (username, email, password_hash)
VALUES
    ('john', 'john@example.com', 'psw1'),
    ('mike', 'mike@example.com', 'psw2'),
    ('frank', 'frank@example.com', 'psw3');

-- Generating Fake Product Data
INSERT INTO products (name, description, price, stock_quantity)
VALUES
    ('Super smartphone', 'Description for Super smartphone', 119.99, 100),
    ('Smart watch', 'Description for Smart watch', 29.99, 50),
    ('Superpod', 'Description for Superpod', 9.99, 200);

-- Generating Fake Category Data
INSERT INTO categories (name)
VALUES
    ('Smartphones'),
    ('Watches'),
    ('Headsets');
	
-- Generating Fake Product-Category Associations
INSERT INTO product_categories (product_id, category_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);;
	
-- Generating Fake Order Data
INSERT INTO orders (user_id, order_date, status)
VALUES
    (1, now(), 'Pending'),
    (2, now(), 'Shipped'),
    (3, now(), 'Delivered');
	
-- Generating Fake Order Item Data
INSERT INTO order_items (order_id, product_id, quantity, item_price)
VALUES
    (1, 1, 1, 119.99),
    (1, 2, 1, 29.99),
    (2, 3, 1, 9.99),
	(3, 1, 1, 119.99);
    
-- Generating Fake Address Data
INSERT INTO addresses (user_id, street_address, city, state, zip_code)
VALUES
    (1, '123 Main St', 'New City', 'New City State', '12345'),
    (1, '456 Elm St', 'West City', 'West City State', '67890'),
    (2, '789 Oak St', 'Old City', 'Old City State', '13579');
	
-- Generating Fake Review Data
INSERT INTO reviews (product_id, user_id, rating, comment, review_date)
VALUES
    (1, 1, 4, 'Great product!', now()),
    (2, 2, 5, 'Excellent!', now()),
    (3, 3, 3, 'Not bad.', now());
	
-- Generating Fake Payment Method Data
INSERT INTO payment_methods (user_id, type, account_number)
VALUES
    (1, 'Credit Card', '1234-5678-9012-3456'),
    (2, 'PayPal', 'mike@example.com'),
    (3, 'Credit Card', '9876-5432-1098-7654');
	
-- Generating Fake Wishlist Data
INSERT INTO wishlist (user_id, product_id)
VALUES
    (1, 2),
    (1, 3),
    (2, 1);
