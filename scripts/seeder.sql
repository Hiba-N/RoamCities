-- Create  schema if it does not exist
CREATE SCHEMA IF NOT EXISTS "roam_cities";

CREATE EXTENSION IF NOT EXISTS "postgis";

-- Set the schema for the following table creations
SET
    search_path TO "roam_cities";

-- Create city table if it doesn't exist
CREATE TABLE IF NOT EXISTS city (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    center GEOMETRY(POINT, 4326),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT
);

-- Create role table if it doesn't exist
CREATE TABLE IF NOT EXISTS role (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

-- Create user table if it doesn't exist
CREATE TABLE IF NOT EXISTS user (
    id SERIAL PRIMARY KEY,
    username VARCHAR NOT NULL,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE SET NULL
);

-- Create layer_type table if it doesn't exist
CREATE TABLE IF NOT EXISTS layer_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

-- Create layer table if it doesn't exist
CREATE TABLE IF NOT EXISTS layer (
    id SERIAL PRIMARY KEY,
    type INT,
    geometry GEOMETRY(GEOMETRY, 4326),
    city_id INT,
    layer_type_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    updated_by INT,
    FOREIGN KEY (city_id) REFERENCES city(id) ON DELETE CASCADE,
    FOREIGN KEY (layer_type_id) REFERENCES layer_type(id) ON DELETE SET NULL
);

-- Create outline table if it doesn't exist
CREATE TABLE IF NOT EXISTS outline (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    geometry GEOMETRY(GEOMETRY, 4326),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES city(id) ON DELETE CASCADE
);

-- Create user_favorites table if it doesn't exist
CREATE TABLE IF NOT EXISTS user_favorites (
    id SERIAL PRIMARY KEY,
    user_id INT,
    city_id INT,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (city_id) REFERENCES city(id) ON DELETE CASCADE
);
