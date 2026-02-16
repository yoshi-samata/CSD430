
-- Create DB + user + table
-- Josh Martin 02/05/26 Module 5 assignment
-- Instructor: David Ostrowski


CREATE DATABASE IF NOT EXISTS csd430;
USE csd430;

-- Create the student user (run as root/admin)
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON csd430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- Drop + recreate table 
DROP TABLE IF EXISTS josh_movies_data;

CREATE TABLE josh_movies_data (
  movie_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(150) NOT NULL,
  release_year INT NOT NULL,
  genre VARCHAR(60) NOT NULL,
  rating DECIMAL(2,1) NOT NULL,
  director VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (movie_id)
);

-- =========================
-- Populate table (10 rows)
-- =========================

INSERT INTO josh_movies_data (title, release_year, genre, rating, director) VALUES
('Iron Man', 2008, 'Superhero', 7.9, 'Jon Favreau'),
('The Incredible Hulk', 2008, 'Superhero', 6.6, 'Louis Leterrier'),
('Thor', 2011, 'Superhero', 7.0, 'Kenneth Branagh'),
('Captain America: The First Avenger', 2011, 'Superhero', 6.9, 'Joe Johnston'),
('The Avengers', 2012, 'Superhero', 8.0, 'Joss Whedon'),
('Captain America: The Winter Soldier', 2014, 'Superhero', 7.8, 'Anthony Russo, Joe Russo'),
('Guardians of the Galaxy', 2014, 'Superhero', 8.0, 'James Gunn'),
('Black Panther', 2018, 'Superhero', 7.3, 'Ryan Coogler'),
('Avengers: Infinity War', 2018, 'Superhero', 8.4, 'Anthony Russo, Joe Russo'),
('Avengers: Endgame', 2019, 'Superhero', 8.4, 'Anthony Russo, Joe Russo');


SELECT * FROM josh_movies_data;

DROP TABLE IF EXISTS josh_movies_data;
DROP DATABASE IF EXISTS csd430;

