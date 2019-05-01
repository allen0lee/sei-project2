create database photo_sharing_app;

create table photos(
    id SERIAL PRIMARY KEY,
    name TEXT,
    image_url TEXT,
    user_id INTEGER,
    album_id INTEGER
);

create table users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(500),
    password_digest VARCHAR(500)
);

create table comments(
    id SERIAL PRIMARY KEY,
    content TEXT,
    photo_id INTEGER,
    album_id INTEGER,
    user_id INTEGER
);

create table albums(
    id SERIAL PRIMARY KEY,
    name TEXT,
    theme_image_url TEXT,
    user_id INTEGER
);