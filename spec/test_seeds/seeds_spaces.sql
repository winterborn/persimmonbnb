DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "listed_spaces";

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text, email text, password text
);

CREATE TABLE listed_spaces (
  id SERIAL PRIMARY KEY,
  space_name text, space_description text, space_price int,
  start_date date, end_date date, booked boolean,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE listed_spaces RESTART IDENTITY;

INSERT INTO users (name, email, password) VALUES ('Brit', 'makers@hotmail.com', 'password123');
INSERT INTO users (name, email, password) VALUES ('Nas', 'nas@gmail.com', 'password123');
INSERT INTO users (name, email, password) VALUES ('Phil', 'phil@hotmail.com', 'password123');
INSERT INTO users (name, email, password) VALUES ('Kevwe', 'kevwe@gmail.com', 'password123');
INSERT INTO users (name, email, password) VALUES ('roi', 'roi@hotmail.com', 'password123');

INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Cottage', 'A lovely, three bedroom cottage.', 100, '2022-09-05', '2022-09-10', false, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Apartment', 'A high-rise apartment in central London.', 200, '2022-09-08', '2022-09-16', true, 2);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('House', 'A house in leafy Richmond.', 600, '2022-09-12', '2022-09-30', false, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Flat', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas', 95, '2022-10-14', '2022-12-27', false, 5);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Garage', 'fficia deserunt mollitia animi, id est laborum et dolorum', 105, '2023-08-14', '2023-12-27', true, 3);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Shed', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas', 55, '2021-11-01', '2022-10-07', false, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Room', 'At vero eos et accusamptatum deleniti atque corrupti quos dolores et quas', 10, '2022-12-14', '2023-05-30', true, 2);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Studio', 'At vero eofficia deserunt mollitia animi, id est laborum et dolorumaesentium voluptatum deleniti atq', 200, '2022-01-01', '2022-09-10', false, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Room Share', 'At vero eos etpti quos dolores et quas', 100, '2021-07-11', '2022-09-30', false, 3);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Garage', 'landitiis praesentium voluptatum deleniti atque corrupti quos dolores et quas', 12, '2022-09-09', '2022-09-14', false, 4);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Barn', 'At vero eos et accusamus et iusto odio dignissiuptatum deleniti atque corrupti quos dolores et quas', 175, '2023-02-14', '2024-02-23', true, 3);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Hut', 'et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas', 45, '2022-08-14', '2022-10-03', true, 5);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Apartment', 'praesentium voluptatum deleniti atque corrupti quos dolores et quas', 400, '2022-08-01', '2022-08-12', false, 2);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Warehouse', 'raesentium voluptatum deleniti atque corrupti quos dolores et quas', 1005, '2022-12-14', '2022-12-30', true, 4);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Shop', 'dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas', 746, '2022-10-01', '2029-12-01', false, 2);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Hall', 'eleniti atque corrupti quos dolores et quas', 55, '2022-10-14', '2023-01-01', true, 5);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Green', 'atque corrupti quos dolores et quas', 0, '2022-08-14', '2022-09-09', true, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('First Floor Flat', 'Asentium voluptatum deleniti atque corrupti quos dolores et quas', 230, '2022-07-01', '2022-09-09', false, 5);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Office', 'praesentium voluptatum deleniti atque corrupti quos dolores et quas', 105, '2022-09-29', '2023-12-27', false, 3);
INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ('Cafe', 'is praesentium voluptatum deleniti atque corrupti quos dolores et quas', 85, '2022-10-10', '2022-10-19', true, 1);